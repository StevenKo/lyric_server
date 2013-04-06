# encoding: utf-8
class CrawlSingerWorker
  include Sidekiq::Worker
  sidekiq_options queue: "lyric"
  
  def perform(item_id)
    item = SingerSearchWayItem.find(item_id)
    begin 
      c = LyricCrawler.new
      c.fetch item.link
      c.crawl_singer item.id
    rescue
      puts "error: item_id: #{item.id}"
    end
  end

end