require 'spec_helper'

# ----------------------------
# パッケージの確認
# ----------------------------

describe package('nginx') do
  it { should be_installed }
end

describe package('mysql') do
  it { should be_installed }
end

describe package('nodejs') do
  it { should be_installed }
end

describe package('yarn') do
  it { should be_installed }
end

# ----------------------------
# サービスの確認
# ----------------------------

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

# Puma は systemd で起動していない場合、チェックは省略

# ----------------------------
# ポート確認（ALB - Nginx）
# ----------------------------

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should be_listening }
end

# ----------------------------
# Puma Unix ソケットの存在確認
# ----------------------------

describe file('/var/www/your_app/shared/tmp/sockets/puma.sock') do
  it { should be_socket }
  it { should be_owned_by 'deploy' } # 適切なユーザーに変更
end

# ----------------------------
# Ruby / Bundler / Rails
# ----------------------------

describe command('ruby -v') do
  its(:stdout) { should match /ruby 3\.2\.3/ }
end

describe command('bundle -v') do
  its(:stdout) { should match /Bundler version 2\.3\.14/ }
end

describe command('rails -v') do
  its(:stdout) { should match /Rails 7\.1\.3\.2/ }
end

# ----------------------------
# Node.js / Yarn
# ----------------------------

describe command('node -v') do
  its(:stdout) { should match /v17\.9\.1/ }
end

describe command('yarn -v') do
  its(:stdout) { should match /1\.22\.19/ }
end

# ----------------------------
# RDS 接続確認
# ----------------------------
# `mysql` CLI が使える前提です。適切なホスト名/ユーザー名に書き換えてください。

describe command("mysql -h your-rds-endpoint.rds.amazonaws.com -u your_db_user -p'your_password' -e 'SHOW DATABASES;'") do
  its(:stdout) { should match /information_schema/ }
  its(:exit_status) { should eq 0 }
end

# ----------------------------
# AWS CLI 確認（必要に応じて）
# ----------------------------

describe command('aws --version') do
  its(:stdout) { should match /aws-cli/ }
end

# ----------------------------
# ALB 経由のヘルスチェック
# ----------------------------
# 実際にヘルスチェックURLを叩いて 200 を確認（タイムアウトが長いとエラーになることあり）

describe command("curl -s -o /dev/null -w '%{http_code}' http://your-alb-dns-name/healthcheck") do
  its(:stdout) { should eq '200' }
end







listen_port = 80

describe package('nginx') do
  it { should be_installed }
end

describe port(listen_port) do
  it { should be_listening }
end

describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

describe service('nginx') do
  it { should be_running }
  it { should be_enabled }
end

describe file('/etc/nginx/nginx.conf') do
  it { should exist }
  it { should be_file }
end

