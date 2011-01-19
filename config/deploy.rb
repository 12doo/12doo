require 'bundler/capistrano'

set :application, "12doo"
set :repository,  "git@www.12doo.com:12doo.git"
set :scm, :git
set :scm_username, "git"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :user, "root" # The server's user for deploys
set :use_sudo, false
#role :web, "www.12doo.com"                          # Your HTTP server, Apache/etc
#role :app, "www.12doo.com"                          # This may be the same as your `Web` server
#role :db,  "www.12doo.com", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"
server "www.12doo.com", :app, :web, :db, :primary => true # All roles on one server
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

set :deploy_to, "/railsapp/12doo"

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

