require 'securerandom'

class User < SQLRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:recoverable, :rememberable, :trackable, :validatable

	before_save :ensure_auth_token

	def ensure_auth_token
		if auth_token.blank?
			self.auth_token = generate_auth_token
		end
	end

	private

	def generate_auth_token
		SecureRandom.uuid.gsub(/\-/,'')
	end
end
