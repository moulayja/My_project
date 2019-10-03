require_relative '../config/environment'
require 'colorize'
require 'colorized_string'


# ============= Sleep method is used by the system to show at certain time ======

 sleep 1

 puts "===================   Your app is loading   =========================".colorize(:white)
 sleep 3
puts "Ready............ ".colorize(:white)
18.times{|i|sleep(0.1); puts "\e[H\e[2J", "You're Welcome to the Movie app ".sub(/(?<=.{#{Regexp.quote(i.to_s)}})./, &:upcase);}




# ============== Calling the Interface class ==========================

interface = Interface.new
loggedInUser = interface.welcome()

while loggedInUser.nil?
  loggedInUser = interface.welcome()
end


binding.pry
puts "hello world"
