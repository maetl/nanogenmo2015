require './entrance'
require './quest'
require './introduction'
require './encounter'

# entrance = Entrance.new
# puts entrance.generate
#
# puts Quest.generate
#
# intro = Introduction.new
# puts intro.generate
#
# encounter = Encounter.new
# puts encounter.generate

encounter = MonsterEncounter.new
puts encounter.generate
