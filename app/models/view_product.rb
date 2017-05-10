class ViewProduct
	class NoSQL < RedisRecord
		attr_accessor :user, :id

		def initialize(user, id = nil)
			@user = user
			@id = id
		end

		#
		# Saves data to proper user:history:viewed_products hash
		# @param data [String] ID of viewed product
		# @return [Boolean]
		#
		def save(data)
			redis.sadd(key, data)
		end

		#
		# Defines key used on redis
		# @return [String]
		#
		def key
			self.class.key(user)
		end

		#
		# Defines key used on redis
		# @return [String]
		#
		def self.key(user)
			"#{user}:history:viewed_products"
		end

		#
		# Checks if id is already stored on set
		# @param user [Integer] ID of user
		# @param id [String] ID of product
		# @return [Boolean] representing if id is present or not in Hash
		#
		def self.viewed?(user, id)
			redis.sismember key(user), id
		end
	end
end
