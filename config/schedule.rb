#####
#
# These are required to make rvm work properly within crontab
#
if ENV['MY_RUBY_HOME'] && ENV['MY_RUBY_HOME'].include?('rvm')
  env "PATH",         ENV["PATH"]
  env "GEM_HOME",     ENV["GEM_HOME"]
  env "MY_RUBY_HOME", ENV["MY_RUBY_HOME"]
  env "GEM_PATH",     ENV["_ORIGINAL_GEM_PATH"] || ENV["BUNDLE_ORIG_GEM_PATH"] || ENV["BUNDLER_ORIG_GEM_PATH"]
end
#
#####

require 'rake'
env :MAILTO, 'systems@epigenesys.org.uk'
set :output, { standard: 'log/whenever.log' }

every :reboot, roles: [ :db ] do
  runner "require 'delayed/command'; Delayed::Command.new(['-p #{@delayed_job_args_p}', '-n #{@delayed_job_args_n}', 'start']).daemonize"
end


every 24.hours do
  rake 'send_changes_reminder_1day:send_mail'
end

every 72.hours do
  rake 'send_changes_reminder_3days:send_mail'
end

every 120.hours do
  rake 'send_changes_reminder_5days:send_mail'
end

every 1.minute do
  rake 'send_changes_reminder_1min:send_mail'
end

every 30.days do
  rake 'delete_graduated_students:delete_grad_students'
end


