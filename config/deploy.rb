require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (http://rbenv.org)
require 'mina/rvm'    # for rvm support. (http://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :domain, 'www.sitefoil.com'
set :deploy_to, '/var/www/sitefoil'
set :repository, 'git@github.com:dstepchew/sitefoil.git'
set :branch, 'nazar'
set :rails_env, 'production'
set :launch_cmd, "cd #{deploy_to}/current && RAILS_ENV=production thin start -p 8080 -d --servers 4" 
set :shutdown_cmd, "ps ax | grep 808 | grep -v grep | awk '{print $1}' | xargs kill || true"  
# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['log']

# Optional settings:
set :rvm_path, '/usr/local/rvm/scripts/rvm'
set :user, 'root'    # Username in the server to SSH to.
#   set :port, '30000'     # SSH port number.

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .rbenv-version to your repository.
  # invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-2.1.3]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

#  queue! %[mkdir -p "#{deploy_to}/shared/db"]
#   queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/db"]

#  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
#  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :shutdown #to free memory for assets precomple
    invoke :'rails:assets_precompile'

    to :launch do
      queue launch_cmd     
      invoke :'deploy:cleanup'      
    end
  end
end


task :launch_locally do
  system launch_cmd
end

task :shutdown_locally do
  system shutdown_cmd
end

task :shutdown do
    queue shutdown_cmd
end

task :shell do
  system "echo 'logging into shell on server'"
  system "ssh #{user}@#{domain} -t \"cd #{deploy_to}/current; bash --login\""
end

task :log do
  queue 'echo "Contents of the log file are as follows:"'
  queue "cd #{deploy_to}/current && tail -f log/production.log -n 100"
end

task :push do
  comment = ARGV[1] || "-"
  system 'git add .'
  system "git commit -am '#{comment}'"
  system 'git push origin #{branch}'
  system 'mina deploy'
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

