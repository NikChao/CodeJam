app_path = ENV['RAILS_ROOT']

working_directory app_path

pid "#{app_path}/tmp/pids/unicorn.pid"

listen "0.0.0.0:3000"

stderr_path "#{app_path}/log/unicorn.stderr.log"
stdout_path "#{app_path}/log/unicorn.stdout.log"

worker_processes 1

before_exec do |server|
    ENV['BUNDLE_GEMFILE'] = "#{app_path}/Gemfile"
end

preload_app true

before_fork do |server, worker|
    if defined?(ActiveRecord::Base)
        ActiveRecord::Base.connection.disconnect!
    end

    old_pid = "#{server.config[:pid]}.oldbin"
    if File.exists?(old_pid) && server.pid != old_pid
        begin
            Process.kill("QUIT", File.read(old_pid).to_i)
        rescue Errno::ENOENT, Errno::ESRCH
        end
    end
end

after_fork do |server, worker|
    if defined?(ActiveRecord::Base)
        ActiveRecord::Base.establish_connection
    end
end
