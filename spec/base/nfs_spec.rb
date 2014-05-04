require 'spec_helper'

describe file('/home') do
  it { should be_mounted.with( :type => 'nfs' ) }
end
