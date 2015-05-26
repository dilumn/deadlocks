require 'celluloid'

class Account 
  include Celluloid
  # double balance;
  # int id;

  def initialize
    @mutex = Mutex.new
    @balance = 500
  end

  def withdraw(amount)
   @balance = @balance - amount;
 end

 def deposit(amount)
   @balance = @balance + amount;
 end

 def transfer(from, to, amount)
  puts "transfer"
  @mutex.lock
  puts "locked"
  from.withdraw(amount)
  to.deposit(amount)

  @mutex.unlock
  puts "transfer complete"
  end
end

a = Account.new
b = Account.new

a.async.transfer(a,b,100)
a.transfer(b,a,100)

# sleep 50

puts "finishes"