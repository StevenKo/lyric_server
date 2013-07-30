module Crawler
  
  require 'nokogiri'
  require 'open-uri'
  # require 'iconv'
  require 'net/http'
  
  attr_accessor :page_url, :page_html
  
  def fetch url
    @page_url = url
    @page_html = get_page(@page_url)   
  end

  def fetch_from_okitv url
    @page_url = url
    http = Net::HTTP.new('m.oiktv.com', 80)
    res = http.get "/", 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19', 'Cookie' => '_ts_id=360435043104370F39'
    content = res.body
    @page_html = Nokogiri::HTML(content)
  end

  def fetch_json url
    @page_url = url
    body = ''
    begin
      open(url){ |io|
          body = io.read
      }
    rescue
    end
    @page_html = body
  end

  def fetch_ordinary_site url
    @page_url = url
    body = ''
    begin
      open(url){ |io|
          body = io.read
      }
    rescue
    end
    @page_html = Nokogiri::HTML(body)
  end

  def post_fetch url, option
    @page_url = url
    url = URI.parse(url)
    resp, data = Net::HTTP.post_form(url, option)
    @page_html = Nokogiri::HTML(resp.body)
  end
  
  def get_page path

    http = Net::HTTP.new('mojim.com', 80)
    res = http.get path, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19', 'Cookie' => '_ts_id=360435043104370F39'
    content = res.body
    doc = Nokogiri::HTML(content)

  # url = url.gsub(/\s+/, "")
  # ecode_url = URI.encode(url)
  # body = ''

  # begin
  #   open(url){ |io|
  #       body = ic.iconv(io.read)
  #   }
  # rescue
  # end
  

  end

  
  def get_item_href dns, src
    if (/^\/\// =~ src)
      src = "http:" + src
    elsif (/^\// =~ src)
      src = dns + src
    elsif (/\.\./ =~ src)
      src = dns + src[2..src.length]
    else
      src 
    end
  end
  
  def parse_dns
    url_scan = @page_url.scan(/.*?\//)
    dns = url_scan[0] + url_scan[1] + url_scan[2]
  end

http = Net::HTTP.new('goods.ruten.com.tw', 80)
path = '/item/show?21204160389512'
res = http.get path, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.162 Safari/535.19', 'Cookie' => '_ts_id=360435043104370F39'
 
content = res.body
 
content.index('149') # should not nil, 149 is price of goods
  
end