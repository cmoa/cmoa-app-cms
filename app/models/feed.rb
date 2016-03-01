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



    def self.newsFeedsURLs
      feeds = Feed.where(feed_type: 0)

      feed_urls = []
      feeds.each do |f|
        feed_urls.push(f.url)
      end
      return feed_urls
    end

    def self.videoFeedsURLs
      feeds = Feed.where(feed_type: 1)
      feed_urls = []
      feeds.each do |f|
        feed_urls.push(f.url)
      end
      return feed_urls
    end




end
