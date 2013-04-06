# encoding: utf-8
class CrawlAlbumInfoWorker
  include Sidekiq::Worker
  sidekiq_options queue: "lyric"
  
  def perform(album_id)
    
    album = Album.find(album_id)
    begin
      c = LyricCrawler.new
      c.fetch album.link
      c.crawl_album_info album.id
    rescue
    end
  end

end