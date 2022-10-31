import TokenizersFFI

public class Tokenizer {
    /// The ``Model`` in use by the Tokenizer
    let model: Model

    /// The optional ``PreTokenizer`` in use by the Tokenizer
    var pre_tokenizer: PreTokenizer?

    public init(_ model: Model) {
        self.model = model
    }

    public func hello() {
        hello_world()
    }
}

/// Base class for all models
///
/// The model represents the actual tokenization **algorithm**.
/// This is the part that will contain and manage the learned vocabulary.
public class Model {

}

/// An implementation of the BPE (Byte-Pair Encoding) algorithm
public class BPE: Model {
    ///
    /// - Parameters:
    ///   - unk_token: The unknown token to be used when we encounter an unknown char
    ///   - fuse_unk: Do multiple unk tokens get fused
    public init(unk_token: String? = nil, fuse_unk: Bool = false) {

    }
}

//MARK: - Pre-tokenizers

/// Base class for all pre-tokenizers
///
/// This class is not supposed to be instantiated directly. Instead, any implementation of
/// a PreTokenizer will return an instance of this class when instantiated.
public class PreTokenizer {

}

public class Whitespace: PreTokenizer {}

//MARK: - Trainers

/// Base class for all trainers
///
/// This class is not supposed to be instantiated directly. Instead, any implementation of a
/// Trainer will return an instance of this class when instantiated.
public class Trainer {

}

/// Trainer capable of training a BPE model
public class BpeTrainer: Trainer {

    public init(special_tokens: [String]) {

    }
}
