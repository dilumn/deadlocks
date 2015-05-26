require 'celluloid'

class User
	include Celluloid

	def create(user)
		puts "create"
		exclusive do
			sleep 5
			user.create_two
		end
	end

	def create_two
		puts "create_two"
		exclusive do
			sleep 3
		end
	end

	def running(user)
		puts "running"
		user.create(user)
		puts "running finish"
	end
end

user1 = User.new
user2 = User.new

user1.async.create(user2)
user1.running(user1)

puts "finishes"