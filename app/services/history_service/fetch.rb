module HistoryService
	class Fetch < HistoryService::Base
		def initialize(user)
			super(user)
		end

		#
		# Fetches histories associated with user. By default it search the first 10 attributes
		# It first checks if the data exists on Redis (In-memory), if nothing is found then it goes to SQL
		#
		# @param page [Integer]
		# @param per_page [Integer]
		#
		# @return [Array<HistoryService>]
		#
		# @note Due to time constraint reasons, I am not going to implement the whole algorithm here
		#  The idea, though, is to paginate through the list stored on Redis and then, if the data can't be find there,
		#  fetch the data on Postgres. For now it only fetches the 10 initial elements on Redis.
		def run(page=0, per_page = 10)
			return [] unless user

			results = cached_results(page, per_page)
			results = sql_search(page, per_page) if results.blank?

			results
		end

		private

		def cached_results(page, per_page)
			History::NoSQL.fetch(user, page, per_page)
		end

		def sql_search(page, per_page)
			page = 1 if page == 0
			History::SQL.paginate(page: page, per_page: per_page)
		end
	end
end
