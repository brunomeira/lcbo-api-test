module HistoryService
	class Base
		def initialize(user)
			@user = user
		end

		protected

		attr_reader :action, :value, :user, :datetime, :data
	end
end
