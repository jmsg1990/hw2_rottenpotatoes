class Movie < ActiveRecord::Base
    def self.get_all_ratings
        movies = self.group("rating")
        return movies.collect { |movie| movie.rating }
    end
end
