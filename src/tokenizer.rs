use super::error::Result;
use std::sync::{Arc, RwLock};
use tk::AddedToken;
use tokenizers as tk;

pub struct RustTokenizer {
    tokenizer: Arc<tk::tokenizer::Tokenizer>,
}

impl RustTokenizer {
    pub fn from_pretrained(
        identifier: &str,
        revision: String,
        auth_token: Option<String>,
    ) -> Result<Self> {
        let params = tk::FromPretrainedParameters {
            revision,
            auth_token,
            user_agent: [("bindings", "Swift"), ("version", crate::VERSION)]
                .iter()
                .map(|(k, v)| (k.to_string(), v.to_string()))
                .collect(),
        };
        let tokenizer = tk::tokenizer::Tokenizer::from_pretrained(identifier, Some(params))?;

        Ok(Self {
            tokenizer: Arc::new(tokenizer),
        })
    }

    pub fn encode(&self, input: &str, add_special_tokens: bool) -> Result<Arc<RustEncoding>> {
        let encoding = self
            .tokenizer
            .encode_char_offsets(input, add_special_tokens)?;

        Ok(Arc::new(RustEncoding::new(Arc::new(encoding))))
    }
}

//MARK: Encoding

pub struct RustEncoding {
    encoding: Arc<tk::tokenizer::Encoding>,
}

impl RustEncoding {
    pub fn new(encoding: Arc<tk::tokenizer::Encoding>) -> Self {
        Self { encoding }
    }

    pub fn get_tokens(&self) -> Vec<String> {
        self.encoding.get_tokens().to_vec()
    }
}

//MARK: Added Tokens
pub struct RustAddedToken {
    token: Arc<RwLock<AddedToken>>,
}

impl RustAddedToken {
    /// Clone the underlying token.
    pub fn clone_token(&self) -> AddedToken {
        self.token.read().unwrap().clone()
    }
}

impl From<tk::AddedToken> for RustAddedToken {
    fn from(token: tk::AddedToken) -> Self {
        Self {
            token: Arc::new(RwLock::new(token)),
        }
    }
}

// Export
impl RustAddedToken {
    pub fn new(
        content: &str,
        single_word: Option<bool>,
        lstrip: Option<bool>,
        rstrip: Option<bool>,
        normalized: Option<bool>,
        special: Option<bool>,
    ) -> Self {
        let mut token = AddedToken::from(content, special.unwrap_or(false));

        if let Some(single_word) = single_word {
            token.single_word = single_word;
        }
        if let Some(lstrip) = lstrip {
            token.lstrip = lstrip;
        }
        if let Some(rstrip) = rstrip {
            token.rstrip = rstrip;
        }
        if let Some(normalized) = normalized {
            token.normalized = normalized;
        }

        Self {
            token: Arc::new(RwLock::new(token)),
        }
    }

    pub fn get_content(&self) -> String {
        self.token.read().unwrap().content.clone()
    }

    pub fn get_lstrip(&self) -> bool {
        self.token.read().unwrap().lstrip
    }

    pub fn get_rstrip(&self) -> bool {
        self.token.read().unwrap().rstrip
    }

    pub fn get_normalized(&self) -> bool {
        self.token.read().unwrap().normalized
    }

    pub fn get_single_word(&self) -> bool {
        self.token.read().unwrap().single_word
    }

    pub fn get_special(&self) -> bool {
        self.token.read().unwrap().special
    }
}
