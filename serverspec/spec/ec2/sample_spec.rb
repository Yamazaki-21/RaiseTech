require 'spec_helper'

# Ruby / Bundler / Rails / Node.js / Yarn バージョン確認
describe command('ruby -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /ruby 3\.2\.3/ }
end
describe command('bundler -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /Bundler version 2\.3\.14/ }
end
describe command('rails -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /Rails 7\.1\.3\.2/ }
end
describe command('node -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /v17\.9\.1/ }
end
describe command('yarn -v') do
  let(:disable_sudo) { true }
  its(:stdout) { should match /1\.22\.19/ }
end

listen_port = 80
# Nginxインストール確認
describe package('nginx') do
  it { should be_installed }
end
# Nginx動作、有効化確認
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end
# ポート確認（Nginx）
describe port(listen_port) do
  it { should be_listening }
end
# Nginx config確認
describe command("nginx -t") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should match /syntax is ok/ }
end

# Puma動作、有効化確認
describe service('puma') do
  it { should be_enabled }
  it { should be_running }
end
# Puma Unix ソケットの存在確認
describe file('/var/www/rails-app/tmp/sockets/puma.sock') do
  it { should be_socket }
end
# Pumaのプロセス確認
describe command("pgrep -f puma") do
  its(:exit_status) { should eq 0 }
end

# Nginx→ Puma経由でRailsアプリ
describe command("curl -s http://127.0.0.1:#{listen_port}/") do
  its(:stdout) { should match /<title>.*Rails.*<\/title>/ }
end

# RDS 接続確認
describe command("cd /var/www/rails-app && RAILS_ENV=production bundle exec rails runner 'puts ActiveRecord::Base.connection.active?'") do
  its(:stdout) { should match /true/ }
  its(:exit_status) { should eq 0 }
end

# S3アクセス確認
describe command("aws s3 ls s3://raisetech-test-bucket/") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should satisfy { |stdout| stdout.empty? || stdout.match(/PRE|.*\d{4}-\d{2}-\d{2}/) } }
end

