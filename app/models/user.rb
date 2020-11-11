class User < ApplicationRecord
  has_one :cart, :foreign_key => :user_id, dependent: :destroy
  has_many :orders
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { in: 2..30 }
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :phone, presence: true, allow_nil: true, length: { maximum: 25 },
                            format: { with: VALID_PHONE_NUMBER_REGEX }
  RESET_TOKEN_LIFESPAN = 15.minutes
  attr_accessor :password

  PASSWORD_FORMAT = /\A(?!.*\s)/x.freeze
  validates :password, presence: true, length: { in: 6..40 },
                            format: { with: PASSWORD_FORMAT }, on: %i[create account_setup]
  before_create :encrypt_password
  scope :user_name, ->(search) { where('name ILIKE :search', search: "%#{search}%") if search }

  def update_password(password_params)
    raise(ArgumentError, 'Your password was incorrect.') unless check_valid_password(password_params[:old_password])

    self.password = password_params[:new_password]
    raise(ArgumentError, errors.messages) unless valid?(:account_setup)

    encrypt_password
    save!
  end

  def generate_password_token
    self.reset_password_token = SecureRandom.rand(100_000..999_999)
    self.reset_password_sent_at = Time.now
    save!
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_token_valid?(token)
    reset_password_token == token && password_reset_not_expired?
  end

  def password_reset_not_expired?
    Time.now < (reset_password_sent_at + RESET_TOKEN_LIFESPAN).localtime
  end

  def jwt_payload
    {
      user_id: id
    }
  end

  def encrypt_password
    self.encrypted_password = User.generate_encrypted_password(password)
  end

  def self.generate_encrypted_password(password, password_salt = BCrypt::Engine.generate_salt)
    BCrypt::Engine.hash_secret(password, password_salt)
  end

  def check_valid_password(password)
    encrypted_password == User.generate_encrypted_password(password, encrypted_password.first(29))
  end
end
