class Api::V1::ApiController < ApplicationController
	protect_from_forgery with: :null_session
	before_action :authenticate_user_from_token!

	private
	def authenticate_user_from_token!
		user_email = request.headers["X-API-EMAIL"].presence
		user_auth_token = request.headers["X-API-TOKEN"].presence
		user = user_email && User.find_by_email(user_email)

		# prevent timing attacks
		if user && Devise.secure_compare(user.auth_token, user_auth_token)
			sign_in(user, store: false)
		end
	end

	def current_user_id
		current_user.try(:id)
	end
end
