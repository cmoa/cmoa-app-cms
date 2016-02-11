class Feed < ActiveRecord::Base
    validates :name, :presence => true
    validates :url, :presence => true
    validates :type, :presence => true
    validates_inclusion_of :type, :in => 0..1

    def self.types
      type = {
        0 => 'News',
        1 => 'Videos'
      }

      return type
    end


end
