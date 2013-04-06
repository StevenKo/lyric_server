# encoding: utf-8
class CrawlAlbumSongWorker
  include Sidekiq::Worker
  sidekiq_options queue: "lyric"
  
  def perform(singer_id)

    singer = Singer.find(singer_id)
    
    albums = Album.delete_all("singer_id = #{singer.id} and link is null")

    c = LyricCrawler.new
    c.fetch singer.link
    c.crawl_singer_album_and_song singer.id
  end

end