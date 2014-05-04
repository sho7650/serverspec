require 'spec_helper'

describe file('/etc/locale.gen') do
  it { should be_file }
  its(:content) { should match /^ja_JP\.UTF-8 UTF-8/ }
  its(:content) { should match /^en_US\.UTF-8 UTF-8/ }
end

describe command('locale -a') do
  it { should return_stdout /en_US\.utf8/ }
  it { should return_stdout /ja_JP\.utf8/ }
end

