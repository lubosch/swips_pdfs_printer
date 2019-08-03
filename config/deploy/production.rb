# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{swips@165.22.189.242}
role :web, %w{swips@165.22.189.242}
role :db,  %w{swips@165.22.189.242}, :primary => true
role :log, %w{swips@165.22.189.242}

set :branch, 'master'
set :deploy_to, '/opt/swips_pdfs_printer'
set :application_port, '3018'
set :stage, :production
set :app_name, 'swips_pdfs_printer'

set :tmp_dir, '/tmp/swips_pdfs_printer'


set :rbenv_type, :user
set :rbenv_ruby, '2.5.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

server '165.22.189.242', user: 'swips', roles: %w{web app db log}#, my_property: :my_value

