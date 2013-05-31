object @song
attributes :id,:name,:album_id,:lyric

node(:singer_name) { |song| song.singer.name if song.singer_id}