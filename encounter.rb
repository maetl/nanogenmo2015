require 'calyx'

class Encounter < Calyx::Grammar
  start :monster
  rule :monster, '{monster_stats}. {monster_state}.'
  rule :monster_description, ''
  rule :monster_stats, 'GIANT SPIDER (STRENGTH 18, STAMINA 12)', 'GOBLIN (STRENGTH 12, STAMINA 8)'
  rule :monster_state, :aggressive, :timid, :watchful, :inattentive
  rule :aggressive, 'You must FIGHT. The monster gains initiative.'
  rule :timid, "It seems afraid of you. Make a successful attack roll to scare it off.\n\n- If you succeed, the creature {runs_away} into the shadows. You may continue to the exits.\n- If you fail, you must FIGHT. You gain initiative."
  rule :runs_away, 'runs away', 'runs off', 'scuttles off', 'scuttles away', 'disappears', 'retreats'
  rule :watchful, 'You must FIGHT. You gain initiative.'
  rule :inattentive, "The creature is asleep. Make a successful attack roll to sneak past without it noticing you.\n\n- If you startle and wake the creature, you must FIGHT.\n- If you sneak past unnoticed, you may continue to the exits."
end

class MonsterEncounter < Calyx::Grammar
  start :monster_deadly

  rule :monster_encounter, [:monster_deadly, 0.05], [:monster_hostile, 0.45], [:monster_neutral, 0.5]
  rule :monster_deadly, :monster_basilisk
  rule :monster_hostile, ''
  rule :monster_neutral, ''

  rule :monster_bulky, '{bulky_movement.capitalize} {room_movement} is'
  rule :room_movement, 'towards you', 'ahead of you'
  rule :bulky_movement, 'moving', 'lumbering', 'moving sluggishly', 'stamping', 'stomping', 'trampling'

  rule :monster_basilisk, '{monster_bulky} a giant basilisk. As you {freeze_reaction}, the {reptilian_adj} {reptilian_noun} {head_movement} its head and {petrifying_gaze_strike}. {petrifying_gaze_death}'

  rule :petrifying_gaze_strike, 'its petrifying gaze {strikes} you head on', 'you {stare_directly} into its petrifying gaze'
  rule :petrifying_gaze_death, '{last_memory_flash} is the {horrific} projection from its eyes as your {petrifying_gaze_body} into {petrifying_gaze_stone}.'
  rule :petrifying_gaze_body, 'body rapidly {fuses}', 'body {fuses}'
  rule :petrifying_gaze_stone, 'cold stone', 'solid stone'

  rule :strikes, 'strikes', 'meets', 'hits'
  rule :stare_directly, 'stare straight', 'stare directly'
  rule :fuses, 'freezes', 'fuses', 'hardens'

  rule :last_memory_flash, 'The {last_memory_final} thing you {last_memory_experience}', 'Your {last_memory_final} {last_memory_moment}'
  rule :last_memory_experience, 'remember', 'see', 'experience', 'are consciously aware of'
  rule :last_memory_moment, 'experience', 'moment of awareness', 'moment of experience'
  rule :last_memory_final, 'final', 'last', 'very last'

  rule :reptilian_adj, 'scaly', 'dull coloured', 'scabrous', 'encrusted'
  rule :reptilian_noun, 'monster', 'reptile', 'lizard'

  rule :freeze_reaction, '{pause} with {shock}'
  rule :head_movement, 'turns', 'raises', 'lifts'
  rule :shock, 'shock', 'fright', 'fear'
  rule :pause, 'freeze', 'pause', 'step back', 'stand frozen'
  rule :horrific, 'horrifying', 'terrifying', 'abyssal'
end
