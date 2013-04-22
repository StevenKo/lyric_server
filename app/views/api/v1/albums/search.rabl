collection @albums
attributes :id, :name, :release_time

node(:singer_name) { |album| album.singer.name}