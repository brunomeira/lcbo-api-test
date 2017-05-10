class RedisRecord
	def redis
		self.class.redis
	end

	def self.redis
		$redis
	end
end
