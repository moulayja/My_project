require 'colorize'
require 'colorized_string'

class Interface
  attr_reader :prompt
  attr_accessor :username

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    puts "Welcome to the Movie review App Where you can review your movies for free..".colorize(:yellow)
    @prompt.select("You can Sign in/ Sign up :".colorize(:white)) do |menu|
      menu.choice "Sign in".colorize(:red), -> { User.sign_in }
      menu.choice "Sign up".colorize(:red), -> { User.sign_up }
      menu.choice "Quit".colorize(:red), -> { exit }
    end
  end
end



 