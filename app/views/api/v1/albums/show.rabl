collection @album
attributes :id, :name, :release_time, :description

node(:singer_name) { |album| album.singer.name}