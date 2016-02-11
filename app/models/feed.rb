class Feed < ActiveRecord::Base
    validates :name, :presence => true
    validates :url, :presence => true
    validates :type, :presence => true

    enum type: [:news, :video]


end
