require './space'
require './directions'
require './chamber'
require './labyrinth'

labyrinth = Labyrinth.new(20)
labyrinth.generate

labyrinth.chambers.each do |chamber|
  puts chamber.section_heading
  puts
  puts chamber.section_body
  puts
  puts chamber.exit_directions
  puts
end
#labyrinth.dump_map
