require 'spec_helper'

describe file('/etc/pam_ldap.conf') do
  it { should be_file }
  it { should contain "^uri ldap://#{property[:ldap_ip]}/" }
  its(:content) { should match /^base dc=oshiire,dc=to/ }
  its(:content) { should match /^binddn cn=proxy,dc=oshiire,dc=to/ }
  its(:content) { should match /^pam_password md5/ }
end

describe file('/etc/libnss-ldap.conf') do
  it { should be_file }
  it { should be_mode 600 }
  it { should contain "^uri ldap://#{property[:ldap_ip]}/" }
  its(:content) { should match /^base dc=oshiire,dc=to/ }
  its(:content) { should match /^binddn cn=proxy,dc=oshiire,dc=to/ }
end

describe file('/etc/nsswitch.conf') do
  it { should be_file }
  its(:content) { should match /^passwd:.*compat.*ldap$/ }
  its(:content) { should match /^group:.*compat.*ldap$/ }
  its(:content) { should match /^shadow:.*compat.*ldap$/ }
  its(:content) { should match /^netgroup:.*ldap$/ }
end

describe file('/etc/pam.d/common-auth') do
  it { should be_file }
  its(:content) { should match /^auth.*success=2.*pam_unix\.so nullok_secure/ }
  its(:content) { should match /^auth.*success=1.*pam_ldap\.so use_first_pass/ }
end

describe file('/etc/pam.d/common-session') do
  it { should be_file }
  its(:content) { should match /^session optional pam_mkhomedir\.so skel=\/etc\/skel umask=077/ }
end
