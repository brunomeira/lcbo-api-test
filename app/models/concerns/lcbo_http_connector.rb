module LCBOHttpConnector
	BASE_URL = 'https://lcboapi.com'

	extend ActiveSupport::Concern

	class_methods do
		def get(endpoint, params={})
			conn = connection

			response = conn.get endpoint, params
			json_body = JSON.parse(response.body)

			if response.status == 200
				if json_body['result'].is_a? Array
					json_body['result'].map { |result| OpenStruct.new(result) }
				else
					OpenStruct.new(json_body['result'])
				end
			else
				json_body
			end
		end

		private
		def connection
			@@connection ||= Faraday.new(url: BASE_URL) do |faraday|
				faraday.token_auth(Rails.application.secrets.lcbo_api_access_key)
				faraday.response :logger
				faraday.adapter Faraday.default_adapter
				faraday.headers['Content-Type'] = 'application/json'
			end
		end
	end
end


