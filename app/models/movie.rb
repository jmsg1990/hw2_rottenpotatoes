class Movie < ActiveRecord::Base
    def self.get_all_ratings
        movies = Movie.group("movies.rating")
        return movies.collect { |movie| movie.rating }
    end
end
