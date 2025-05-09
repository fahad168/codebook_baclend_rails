class JsonWebTokenService
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, expiry = 600.hours.from_now)
    # def self.encode(payload)
    payload[:exp] = expiry.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end