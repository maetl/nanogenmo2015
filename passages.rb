require './space'
require './directions'
require './chamber'
require './labyrinth'

labyrinth = Labyrinth.new(20)
labyrinth.generate

puts

# TODO: move this to labyrinth
dead_ends = labyrinth.chambers.select do |chamber|
  chamber.neighbours_directions.size == 1
end

labyrinth.dump_map
