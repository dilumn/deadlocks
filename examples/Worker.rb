require 'celluloid'

class Worker
  include Celluloid
  include Celluloid::Logger

  def initialize
    @mutex = Mutex.new
  end

  def wait
    # exclusive do
      info "wait"
      # sleep 10
      @mutex.synchronize do
        sleep 10
      end
      info "end wait"
    # end
  end

  def second_wait
    exclusive do
      info "second_wait"
    end
  end

  def wait_for(worker)
    info "wait_for"
    worker.wait
    info "Finish wait_for"
  end
end

w1 = Worker.new
w2 = Worker.new

# w1.async.sleep 100
w1.async.wait
w1.wait_for(w1)

# sleep 30 # Wait until all threads finish.