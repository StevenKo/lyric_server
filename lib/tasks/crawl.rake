# encoding: utf-8
namespace :crawl do
  
  task :crawl_search_way_link => :environment do
    categories = SingerCategory.all
    categories.each do |category|
      c = LyricCrawler.new
      c.fetch category.link
      c.crawl_singer_search_way category.id
    end 
  end

  task :crawl_search_way_item => :environment do 
    ways = SingerSearchWay.all
    ways.each do |way|
      c = LyricCrawler.new
      c.fetch way.link
      c.crawl_singer_search_way_item way.id
    end
  end

  task :crawl_singer => :environment do
    items = SingerSearchWayItem.select("id,link")
    items.each do |item|
      begin 
        c = LyricCrawler.new
        c.fetch item.link
        c.crawl_singer item.id
      rescue
        puts "error: item_id: #{item.id}"
      end
      # CrawlSingerWorker.perform_async(item.id)
    end
  end

  task :crawl_hot_singer => :environment do
    Singer.update_all("is_hot = false")
    categories = SingerCategory.all
    categories.each do |category|
      c = LyricCrawler.new
      c.fetch category.link
      c.crawl_hot_singer
    end 
  end

  task :crawl_singer_album_and_song => :environment do
    Singer.select("id").find_in_batches do |singers|
      singers.each do |singer|
        CrawlAlbumSongWorker.perform_async(singer.id)
      end
    end
  end

  task :crawl_album_description => :environment do
    Album.select("id").find_in_batches do |albums|
      albums.each do |album|
        CrawlAlbumInfoWorker.perform_async(album.id)
      end
    end
  end

  task :crawl_song_lyric => :environment do
    Song.select("id").find_in_batches do |songs|
      songs.each do |song|
        CrawlLyricWorker.perform_async(song.id)
      end
    end
  end

  task :crawl_hot_album => :environment do
    Album.update_all("hot_album_category_id = null")
    c = LyricCrawler.new
    c.fetch "/twzhot-cd.htm"
    c.crawl_hot_album
  end

  task :crawl_hot_song => :environment do
    Song.update_all("hot_song_category_id = null")
    c = LyricCrawler.new
    c.fetch "/twzhot-song.htm"
    c.crawl_hot_song
  end

  task :set_new_album => :environment do
    Album.where("is_new = true").update_all("is_new = false")
    c = LyricCrawler.new
    c.fetch "/twznew.htm"
    c.set_new_album
  end

  task :crawl_hot_videos => :environment do
    Video.delete_all
    c = LyricCrawler.new
    c.fetch_from_okitv "http://m.oiktv.com/"
    c.crawl_hot_videos
  end
end