require 'calyx'
require 'indefinite_article'

class Dungeon < Calyx::Grammar
  start(
    [:empty, 0.6],
    [:monster_only, 0.1],
    [:monster_treasure, 0.15],
    [:special, 0.05],
    [:trick_trap, 0.05],
    [:treasure, 0.05]
  )

  rule :empty, '{room_description} {empty_atmosphere}'
  rule :monster_only, '{room_description} There is a monster here. {monster_encounter}'
  rule :monster_treasure, '{room_description} There is a monster and treasure here. {monster_encounter}'
  rule :special, '{room_description} {special_situation}'
  rule :trick_trap, '{room_description} There is something not quite right about this place.'
  rule :treasure, '{room_description} There is treasure here.'

  rule :monster_encounter, ''

  #rule :precious_metal, 'gold', 'silver', 'bronze'
  #memo :treasure, '{precious_metal} coins', '{precious_metal} ingots'
  rule :room_noun, 'space', 'chamber', 'area', 'room'
  rule :empty_adj, 'empty', 'clear', 'vacant', 'abandoned'
  rule :is_or_seems, 'is', 'seems', 'looks', 'feels'

  rule :empty_atmosphere, 'The {room_noun} {is_or_seems} {empty_adj}.', '{air_atmosphere}.', '{air_atmosphere}. It {is_or_seems} {empty_adj}.'
  rule :area_preposition, 'in', 'through', 'across', 'within', 'inside'
  rule :air_atmosphere, 'A {air_movement} of {air_condition} {air_description}'
  rule :air_movement, 'breath', 'draft', 'current', 'flow', 'rush', 'blast', 'stream'
  rule :air_temperature_adj, 'hot', 'cold', 'dry', 'warm', 'rancid', 'stale'
  rule :air_condition, '{air_temperature_adj} air'
  rule :air_description, '{fills_verb} the {room_noun}'
  rule :fills_verb, 'permeates', 'fills', 'expands {area_preposition}', 'spreads {area_preposition}'


  rule :called, 'called', 'named'

  # Two tramps are here, arguing

  rule :special_situation, :waiting_for_gygax, 'There is something vaguely odd about this place.'

  rule :waiting_for_gygax, 'Two {waiting_tramps} {called} {waiting_names} {waiting_are_here}.{existential_quote}'

  rule :waiting_are_here, 'are here', 'are sitting here', 'are waiting here', 'are here, waiting', 'are here, arguing'

  rule :waiting_names, 'Vladimir and Estragon', 'Rosencrantz and Guildenstern'

  rule :waiting_tramps, 'tramps', 'miscreants', 'vagabonds', 'wretches', 'reprobates', 'blackguards'

  rule :existential_quote, ''

  rule :entry_verb, 'enter', 'step into', 'come to', 'are in'

  rule :room_description, 'You {entry_verb} {room_article}.'

  rule :room_article, '{room_type.with_indefinite_article}', '{adj_description.with_indefinite_article} {room_type}'

  rule :adj_atmosphere, 'gloomy', 'glowing', 'gleaming', 'wet', 'slimy', 'moss-covered', 'foul-smelling', 'foetid', 'clean', 'warm', 'chilly'
  rule :adj_description, 'abandoned', 'ruined', 'wrecked', 'decaying', 'wreckage-strewn', 'crumbling', 'run-down'

  rule :room_type, :assembly_room, :incaceration_room, :military_room, :religious_room, :industry_room, :scholarly_room, :farming_room, :domestic_room, :decadent_room

  rule :assembly_room, 'gallery', 'great hall', 'hall', 'antechamber', 'assembly hall', 'arena'
  rule :incaceration_room, 'prison', 'cage'
  rule :military_room, 'guardroom', 'barracks', 'armory', 'combat pit'
  rule :religious_room, :shrine
  rule :industry_room, 'forge', 'workshop', 'tannery'
  rule :scholarly_room, 'library', 'study', 'scriptorium', 'laboratory', 'map room'
  rule :farming_room, 'barn', 'stable', 'pen'
  rule :domestic_room, 'storage', 'wardrobe', 'pantry', 'bedroom', 'closet', 'kitchen'
  rule :decadent_room, 'statuary', 'museum', 'treasury'

  #rule :

  rule :shrine, 'shrine', 'shrine {shrine_decoration}'

  rule :shrine_decoration, :stone_interior
  #rule :shrine_contents, 'altar, arch, drapery, gilt, inlay, relief, dias, dome, font, fresco, mosaic, painting, pews, podium, idol, magic, candelabra, lamp, torches, pedestal, pillar, column, tapestry, offertory container, reliquary, offertory dish, oil, perfume, alcove, glass window, incense burner, alcohol, holy symbols, remains'.split(", ")
  rule :shrine_contents, 'altar', 'arch', 'drapery', 'gilt', 'inlay'

  rule :verb_hewn, 'hewn', 'cut', 'shaped', 'carved'
  rule :adj_surface, 'smooth', 'rough', 'pitted'
  rule :noun_stone, 'stone', 'rock', 'granite', 'sandstone', 'shale', 'chalk', 'gneiss', 'schist', 'quartz', 'crystal'
  rule :prep_from, 'from', 'out of'

  rule :stone_interior, '{verb_hewn} {prep_from} {adj_surface} {noun_stone}'
end
