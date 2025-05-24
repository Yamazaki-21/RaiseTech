require 'spec_helper'
# ----------------------------
# Ruby / Bundler / Rails / Node.js / Yarn
# ----------------------------
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

# ----------------------------
# サービスの確認
# ----------------------------
describe package('nginx') do
  it { should be_installed }
end
describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end
describe service('puma') do
  it { should be_enabled }
  it { should be_running }
end

# ----------------------------
# ポート確認（Nginx）
# ----------------------------
listen_port = 80
describe port(listen_port) do
  it { should be_listening }
end
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

# ----------------------------
# Puma Unix ソケットの存在確認
# ----------------------------
describe file('/var/www/rails-app/tmp/sockets/puma.sock') do
  it { should be_socket }
end

# ----------------------------
# RDS 接続確認
# ----------------------------
describe command("mysql -h #{ENV['RDS_ENDPOINT']} -u #{ENV['DB_USERNAME']} -p'#{ENV['DB_PASSWORD']}' -e 'SHOW DATABASES;'") do
  its(:stdout) { should match /information_schema/ }
  its(:exit_status) { should eq 0 }
end

# ----------------------------
# S3アクセス確認
# ----------------------------
describe command("aws s3 ls s3://raisetech-test-bucket/") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should satisfy { |stdout| stdout.empty? || stdout.match(/PRE|.*\d{4}-\d{2}-\d{2}/) } }
end

# ----------------------------
# ALB 経由のヘルスチェック
# ----------------------------
describe command('curl -4 -s -o /dev/null -w "%{http_code}" http://raisetech-alb-687178373.ap-northeast-1.elb.amazonaws.com/healthcheck') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should eq '200' }
end

