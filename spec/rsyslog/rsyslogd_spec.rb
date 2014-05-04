require 'spec_helper'

describe package('rsyslog') do
  it { should be_installed }
end

describe service('rsyslog') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(property[:rsyslog_port]) do
  it { should be_listening }
end

describe file('/etc/rsyslog.conf') do
  it { should be_file }
  its(:content) { should match /^\$ModLoad imudp/ }
  its(:content) { should match /^\$UDPServerRun 514$/ }
  its(:content) { should match /^\$ModLoad imtcp/ }
  its(:content) { should match /^\$InputTCPServerRun 514$/ }
end

describe file('/etc/rsyslog.d/collection.conf') do
  it { should be_file }
  its(:content) { should match /^\$template.*DynamicFile/ }
  its(:content) { should match /^\*\.\*.*DynamicFile$/ }
end
