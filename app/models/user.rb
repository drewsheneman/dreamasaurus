# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
	                uniqueness: { case_sensitive: false }


    before_save { self.email = email.downcase }
    before_save { email.downcase! }
    before_create :create_remember_token

    has_secure_password
    validates :password, length: { minimum: 6 }

    has_many :dreams, dependent: :destroy

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
    	# This is preliminary.
    	Dream.where("user_id = ?", id)
  	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end
end
