require 'serverspec'

set :backend, :ssh
set :host, ENV['TARGET_HOST']
set :ssh_options, {
  user: 'ec2-user',
  keys: [ENV['SSH_KEY_PATH']],
  verify_host_key: :never
}
set :request_pty, true

