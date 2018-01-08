# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, 'swips_pdfs_printer'
set :repo_url, 'git@github.com:lubosch/swips_pdfs_printer.git'


set :use_sudo, false
set :deploy_via, :copy
set :format, :pretty
set :log_level, :debug
set :pty, true
set :ssh_options, { forward_agent: true }

set :copy_exclude, [".git/*", ".gitignore", ".DS_Store"]

set :linked_dirs, %w{log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}
set :linked_files, %w{.env puma.rb}
set :bundle_binstubs, nil
