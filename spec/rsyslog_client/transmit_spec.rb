require 'spec_helper'

describe package('rsyslog') do
  it { should be_installed }
end

describe service('rsyslog') do
  it { should be_enabled   }
  it { should be_running   }
end

describe file('/etc/rsyslog.d/transmit.conf') do
  it { should be_file }
  it { should contain "^\*\.\*.*@@#{property[:rsyslog_server]}" }
end
