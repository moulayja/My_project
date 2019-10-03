Movie.destroy_all
User.destroy_all
Review.destroy_all

# ========Movies=================
titanic = Movie.create(title: "Titanic")
the_wizard = Movie.create(title: "the Wizard")
star_wars = Movie.create(title: "Star Wars")
the_lord_of_the_rings = Movie.create(title: "The Lord of the rings")


# ========Users=================
jay = User.create(name: "Jay_Farah", password: "1234")
eric = User.create(name: "Eric_Kim", password: "0000")
sally = User.create(name: "Sally_Balinzo", password: "1357")
amanda = User.create(name: "Amanda_Rodriguez", password: "0987")



# ========Reviews=================
jay_rev = Review.create(user_id: jay.id, movie_id: titanic.id, title: "Titanic is romantic", notes: "Such a wonederful movie, Jay reviews")
eric_rev = Review.create(user_id: eric.id, movie_id: the_wizard.id, title:"The wizard is cool", notes: "The Wizard is not bad movie but it's not that real")
sally_rev = Review.create(user_id: sally.id, movie_id: star_wars.id, title: "Star wars is fake", notes: " Not bad movie to watch I like Star Wars")
amanda_rev = Review.create(user_id: amanda.id, movie_id: the_lord_of_the_rings.id, title: "not my type", notes: "the lord of the rings is the best movie I saw so far")


puts "DB Seeded!"