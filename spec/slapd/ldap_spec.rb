require 'spec_helper'

describe package('slapd') do
  it { should be_installed }
end

describe service('slapd') do
  it { should be_enabled   }
  it { should be_running   }
end

describe port(property[:ldap_port]) do
  it { should be_listening }
end

describe file('/etc/default/slapd') do
  it { should be_file }
  its(:content) { should match /SLAPD_SERVICES=\"ldap:\/\/\// }
end

describe command('slapcat | egrep "^dn"') do
  it { should return_stdout /dn: dc=oshiire,dc=to/ }
  it { should return_stdout /dn: cn=admin,dc=oshiire,dc=to/ }
  it { should return_stdout /dn: cn=proxy,dc=oshiire,dc=to/ }
  it { should return_stdout /dn: ou=People,dc=oshiire,dc=to/ }
  it { should return_stdout /dn: ou=Group,dc=oshiire,dc=to/ }
end

describe command('ldapsearch -LLL -Y EXTERNAL -H ldapi:// -b cn=config') do
  it { should return_stdout /olcRootDN: cn=admin,dc=oshiire,dc=to/ }
end
