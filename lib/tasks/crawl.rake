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
    puts "crawl singer starts"
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
    puts "crawl crawl_hot_singer starts"
    Singer.update_all("is_hot = false")
    categories = SingerCategory.all
    categories.each do |category|
      c = LyricCrawler.new
      c.fetch category.link
      c.crawl_hot_singer
    end 
  end

  task :crawl_singer_album_and_song => :environment do
    puts "crawl crawl_singer_album_and_song starts"
    Singer.select("id").find_in_batches do |singers|
      singers.each do |singer|
        CrawlAlbumSongWorker.perform_async(singer.id)
      end
    end
  end

  task :crawl_album_description => :environment do
    puts "crawl crawl_album_description starts"
    Album.where("description is null").select("id").find_in_batches do |albums|
      albums.each do |album|
        CrawlAlbumInfoWorker.perform_async(album.id)
      end
    end
  end

  task :crawl_song_lyric => :environment do
    puts "crawl crawl_song_lyric starts"
    Song.select("id").find_in_batches do |songs|
      songs.each do |song|
        CrawlLyricWorker.perform_async(song.id)
      end
    end
  end

  task :crawl_hot_album => :environment do
    puts "crawl crawl_hot_album starts"
    Album.update_all("hot_album_category_id = null")
    c = LyricCrawler.new
    c.fetch "/twzhot-cd.htm"
    c.crawl_hot_album
  end

  task :crawl_hot_song => :environment do
    puts "crawl crawl_hot_song starts"
    Song.update_all("hot_song_category_id = null")
    c = LyricCrawler.new
    c.fetch "/twzhot-song.htm"
    c.crawl_hot_song
  end

  task :set_new_album => :environment do
    puts "crawl set_new_album starts"
    Album.where("is_new = true").update_all("is_new = false")
    c = LyricCrawler.new
    c.fetch "/twznew.htm"
    c.set_new_album
  end

  # task :crawl_hot_videos => :environment do
  #   puts "crawl crawl_hot_videos starts"
  #   Video.delete_all
  #   c = LyricCrawler.new
  #   c.fetch_from_okitv "http://m.oiktv.com/"
  #   c.crawl_hot_videos
  # end

  task :crawl_top_list => :environment do
    puts "crawl crawl_hot_videos starts"
    SongTopListRelation.delete_all("top_list_id != 4 AND top_list_id != 5")
    c = LyricCrawler.new
    c.fetch_ordinary_site "http://i-favorites.net/MB/"
    c.crawl_top_list
  end
end