class User < ActiveRecord::Base
  attr_accessible :email, :session_token, :password
  attr_reader :password
  
  before_validation :ensure_session_token
  
  validates :email, :session_token, :presence => true
  validates :password_digest, :presence => { :message => "Password can't be blank" }
  validates :password, :length => { :minimum => 5, :allow_nil => true }
  
  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
    # write_attribute(:password_digest, BCrypt::Password.create(secret))
  end
  
  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end
  
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end
  
   def self.generate_session_token
    SecureRandom.base64.html_safe
  end
  
  def self.find_by_credentials(email, secret)
    u = User.find_by_email(email)
    (u && u.is_password?(secret)) ? u : nil
  end 
    
  private 
  def ensure_session_token
  if self.session_token.nil?
    self.session_token = User.generate_session_token
  end
  end
end