class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :review
      t.references :user
      t.references :video

      t.timestamps
    end
  end
end
