class User < ApplicationRecord
  has_many :credentials, dependent: :destroy

  after_initialize do
    self.webauthn_id ||= WebAuthn.generate_user_id
  end
  validates :webauthn_id, uniqueness: true
end
