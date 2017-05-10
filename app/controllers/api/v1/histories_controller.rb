class Api::V1::HistoriesController < Api::V1::ApiController
	def index
		@histories = HistoryService::Fetch.new(current_user_id).run
	end
end
