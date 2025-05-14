require 'spec_helper'

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

describe package('nginx') do
  it { should be_installed }
end

