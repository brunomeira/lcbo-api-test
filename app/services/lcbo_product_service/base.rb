module LCBOProductService
	class Base
		def initialize(user)
			@user = user
		end

		protected

		attr_reader :user
	end
end
