env :PATH, ENV['PATH']

every :weekday, :at => '03:00am' do
  rake 'crawl:crawl_singer',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_hot_album',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_hot_song',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:set_new_album',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_hot_videos',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :weekday, :at => '03:30am' do
  rake 'crawl:crawl_hot_singer',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_singer_album_and_song',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :weekday, :at => '04:30am' do
  rake 'crawl:crawl_album_description',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_song_lyric',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end

every :weekend, :at => '03:30am' do
  rake 'crawl:crawl_top_list',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end