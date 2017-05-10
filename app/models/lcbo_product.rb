class LCBOProduct
	include LCBOHttpConnector

	attr_accessor :id, :data

	def initialize(id, data = nil)
		@id = id
		@data = data
	end

	#
	# Fetches product data associated with id and assign value to #data
	# @return [LCBOProduct] with #data assigned to it
	#
	def fetch
		self.data = self.class.get "products/#{@id}"
		self
	end

	#
	# Fetches a list of products based on criteria specified on params
	# @param params [Hash] passed to request
	# @return [Array] of all LCBOProduct
	#
	def self.fetch(params)
		results = get 'products', params
		build_result_list(results)
	end

	def self.build_result_list(results)
		results.map { |result| LCBOProduct.new(result.id, result)	}
	end

	private_class_method :build_result_list
end
