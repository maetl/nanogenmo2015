require 'calyx'

QUEST = :defeat_monster
MONSTER_TYPE = :dragon
MONSTER_NAME = ['Crimax', 'Croesus', 'Goroth', 'Hezak', 'Ir', 'Kael', 'Kalantir', 'Koydl', 'Mangarak', 'Maran', 'Mareberth', 'Merg', 'Mesech', 'Narok', 'Nefarus', 'Nothar', 'Ogardus', 'Omaniron', 'Ozorak', 'Polor', 'Porchos', 'Ranon', 'Rayth', 'Scius', 'Sesklos', 'Sethron', 'Sezer', 'Siguruk', 'Silveron', 'Skrymir', 'Slath', 'Sleeth', 'Sutha', 'Talberon', 'Tazoe', 'Tethra', 'Tiang', 'Tondril', 'Ugmar', 'Ungon', 'Vagor', 'Varag', 'Volux', 'Wrothag', 'Zymos'].sample

class Introduction < Calyx::Grammar
  start QUEST
  rule :defeat_monster, '{monster_name} is a {monster_type} {impacts_of_monster}.'
  rule :monster_name, MONSTER_NAME
  rule :monster_type, MONSTER_TYPE
  rule :dragon, '{dragon_impression_adj} {dragon_appearance_adj} dragon'
  rule :dragon_impression_adj, 'monstrous', 'horrifying', 'hideous', 'teratoid'
  rule :dragon_appearance_adj, 'green', 'grey', 'white', 'red', 'black', 'yellow'
  rule :impacts_of_monster, 'whose {impact_description} {impact_effects}'
  rule :impact_description, 'evil', 'corruption'
  rule :impact_effects, 'is {impact_spread}'
  rule :impact_spread, 'spreading {impact_spread_to}{impact_spread_conj}'
  rule :impact_spread_to, 'above ground', 'to the surface', 'through{out} the air and water'
  rule :out, 'out', ''
  rule :impact_spread_conj, ' and {impact_corruption}', ''
  rule :impact_corruption, 'poisoning the countryside'
end
