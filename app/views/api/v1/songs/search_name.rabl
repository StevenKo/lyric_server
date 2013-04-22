collection @songs
attributes :id, :name, :album_id

node(:singer_name) { |song| song.singer.name if song.singer}