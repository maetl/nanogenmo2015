require './plot'
require './entrance'
require './introduction'
require './space'
require './directions'
require './chamber'
require './labyrinth'

intro = Introduction.new

puts "## Prologue"
puts
puts intro.generate
puts

labyrinth = Labyrinth.new(200)
labyrinth.generate

labyrinth.chambers.each do |chamber|
  puts "## #{chamber.section_heading}"
  puts
  puts chamber.section_body
  puts chamber.exit_directions
  puts
end
