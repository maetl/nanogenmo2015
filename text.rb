require './space'
require './directions'
require './chamber'
require './labyrinth'

labyrinth = Labyrinth.new(20)
labyrinth.generate

labyrinth.dump_descriptions
labyrinth.dump_map
