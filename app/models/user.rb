class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  acts_as_google_authenticated lookup_token: :persistence_token, drift: 30, issuer: 'test_twofactor_auth'
  before_create {|record| record.persistence_token = SecureRandom.hex unless record.persistence_token }
  after_create {|record| record.set_google_secret }
end
