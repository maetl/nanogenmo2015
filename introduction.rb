require 'calyx'

require './entrance'

QUEST = :defeat_monster
MONSTER_TYPE = :dragon
MONSTER_NAME = ['Crimax', 'Croesus', 'Goroth', 'Hezak', 'Ir', 'Kael', 'Kalantir', 'Koydl', 'Mangarak', 'Maran', 'Mareberth', 'Merg', 'Mesech', 'Narok', 'Nefarus', 'Nothar', 'Ogardus', 'Omaniron', 'Ozorak', 'Polor', 'Porchos', 'Ranon', 'Rayth', 'Scius', 'Sesklos', 'Sethron', 'Sezer', 'Siguruk', 'Silveron', 'Skrymir', 'Slath', 'Sleeth', 'Sutha', 'Talberon', 'Tazoe', 'Tethra', 'Tiang', 'Tondril', 'Ugmar', 'Ungon', 'Vagor', 'Varag', 'Volux', 'Wrothag', 'Zymos'].sample
MONSTER_GENDER = [:m, :f, :t].sample
PRONOUN = { m: 'he', f: 'she', i: 'it' }
POSSESIVE_PRONOUN = { m: 'his', m: 'her', i: 'their' }
VILLAGE_NAME = ['Notty', 'Nuria', 'Orm', 'Pildor', 'Qadir', 'Redthorn', 'Rythern', 'Sunshadow', 'Willen', 'Zathe'].sample

class Introduction < Calyx::Grammar
  start :introduction
  rule :introduction, "{first_line}.\n\n{quest}.\n\n{entrance_description}.\n\n{starting_choice}"
  rule :entrance_description, 'The entrance to {monster_name}’s lair is {entrance} on the outskirts of {village_name}'
  rule :starting_choice, "- **To enter the dungeon and defeat the #{MONSTER_TYPE} turn to §1.**"
  rule :entrance, Entrance.new.generate
  #rule :first_line, :local_legend_trope, :tavern_trope, :captive_trope
  rule :first_line, :local_legend_trope
  rule :local_legend_trope, 'It is said that {curse_fallen} {these_lands}. {stories_you_hear}', 'Throughout your journey in {these_lands}, {noticed_corruption}'
  rule :curse_fallen, 'a {curse_noun} has {curse_verb} upon'
  rule :curse_verb, 'fallen', 'descended', 'come'
  rule :curse_noun, 'curse', 'bane', 'blight', 'plague'
  rule :these_lands, 'these lands', 'this land'
  rule :noticed_corruption, 'you’ve {heard_stories}'
  rule :stories_you_hear, 'The {stories_noun} {stories_subject} {stories_impact}', 'You’ve heard {stories_noun} {stories_subject} which {stories_impact}'
  rule :heard_stories, 'heard {stories_adj} {stories_noun} {stories_subject} that {stories_impact}'
  rule :stories_adj, 'whispered', 'subtle'
  rule :stories_noun, 'rumours', 'legends', 'tales', 'stories'
  rule :stories_subject, 'of a {stories_fear} {stories_energy}'
  rule :stories_fear, 'creeping', 'lurking', 'growing', 'chilling', 'teratoid'
  rule :stories_energy, 'horror', 'darkness', 'shadow'
  rule :stories_impact, '{seem_verb} {more_and_more} {disturbing} as you {travel_closer}'
  rule :more_and_more, 'more and more', 'increasingly'
  rule :seem_verb, 'are', 'seem', 'get', 'become'
  rule :disturbing, 'disturbing', 'unhinged', 'alarming', 'threatening'
  rule :travel_closer, 'get closer to the village of {village_name}'
  rule :village_name, VILLAGE_NAME
  rule :quest, QUEST
  rule :defeat_monster, '{monster_name} is a {monster_type} {impacts_of_monster}'
  rule :monster_name, MONSTER_NAME
  rule :monster_type, MONSTER_TYPE
  rule :dragon, '{dragon_impression_adj} {dragon_appearance_adj} dragon'
  rule :dragon_impression_adj, 'monstrous', 'horrifying', 'hideous'
  rule :dragon_appearance_adj, 'green', 'grey', 'white', 'red', 'black', 'yellow'
  rule :impacts_of_monster, 'whose {impact_description} {impact_effects}'
  rule :impact_description, 'evil', 'corruption', 'foul magic', 'fell magic', 'malevolent influence'
  rule :impact_effects, 'is {impact_spread}'
  rule :impact_spread, 'spreading {impact_spread_to}{impact_spread_conj}'
  rule :impact_spread_to, 'above ground', 'to the surface', 'through{out} the air and water'
  rule :out, 'out', ''
  rule :impact_spread_conj, ' and {impact_corruption}', ''
  rule :impact_corruption, 'poisoning the countryside'
end
