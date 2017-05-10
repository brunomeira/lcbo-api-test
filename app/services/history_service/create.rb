module HistoryService
	class Create < HistoryService::Base
		def initialize(user, action, value)
			super(user)

			@action = action
			@value = value
			@datetime = DateTime.now.utc
			@data = {
				action: action,
				value: value,
				datetime: datetime.to_s
			}
		end

		#
		# Stores History on SQL database and Redis
		#
		def run
			History::SQL.create(user_id: user, data: data)
			History::NoSQL.new(user).save(data.to_json)

			yield if block_given?
		end
	end
end
