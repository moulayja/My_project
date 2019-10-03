require 'colorize'
require 'colorized_string'

class User < ActiveRecord::Base
  has_many :reviews
  has_many :movies, through: :reviews
  @@prompt = TTY::Prompt.new

# =============== Sign up user : New user ============================

  def self.sign_up
    puts "What is your Username?".colorize(:white)
    username = @@prompt.ask("Username")
    puts "Please type your password?".colorize(:white)
    password = @@prompt.mask("type your pass")
  
    # In case the user didn't type a username or password
    while 
      username == nil
      puts "Please chose a username, you can't leave it empty".colorize(:red)
      username = @@prompt.ask("type your username")    
    end

    while 
      password == nil 
      puts "Please type a charachter, you can't leave it blank".colorize(:red)
      password = @@prompt.mask("type your pass")    
    end
    # Create a User
    new_user = User.create(name: username, password: password)
    new_user.main_menu
  end

  # =============== Sign in user: Returning User ====================

  def self.sign_in
    puts "What is your Username?".colorize(:white)
    username = @@prompt.ask("Username")
    puts "Please type your password?".colorize(:white)
    password = @@prompt.mask("type your pass")
    checking_if_user_exist = User.find_by(name: username, password: password)
   

    if checking_if_user_exist != nil
      puts "You're welcome back #{username}!"
      checking_if_user_exist.main_menu
    else
        puts "It seems that, we dont't have #{username} in our database".colorize(:red)
        puts "Please, Sign up".colorize(:yellow)
        self.sign_up
    end

  end
    
  # =============== User menu after signing ==========================

  def main_menu
    @@prompt.select("What would you like to do today?".colorize(:yellow)) do |menu|
      menu.choice "Read Reviews", -> {self.read_reviews}
      menu.choice "Write a review", -> { self.writing }
      menu.choice "Update a review", -> { self.update_reviews }
      menu.choice "Delete a review", -> { self.deleting }
      menu.choice "Log Out", -> { self.log_out }
    end
  end
     # =============== User log out ==========================

  def log_out
    interface = Interface.new
    puts "=============================================\n".colorize(:white)
    puts "************Logged out succefully************\n".colorize(:red)
    puts "=============================================\n".colorize(:white)
    sleep 2
    puts "            << See you soon >>\n".colorize(:red)
    sleep 1
    puts "Ciaooooooo..........\n\n".colorize(:white)
    interface.welcome
  end


   # =============== User menu: read reviews ==========================

  def read_reviews
    self.reload
    if self.reviews.count == 0
      @@prompt.select("No reviews to show now".colorize(:yellow)) do |menu|
        menu.choice "Back", -> { self.main_menu }
      end

    else
      self.reviews.each do |review|
        puts "Movie: ".colorize(:yellow) + "#{review.movie.title}".colorize(:white)
        # puts "Title: ".colorize(:yellow) + "#{review.title}".colorize(:white)
        puts "Notes: ".colorize(:yellow) + "#{review.notes}".colorize(:white)
        puts "------------------------"
      end
        @@prompt.select("") do |menu|
          menu.choice "Back", -> {self.main_menu}
        end  
    end
  end

   # =============== User menu: update reviews ==========================


    def update_reviews
        review_notes = self.reviews.map do |review|
          {review.notes => review.id}
        end
        if review_notes.length == 0
          @@prompt.select("No reviews to update".colorize(:yellow)) do |menu|
            menu.choice "Back", -> { self.main_menu }
          end
        else
          review_id =  @@prompt.select("Select review to update", review_notes)
          review = Review.find(review_id)
  
          new_rev = @@prompt.ask("Please type your new note: ")
          review.notes = new_rev
          review.save
          review.reload
        end

        self.reload

        puts "------------------------"
        @@prompt.select("") do |menu|
          menu.choice "Back", -> {self.main_menu}
        end
    end


   # =============== User menu: Delete User ==========================

   def deleting
    all_reviews = self.reviews.map do |review|
      {review.notes => review.id}
    end
    if all_reviews.length == 0
      @@prompt.select("No reviews to delete")do |menu|
        menu.choice "Back", -> { self.main_menu }
      end
    else
      review_id =  @@prompt.select("Select review to delete", all_reviews)
      delete_review = Review.find(review_id)

      @@prompt.select("Are you sure you want to delete?") do |menu|
        menu.choice "Yes", -> { delete_review.destroy }
        menu.choice "No", -> { self.main_menu }
      end
    end 

    self.reload

    puts "------------------------"
    @@prompt.select("") do |menu|
      menu.choice "Back", -> {self.main_menu}
    end
  end
    

   # =============== User menu: write reviews ==========================

   def writing
       all_movies = Movie.all.map do |movie|
      {movie.title => movie}
       end
      review_movie =  @@prompt.select("Select a movie to review", all_movies)

      new_rev = @@prompt.ask("Please type your review: ")
      Review.create(notes: new_rev, movie: review_movie, user: self)
      puts "Review created"
      sleep 1
  
    self.reload

    puts "------------------------"
    @@prompt.select("") do |menu|
      menu.choice "Back", -> {self.main_menu}
    end
  end



end
