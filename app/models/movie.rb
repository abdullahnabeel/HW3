class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :all_ratings
   def index
   	@all_ratings = ['G','PG','PG-13','R','NC-17']
   end
end
