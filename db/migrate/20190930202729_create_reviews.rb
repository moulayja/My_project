class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.string :title
      t.string :notes
      t.integer :user_id
      t.integer :movie_id

    end
  end
end
