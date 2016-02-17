module Feedzirra

  module Parser

    class VimeoEntry
      include SAXMachine
      include FeedEntryUtilities
      element :guid, :as => :id

      element :title
      element :"media:title", :as => :title

      element :link, :as => :url

      element :"dc:creator", :as => :author
      element :"media:credit", :as => :author, :with => { :role => "author" }

      element :description, :as => :summary

      element :pubDate, :as => :published
      element :pubdate, :as => :published

      element :"media:player", :as => :content, :value => :url
      element :enclosure, :as => :content, :value => :url, :with => { :type => "application/x-shockwave-flash" }

      element :"media:category", :as => :keyword_list
      element :"media:thumbnail", :as => :thumbnail, :value => :url

      def embed_code
        "<iframe src=\"https://player.vimeo.com/video/#{self.media_id}?byline=0&amp;portrait=0&amp;color=f26361\" frameborder=\"0\" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
      end

      def media_id
        if @url =~ /https:\/\/vimeo.com\/(\d*)/i
          $1
        elsif @content =~ /http:\/\/vimeo.com\/moogaloop.swf?clip_id=(\d*)/i
          $1
        else
          ''
        end
      end

      def tags
        @keyword_list.blank? ? [] : @keyword_list.split(",")
      end
    end
  end
end

module Feedzirra

  module Parser

    class Vimeo
      include SAXMachine
      include FeedUtilities
      element :title
      element :link, :as => :url
      element :"atom:link", :as => :feed_url, :value => :href, :with => { :rel => "self" }
      elements :item, :as => :entries, :class => VimeoEntry

      def self.able_to_parse?(xml) #:nodoc:
        xml =~ /xmlns:atom=\"http:\/\/www.w3.org\/2005\/Atom\".+xmlns:media=\"http:\/\/search.yahoo.com\/mrss\/\"/im
      end

    end
  end
end
