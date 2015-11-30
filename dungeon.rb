require 'calyx'
require 'indefinite_article'
require './monsters'

MonsterGenerator = Monsters::Bestiary.new

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
  rule :trick_trap, '{room_description} {trick_trap_encounter}'
  rule :treasure, '{room_description} {treasure_encounter}'

  rule :treasure_encounter, 'You find {treasure_type} here.'
  rule :treasure_type, :metal_object, :gem_object
  rule :metal, 'gold', 'silver', 'bronze'
  rule :metal_object, '{metal} coins', '{metal} ingots'
  rule :gem_object, '{gem_container} {precious} {gems}'
  rule :gem_container, 'a bag of', 'a chest containing', 'a box of'
  rule :precious, 'precious', 'exquisite'
  rule :gems, 'rubies', 'emeralds', 'diamonds'

  #rule :monster_encounter, [:monster_deadly, 0.05], [:monster_hostile, 0.45], [:monster_neutral, 0.5]
  rule :trick_trap_encounter, '{trick_trap_intro} {trick_trap_encounter_type}'

  rule :trigger_trap, '{you_continue} forward {until} {noticing}'
  rule :until, 'until', 'before'
  rule :you_continue, 'You step cautiously', 'You contine'
  rule :noticing, 'noticing', 'suddenly stumbling over'

  rule :trick_trap_intro, 'There is something {strange} about this place.', 'Something here feels {strange}.'
  rule :strange, 'not quite right', 'strange', 'odd'

  #rule :trick_trap_encounter_type, [:trap_deadly, 0.05], [:trap_mechanical, 0.6], [:trap_magical, 0.35]
  #rule :trap_deadly, 'The deadly trap kills you instantly.'

  rule :trick_trap_encounter_type, :trap_mechanical

  rule :trap_mechanical, '{trigger_trap} a {trap_mechanical_type}. {save_against_trap}{br}{failure}{br}{trap_mechanical_effect} {trap_mechanical_procedure}{br}{success}'
  rule :trap_mechanical_type, 'pressure plate', 'tripwire', 'loose flagstone'
  rule :trap_mechanical_effect, 'A {poison_tipped}{trap_weapon} {trap_weapon_effect} and strikes you.'

  rule :trap_weapon, 'spear', 'blade', 'saw blade', 'spike'
  rule :trap_weapon_effect, '{shoots_out} of a hidden compartment', '{drops_down} from the ceiling'

  rule :trap_mechanical_procedure, '{trap_mechanical_damage} from your STAMINA. {stamina_depleted_ending}'
  rule :trap_mechanical_damage, 'Roll 1D6 and deduct the result', 'Deduct {damage_number} points', 'Take {damage_number} points'
  rule :damage_number, '2', '3'
  rule :stamina_depleted_ending, 'If your STAMINA reaches 0 or lower, this is THE END.'

  rule :poison_tipped, '', 'poison-tipped ', 'poison-coated '
  rule :shoots_out, 'shoots out', 'snaps out'
  rule :drops_down, 'drops down', 'falls'

  rule :monster_treasure_encounter, '{monster_only_encounter} {treasure_encounter} If you defeat the monster, you can take the treasure.'

  rule :monster_only_encounter, [:monster_deadly, 0.05], [:monster_hostile, 0.95]
  rule :monster_deadly, :monster_basilisk, :monster_gorgon

  rule :monster_hostile, 'There is a monster here: {monster_stats}. {monster_state}'
  rule :monster_description, ''
  rule :monster_stats, *MonsterGenerator.all_text
  rule :monster_state, :aggressive, :timid, :watchful, :inattentive
  rule :aggressive, 'You must FIGHT. The monster gains initiative.'
  rule :timid, "It seems afraid of you. Make a successful attack roll to scare it off.\n\n- If you succeed, the creature {runs_away} into the shadows. You may continue to the exits.\n- If you fail, you must FIGHT. You gain initiative."
  rule :runs_away, 'runs away', 'runs off', 'scuttles off', 'scuttles away', 'disappears', 'retreats'
  rule :watchful, 'You must FIGHT. You gain initiative.'
  rule :inattentive, "The creature is asleep. Make a successful attack roll to sneak past without it noticing you.\n\n- If you startle and wake the creature, you must FIGHT.\n- If you sneak past unnoticed, you may continue to the exits."


  rule :monster_bulky, '{bulky_movement.capitalize} {room_movement} is'
  rule :room_movement, 'towards you', 'ahead of you'
  rule :bulky_movement, 'moving', 'lumbering', 'moving sluggishly', 'stamping', 'stomping', 'trampling'

  rule :br, "\n\n"
  rule :success, 'SUCCESS:'
  rule :failure, 'FAILURE:'

  rule :monster_basilisk, '{monster_bulky} a {monstrous_adj} basilisk. {save_against_attack}{br}{failure}{br}As you {freeze_reaction}, the {reptilian_adj} {reptilian_noun} {head_movement} its head and {petrifying_gaze_strike}. {petrifying_gaze_death} THE END.{br}{success}'
  rule :monster_gorgon, '{monster_bulky} a {gorgon_adj} gorgon. {clouds.capitalize} of {green} smoke {puff} from its {mouth}. {save_against_attack}{br}{failure}{br}As you {freeze_reaction}, the {metallic_adj} {beast_noun} snaps open its jaws and {petrifying_breath_strike}. {petrifying_breath_death} THE END.{br}{success}'

  rule :gorgon_adj, 'bull-like', :monstrous_adj
  rule :monstrous_adj, 'monstrous', 'giant'

  rule :green, 'green', 'viridescent'
  rule :clouds, 'plumes', 'clouds', 'faint clouds', 'faint plumes', 'a faint mist'
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

  rule :assembly_room, 'gallery', 'great hall', 'hall', 'antechamber', 'assembly hall', :arena
  rule :incaceration_room, 'prison', 'cage'
  rule :military_room, 'guardroom', 'barracks', 'armory', :combat_pit
  rule :religious_room, :shrine
  rule :industry_room, 'forge', :workshop, :tannery
  rule :scholarly_room, 'library', 'study', 'scriptorium', 'laboratory', 'map room'
  rule :farming_room, 'barn', 'stable', 'pen'
  rule :domestic_room, 'wardrobe', 'pantry', 'bedroom', 'closet', :kitchen
  rule :decadent_room, 'statuary', 'museum', 'treasury'

  rule :tannery, 'tannery', 'tannery {with_foul_smell}'
  rule :kitchen, 'kitchen', 'kitchen {scattered_with}', 'kitchen {with_foul_smell}'
  rule :workshop, 'workshop', 'workshop {scattered_with}', 'workshop {with_foul_smell}'
  rule :combat_pit, 'combat pit', 'combat pit {stone_interior}', 'combat pit {with_foul_smell}'
  rule :arena, 'arena', 'arena {stone_interior}'
  rule :shrine, 'shrine', 'shrine {shrine_decoration}'

  rule :shrine_decoration, :stone_interior
  #rule :shrine_contents, 'altar, arch, drapery, gilt, inlay, relief, dias, dome, font, fresco, mosaic, painting, pews, podium, idol, magic, candelabra, lamp, torches, pedestal, pillar, column, tapestry, offertory container, reliquary, offertory dish, oil, perfume, alcove, glass window, incense burner, alcohol, holy symbols, remains'.split(", ")
  rule :shrine_features, 'altar', 'arch', 'drapery', 'gilt', 'inlay'

  rule :scattered_with, 'scattered with {scattered_with_noun}'
  rule :scattered_with_noun, 'shards of pottery', 'fragments of clay', 'flotsam and jetsam'

  rule :with_foul_smell, 'with a {foul} {smell}'
  rule :foul, 'foul', 'unpleasant', 'fetid', 'putrid', 'repellent', 'stinking'
  rule :smell, 'smell', 'odour', 'stink', 'stench'

  rule :verb_hewn, 'hewn', 'cut', 'shaped', 'carved'
  rule :adj_surface, 'smooth', 'rough', 'pitted'
  rule :noun_stone, 'stone', 'rock', 'granite', 'sandstone', 'shale', 'chalk', 'gneiss', 'schist', 'quartz', 'crystal'
  rule :prep_from, 'from', 'out of'

  rule :stone_interior, '{verb_hewn} {prep_from} {adj_surface} {noun_stone}'

  rule :save_against_trap, 'To {dodge} the trap, you must {movement} {safety}. {skill_test}'
  rule :save_against_attack, 'To {dodge} the attack, you must {movement} {safety}. {skill_test}'
  rule :dodge, 'dodge', 'avoid'
  rule :movement, 'dive', 'leap', 'jump'
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
