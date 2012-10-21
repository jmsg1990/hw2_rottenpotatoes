class Movie < ActiveRecord::Base
    def self.get_all_ratings
        return self.select("rating").group("rating")
    end
end
