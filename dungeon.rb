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
  rule :monster_only, '{room_description} {monster_only_encounter}'
  rule :monster_treasure, '{room_description} {monster_treasure_encounter}'
  rule :special, '{room_description} {special_situation}'
  rule :trick_trap, '{room_description} There is something not quite right about this place.'
  rule :treasure, '{room_description} There is treasure here.'

  #rule :monster_encounter, [:monster_deadly, 0.05], [:monster_hostile, 0.45], [:monster_neutral, 0.5]

  rule :trick_trap_encounter, [:trap_deadly, 0.05], [:trap_mechanical, 0.6], [:trap_magical, 0.35]

  rule :trap_deadly, 'The deadly trap kills you instantly.'

  rule :trap_mechanical, '{trap_trigger}'

  rule :trap_trigger, 'pressure plate', 'tripwire', 'pit'

  rule :monster_treasure_encounter, 'There is a monster and treasure here.'

  rule :monster_only_encounter, :monster_deadly
  rule :monster_deadly, :monster_basilisk, :monster_gorgon
  rule :monster_hostile, ''
  rule :monster_neutral, ''

  rule :monster_bulky, '{bulky_movement.capitalize} {room_movement} is'
  rule :room_movement, 'towards you', 'ahead of you'
  rule :bulky_movement, 'moving', 'lumbering', 'moving sluggishly', 'stamping', 'stomping', 'trampling'

  rule :br, "\n\n"
  rule :success, 'SUCCESS:'
  rule :failure, 'FAILURE:'

  rule :monster_basilisk, '{monster_bulky} a {monstrous_adj} basilisk. {save_against_attack}{br}{failure}{br}As you {freeze_reaction}, the {reptilian_adj} {reptilian_noun} {head_movement} its head and {petrifying_gaze_strike}. {petrifying_gaze_death}{br}{success}{br}'
  rule :monster_gorgon, '{monster_bulky} a {gorgon_adj} gorgon. {clouds.capitalize} of {green} smoke {puff} from its {mouth}. {save_against_attack}{br}{failure}{br}As you {freeze_reaction}, the {metallic_adj} {beast_noun} snaps open its jaws and {petrifying_breath_strike}. {petrifying_breath_death}{br}{success}{br}'

  rule :gorgon_adj, 'bull-like', :monstrous_adj
  rule :monstrous_adj, 'monstrous', 'giant'

  rule :green, 'green', 'viridescent'
  rule :clouds, 'plumes', 'clouds', 'faint clouds', 'faint plumes' 'a faint mist'
  rule :putrid, 'putrid', 'putrifying', 'acrid'
  rule :puff, 'puff', 'billow'
  rule :mouth, 'mouth', 'maw'

  rule :petrifying_breath_strike, 'its {putrid} breath washes over you', 'you stumble directly'
  rule :petrifying_gaze_strike, 'its petrifying gaze {strikes} you head on', 'you {stare_directly} into its petrifying gaze'
  rule :petrifying_gaze_death, '{last_memory_flash} is the {horrific} projection from its eyes as your {petrifying_body} into {petrifying_stone}.'
  rule :petrifying_breath_death, '{last_memory_flash} is choking on the toxic gas as your {petrifying_body} into {petrifying_stone}.'
  rule :petrifying_body, 'body rapidly {fuses}', 'body {fuses}'
  rule :petrifying_stone, 'cold stone', 'solid stone'

  rule :strikes, 'strikes', 'meets', 'hits'
  rule :stare_directly, 'stare straight', 'stare directly'
  rule :fuses, 'freezes', 'fuses', 'hardens'

  rule :last_memory_flash, 'The {last_memory_final} thing you {last_memory_experience}', 'Your {last_memory_final} {last_memory_moment}'
  rule :last_memory_experience, 'remember', 'see', 'experience', 'are consciously aware of'
  rule :last_memory_moment, 'experience', 'moment of awareness', 'moment of experience'
  rule :last_memory_final, 'final', 'last', 'very last'

  rule :reptilian_adj, 'scaly', 'dull coloured', 'scabrous'
  rule :reptilian_noun, 'monster', 'reptile', 'lizard'

  rule :metallic_adj, 'encrusted', 'plate-covered', 'armoured'
  rule :beast_noun, 'monster', 'beast'

  rule :freeze_reaction, '{pause} with {shock}'
  rule :head_movement, 'turns', 'raises', 'lifts'
  rule :shock, 'shock', 'fright', 'fear'
  rule :pause, 'freeze', 'pause', 'step back', 'stand frozen'
  rule :horrific, 'horrifying', 'terrifying', 'abyssal'

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

  rule :save_against_trap, 'To {dodge} the trap, you must {movement} {safety}. {skill_test}'
  rule :save_against_attack, 'To {dodge} the attack, you must {movement} {safety}. {skill_test}'
  rule :dodge, 'dodge', 'avoid'
  rule :movement, 'dive', 'roll', 'jump'
  rule :safety, 'to safety', 'clear in time'

  rule :test_of, 'Test your', 'Roll against', 'This is a test of'
  rule :skill_test, '{test_of} SKILL. {save_procedure}'
  rule :strength_test, '{test_of} STRENGTH. {save_procedure}'
  rule :stamina_test, '{test_of} STAMINA {save_procedure}'

  rule :save_procedure, '{success_procedure} {failure_procedure}'
  rule :success_procedure, 'If you succeed, you can {continue_to_the_exit}', 'If successful, then {continue_to_the_exit}', 'If your roll succeeds, {continue_to_the_exit}'
  rule :continue_to_the_exit, 'choose one of the exits.', 'choose an exit path.', 'go to one of the exits.', 'exit safely.'
  rule :failure_procedure, 'If you fail, {continue_reading}.', 'Otherwise, {continue_reading}.'
  rule :continue_reading, 'continue reading', 'continue below', 'continue', 'keep reading'
end
