worker_processes 1
preload_app true

# Uncommenting thr code below solves the issue
=begin
after_fork do |server, worker|
  if defined?(Mongoid)
    Mongoid::Clients.clients.each do |name, client|
      client.close
      client.reconnect
    end
  end
end

before_fork do |server, worker|
  if defined?(Mongoid)
    Mongoid.disconnect_clients
  end
end
=end
