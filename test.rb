require './entrance'
require './quest'
require './introduction'

entrance = Entrance.new
puts entrance.generate

puts Quest.generate

intro = Introduction.new
puts intro.generate
