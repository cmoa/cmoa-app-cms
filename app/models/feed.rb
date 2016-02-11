class Feed < ActiveRecord::Base
    validates :name, :presence => true
    validates :url, :presence => true
    validates :feed_type, :presence => true
    validates_inclusion_of :feed_type, :in => 0..1

    def self.types
      type = {
        0 => 'News',
        1 => 'Videos'
      }

      return type
    end


end
