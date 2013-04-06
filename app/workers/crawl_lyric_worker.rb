# encoding: utf-8
class CrawlLyricWorker
  include Sidekiq::Worker
  sidekiq_options queue: "lyric"
  
  def perform(song_id)
    song = Song.find(song_id)
    c = LyricCrawler.new
    c.fetch song.link
    c.crawl_song_lyric song.id    
  end

end