public class Tokenizer {
    /// The ``Model`` in use by the Tokenizer
    let model: Model

    public init(_ model: Model) {
        self.model = model
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
