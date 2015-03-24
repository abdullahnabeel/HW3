class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :all_ratings
end
