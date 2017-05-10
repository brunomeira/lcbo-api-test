class Api::V1::LcboProductsController < Api::V1::ApiController
	def index
		@products = load_products(params[:special_action])
	end

	def show
		@product = LCBOProductService::Fetch.new(current_user_id, params[:id]).run
	end

	private

	def load_products(special_action)
		case special_action
		when 'feeling_lucky'
			[LCBOProductService::Fetch.feeling_lucky(current_user_id, q: params[:text])].compact
		else
			LCBOProductService::Fetch.run(current_user_id, q: params[:text])
		end
	end
end
