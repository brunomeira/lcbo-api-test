class History
	class SQL < SQLRecord
		self.table_name = 'histories'
		belongs_to :user
	end

	class NoSQL < RedisRecord
		attr_accessor :user, :data

		def initialize(user, data = nil)
			@user = user
			@data = data
		end

		#
		# Defines key used on redis
		# @return [String]
		#
		def key
			self.class.key(user)
		end

		#
		# Saves data to proper user:history:viewed_products hash
		# @raise if data param is not in a json format
		# @param data [String] must be in a json format
		# @return [Boolean]
		#
		def save(data)
			fail 'Data must be JSON formatted' unless json_format?(data)
			redis.lpush key, data
		end

		#
		# Defines key used on redis
		# @return [String]
		#
		def self.key(user)
			"#{user}:history"
		end

		#
		# Fetches N elements saved on Redis. By default it searches the first 10 elements 0-9
		# @param user [Integer] ID of user
		# @param page [Integer] defaults to 0
		# @param per_page [Integer] defaults to 9
		# @return [Array<History::NoSQL>]
		#
		def self.fetch(user, page = 0, per_page = 9)
			results = []
			offset = page * per_page
			per_page = (offset + per_page) if page > 0

			results = redis.lrange key(user), offset, per_page

			if results.present?
				results = build_result_list(user, results)
			end

			results
		end

		private

		def json_format?(data)
			JSON.parse(data)
		rescue
			false
		end

		def self.build_result_list(user, results)
			results.map { |result| History::NoSQL.new(user, JSON.parse(result)) }
		end

		private_class_method :build_result_list
	end
end
