require 'calyx'
require 'indefinite_article'

class Introduction < Calyx::Grammar
  start :introduction
  rule :br, "\n\n"
  rule :introduction, '{first_line}.{br}{quest}.{br}{entrance_description}. {rumours}.{br}{starting_choice}'
  rule :entrance_description, 'The entrance to {monster_name}’s {dungeon} is {entrance} on the outskirts of {village_name}', 'Somewhere near {village_name} is the entrance to {monster_name}’s {dungeon}'
  rule :dungeon, 'dungeon', 'lair'

  rule :rumours, '{rumours_treasure}, {rumours_lost}'
  rule :rumours_treasure, '{others.capitalize} may have found {riches} there', '{others.capitalize} have found {riches} in {treasure_underground} there'
  rule :rumours_lost, 'though many {who_enter}are never seen again'
  rule :who_enter, 'who enter ', ''
  rule :others, 'some', 'others'
  rule :riches, 'riches', 'fortunes'
  rule :treasure_underground, 'treasure', 'treasure and gold'

  rule :starting_choice, "- To search for the entrance and ENTER the dungeon, turn to **§1**."
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
  rule :stories_fear, 'creeping', 'lurking', 'spreading', 'chilling'
  rule :stories_energy, 'horror', 'darkness', 'shadow', 'scourge'
  rule :stories_impact, '{seem_verb} {more_and_more} {disturbing} as you {travel_closer}'
  rule :more_and_more, 'more and more', 'increasingly'
  rule :seem_verb, 'grow', 'seem', 'get', 'become'
  rule :disturbing, 'disturbing', 'unhinged', 'alarming', 'threatening'
  rule :travel_closer, 'get closer to the village of {village_name}'
  rule :village_name, VILLAGE_NAME
  rule :quest, QUEST
  rule :defeat_monster, 'The {stories_noun} tell of {monster_name}, {monster_type} {impacts_of_monster}. The {people} {ask_for_help} {help} {this_menace} {before_toll}'
  rule :monster_name, MONSTER_NAME
  rule :monster_type, MONSTER_TYPE
  rule :wizard,  '{wizard_impression_adj.with_indefinite_article}{wizard_appearance_adj} wizard'
  rule :wizard_noun, 'wizard', 'mage', 'warlock'
  rule :wizard_impression_adj, 'corrupt', 'depraved', 'demented', 'psychotic', 'evil'
  rule :wizard_appearance_adj, ' dark', ''
  rule :dragon, '{dragon_impression_adj.with_indefinite_article} {dragon_appearance_adj} dragon'
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
  rule :people, 'people of {village_name}', 'villagers'
  rule :ask_for_help, 'plead with you to', 'insist that you must', 'implore you to', 'beseech you to'
  rule :help, 'help fight', 'destroy', 'obliterate'
  rule :this_menace, 'this menace'
  rule :before_toll, 'before the darkness takes its toll'
end
