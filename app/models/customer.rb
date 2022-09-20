class Customer
  include Mongoid::Document
  include MongoidClientSideEncryption::Encryptable

  enable_mongodb_client_encryption encrypt_metadata: { key_id: "3a18c652-0dc5-4453-8c7c-8796ab7b7032" }

  field :first_name, type: String, encrypt: {
    algorithm: 'AEAD_AES_256_CBC_HMAC_SHA_512-Deterministic',
    key_id: "3a18c652-0dc5-4453-8c7c-8796ab7b7032"
  }

  field :last_name, type: String, encrypt: {
    algorithm: 'AEAD_AES_256_CBC_HMAC_SHA_512-Deterministic',
    key_id: "3a18c652-0dc5-4453-8c7c-8796ab7b7032"
  }

  field :comment, type: String
end
