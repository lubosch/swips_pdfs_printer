# Simple Role Syntax
role :app, %w{swips@40.115.61.51}
role :web, %w{swips@40.115.61.51}
role :db,  %w{swips@40.115.61.51}, :primary => true
role :log, %w{swips@40.115.61.51}


set :branch, 'develop'
set :deploy_to, '/opt/swips_pdfs_printer_staging'
set :application_port, '3018'
set :stage, :staging
set :app_name, 'swips_pdfs_printer_staging'

set :tmp_dir, '/tmp/swips_pdfs_printer_staging'

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '40.115.61.51', user: 'swips', roles: %w{web app db log}#, my_property: :my_value

set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

