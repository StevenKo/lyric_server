# encoding: utf-8
class LyricCrawler
  include Crawler

  def crawl_hot_videos
    node = @page_html.css("h3").reject{ |node| node.text != "熱門影片"}[0]
    nodes = node.next.next.css("a")
    nodes.each do |node|
      link = node[:href]
      title = node.text.strip
      # pic = node.css("img")[0][:src]
      video = Video.new
      video.title = title
      /vplay-(.{11})\.html/ =~ link 
      video.youtube_id = $1
      video.save
    end
  end

  def set_new_album
    nodes = @page_html.css("a.X2")
    nodes.each do |node|
      album = Album.find_by_link(node[:href])
      if album
        album.is_new = true
        album.save
      end
    end
  end

  def crawl_hot_song
    nodes = @page_html.xpath("//tr[@bgcolor='#F1E4D6']")
    (1..6).each do |i|
      category = HotSongCategory.find(i)
      node = nodes[i-1]
      song_nodes = node.parent.css("a")
      
      song_nodes.each do |song_node|
        link = song_node[:href]
        song = Song.find_by_link(link)
        if song
          song.hot_song_category = category
          song.save
        end
      end
    end
  end

  def crawl_hot_album
    nodes = @page_html.xpath("//tr[@bgcolor='#F1E4D6']")
    (1..6).each do |i|
      category = HotAlbumCategory.find(i)
      node = nodes[i-1]
      album_nodes = node.parent.css("a")
      
      album_nodes.each do |album_node|
        link = album_node[:href]
        album = Album.find_by_link(link)
        if album
          album.hot_album_category = category
          album.save
        end
      end
    end
  end

  def crawl_song_lyric song_id
    song = Song.find(song_id)
    next if (song.lyric && song.lyric.size > 20)
    nodes = @page_html.css('#fsZ')
    if nodes.present?
      song.lyric = change_node_br_to_newline(nodes[0]).strip
      song.save
      return;
    end

    nodes = @page_html.css("a")
    nodes.each do |node|
      if node[:href] == song.link
        lyric_node = node.parent.next
        lyric_node.css("script").remove
        song.lyric = change_node_br_to_newline(lyric_node).strip
        song.save
        return;
      end
    end
  end

  def crawl_album_info album_id
     album = Album.find(album_id)
     next if album.description
     node = @page_html.css("#introS dd")[0]
     album.description = change_node_br_to_newline(node)
     album.save
  end

  def crawl_singer_search_way_item way_id
    way = SingerSearchWay.find(way_id)
    nodes = @page_html.xpath("//font[@color='#00A002']")[0].parent.parent.css("li a")
    nodes.each do |node|
        s = SingerSearchWayItem.new
        s.singer_search_way = way
        s.name = prone(node.text)
        s.link = node[:href]
        s.save
    end
  end

  def crawl_hot_singer
    nodes = @page_html.xpath("//font[@color='#990000']")[0].parent.parent.parent.css("a")

    nodes.each do |node|
      if singer = Singer.find_by_link(node[:href])
        singer.is_hot = true
        singer.save
      end
    end
  end

  def crawl_singer_album_and_song singer_id
    singer = Singer.find(singer_id)
    
    if @page_html.css(".hb0").present?
      singer.description = change_node_br_to_newline(@page_html.css(".hb0")[0])
    end

    nodes = @page_html.css("a.X3")
    if /(.*)\(.*\)/ =~ nodes[2].text.strip
      singer.name = nodes[2].text.strip
    else
      singer.name = nodes[2].text.strip + "(#{singer.name})" if (singer.name.match("[a-zA-Z0-9 \-]*") && singer.name.match("[a-zA-Z0-9 \-]*").to_s == singer.name && nodes[2].text.strip != singer.name)
    end
    singer.save

    if @page_html.css(".hb1 .hc1").text.index('專輯') != nil
      nodes = @page_html.css(".hb2 .hc1,.hb3 .hc1")

      nodes.each do |node|
        album_node = node.css("a")[0]
        
        if album_node
          a = Album.find_by_name(album_node.text.strip) || Album.new
          a.name = album_node.text.strip
          a.link = album_node[:href]
        else
          a = Album.new
          a.name = "暫存"
        end
        a.singer = singer
          
        begin
          a.release_time = DateTime.strptime(node.next.next.children[2].text, "%Y-%m") if node.next.next.children[2].text.present? if node.next.next.children.size > 2
        rescue
          a.release_time = DateTime.strptime(node.next.next.children[2].text, "%Y") if node.next.next.children[2].text.present? if node.next.next.children.size > 2
        end

        a.save

        song_nodes = node.next.next.next.next.css("a")
        song_nodes.each do |song_node|
          next if song_node.text.index("提供")
          next if Song.find_by_link(song_node[:href])
          song = Song.new
          song.name = song_node.text
          song.link = song_node[:href]
          song.singer = singer
          song.album = a
          song.save
        end
        song_nodes = node.next.next.next.next.next.css("a")
        song_nodes.each do |song_node|
          next if song_node.text.index("提供")
          next if Song.find_by_link(song_node[:href])
          song = Song.new
          song.name = song_node.text
          song.link = song_node[:href]
          song.singer = singer
          song.album = a
          song.save
        end
      end

    else
      nodes = @page_html.css(".hc1 a")
      nodes.each do |node|
        next if node.text.index("提供")
        next if Song.find_by_link(node[:href])
        s = Song.new
        s.singer = singer
        s.name = node.text
        s.link = node[:href]
        s.save
      end
    end
  end

  def crawl_singer item_id
    item = SingerSearchWayItem.find(item_id)
    category = item.singer_search_way.singer_category
    nodes = @page_html.xpath("//font[@color='#990000']")[1].parent.parent.parent.css("a")

    nodes.each do |node|
      next unless node[:title]
      if (s=Singer.find_by_link(node[:href]))
        s.singer_search_way_items << item unless s.singer_search_way_items.include? item
        next
      end
      s = Singer.new
      s.name = node.text
      s.link = node[:href]
      s.singer_category = category
      s.singer_search_way_items << item
      s.save
    end
  end

  def crawl_singer_search_way category_id
    category = SingerCategory.find(category_id)
    nodes = @page_html.xpath("//td[@bgcolor='#F1E4D6']")[2].parent.children
    nodes = [nodes[0],nodes[2],nodes[4]]
    nodes.each do |node|
      s = SingerSearchWay.new
      s.name = node.css("a").text
      s.link = node.css("a")[0][:href]
      s.singer_category = category
      s.save
    end
  end



  private

  def get_link_path link
    /mojim.com(\/.*)/ =~ link
    $1
  end

  def prone text
    while (text.size > 1 && text[0] == text[1])
      text = text[1..text.size-1]
    end
    text
  end

  def change_node_br_to_newline node
    content = node.to_html
    content = content.gsub("<br>","\n")
    n = Nokogiri::HTML(content)
    n.text
  end
end
