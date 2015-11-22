require 'calyx'

class Encounter < Calyx::Grammar
  start :monster
  rule :monster, '{monster_stats}. {monster_state}.'
  rule :monster_description, ''
  rule :monster_stats, 'GIANT SPIDER (STRENGTH 18, STAMINA 12)', 'GOBLIN (STRENGTH 12, STAMINA 8)'
  rule :monster_state, :aggressive, :timid, :watchful, :inattentive
  rule :aggressive, 'You must FIGHT. The monster gains initiative.'
  rule :timid, "It seems afraid of you. Make an attack roll to attempt to scare it off.\n\n- If you succeed, the creature {runs_off} into the shadows. You may continue to the exits.\n- If you fail, you must FIGHT. You gain initiative."
  rule :runs_away, 'runs off', 'scuttles away', 'disappears', 'retreats'
  rule :watchful, 'You must FIGHT. You gain initiative.'
  rule :inattentive, "The creature is asleep. Make an attack roll to attempt to sneak past without it noticing you.\n\n- If you startle and wake the creature, you must FIGHT.\n- If you sneak past unnoticed, you may continue to the exits."
end
