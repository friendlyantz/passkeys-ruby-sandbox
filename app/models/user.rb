class User < ApplicationRecord
  after_initialize do
    self.webauthn_id ||= WebAuthn.generate_user_id
  end
end
