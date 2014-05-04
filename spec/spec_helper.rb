require 'serverspec'
require 'pathname'
require 'net/ssh'
require 'yaml'

include SpecInfra::Helper::Ssh
include SpecInfra::Helper::DetectOS

properties = YAML.load_file('properties.yml')

RSpec.configure do |c|
  c.color_enabled = true
  c.formatter = :documentation

  if ENV['ASK_SUDO_PASSWORD']
    require 'highline/import'
    c.sudo_password = ask("Enter sudo password: ") { |q| q.echo = false }
  else
    c.sudo_password = ENV['SUDO_PASSWORD']
  end

  c.host  = ENV['TARGET_HOST']
  set_property properties[c.host]
  options = Net::SSH::Config.for(c.host)
  user    = options[:user] || Etc.getlogin
  c.ssh   = Net::SSH.start(c.host, user, options)
  c.os    = backend.check_os

end
