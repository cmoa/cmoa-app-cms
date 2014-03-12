class CacheSweeper < ActionController::Caching::Sweeper
  observe Exhibition, Artist, Artwork, ArtistArtwork, Category, Link, Location, Medium, Tour, TourArtwork

  def after_save(record)
    # Flush all sync cache keys
    list = $redis.lrange('sync:keys', 0, -1)
    list.each do |cacheKey|
      $redis.del(cacheKey)
    end
    $redis.del('sync:keys')
  end
end