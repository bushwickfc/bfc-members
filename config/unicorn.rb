worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 60
preload_app true
if ENV['RAILS_ENV'] == 'production'
  listen '/tmp/bfc_members.sock'
  stderr_path '/opt/apps/bfc-members/current/log/unicorn_stderr.log'
  stdout_path '/opt/apps/bfc-members/current/log/unicorn_stdout.log'
else
  listen '3000'
end

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
