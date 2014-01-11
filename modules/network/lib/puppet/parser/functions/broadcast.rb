require 'ipaddr'
module Puppet::Parser::Functions
  newfunction(:broadcast, :type => :rvalue ) do |args|
    IPAddr.new(args[0]) |( ~IPAddr.new(args[1]))
  end
end
