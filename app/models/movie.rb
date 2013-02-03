class Movie < ActiveRecord::Base
	def self.ratings
		%w(G PG R PG-13)
	end
end


