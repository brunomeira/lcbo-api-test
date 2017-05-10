module LCBOProductService
	class Fetch < LCBOProductService::Base
		attr_reader :id

		def initialize(user, id)
			super(user)
			@id = id
		end

		#
		# Returns data for an specific product. It also records action on History and View Product models
		# @return [LCBOProduct]
		#
		def run
			result = LCBOProduct.new(id).fetch
			self.class.log_view_product(user, id)
			result
		end

		#
		# Returns a list of found products by query asked by user. It also records action on History model
		# @param user [Integer] Id of user
		# @param params [Hash] query asked by user
		#
		# @return [Array<LCBOProduct>]
		#
		def self.run(user, params)
			results = fetch_products(params)
			log_view_products(user, params)
			results
		end

		#
		# Returns one element that has not been viewed by user and stores found result on History model.
		#
		# @param user [Interger] ID of user
		# @param params [Hash] query associated with random search
		# @return [LCBOProduct] with data of element found by random search
		#
		# @note Ideally this method should iterate through page numbers
		#  until one option that was not already viewed is found OR the response
		#  from the API returns a []. At this point all elements for that query search
		#  were already viewed by the user. No need to implement this for now.
		def self.feeling_lucky(user, params)
			results = fetch_products(params)
			random = nil

			return random if results.blank?

			while results.present? && random.blank?
				random = results.delete results.sample
				random = nil if ViewProduct::NoSQL.viewed?(user, random.data.id)
			end

			log_view_product(user, random.id) if random

			random
		end

		private

		def self.log_view_product(user, id)
			return if user.blank? || id.blank?

			HistoryService::Create.new(user, :view_product, id).run do
				ViewProduct::NoSQL.new(user).save(id)
			end
		end

		def self.log_view_products(user, params)
			return if params[:q].blank? || user.blank?
			HistoryService::Create.new(user, :search_products, params[:q]).run
		end

		def self.fetch_products(params)
			LCBOProduct.fetch(params)
		end

		private_class_method :fetch_products
	end
end
