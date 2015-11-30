QUEST = :defeat_monster
MONSTER_TYPE = [:dragon, :wizard].sample
MONSTER_NAME = ['Crimax', 'Croesus', 'Goroth', 'Hezak', 'Ir', 'Kael', 'Kalantir', 'Koydl', 'Mangarak', 'Maran', 'Mareberth', 'Merg', 'Mesech', 'Narok', 'Nefarus', 'Nothar', 'Ogardus', 'Omaniron', 'Ozorak', 'Polor', 'Porchos', 'Ranon', 'Rayth', 'Scius', 'Sesklos', 'Sethron', 'Sezer', 'Siguruk', 'Silveron', 'Skrymir', 'Slath', 'Sleeth', 'Sutha', 'Talberon', 'Tazoe', 'Tethra', 'Tiang', 'Tondril', 'Ugmar', 'Ungon', 'Vagor', 'Varag', 'Volux', 'Wrothag', 'Zymos'].sample
MONSTER_GENDER = [:m, :f, :t].sample
PRONOUN = { m: 'he', f: 'she', i: 'it' }
POSSESIVE_PRONOUN = { m: 'his', m: 'her', i: 'their' }
VILLAGE_NAME = ['Nuria', 'Orm', 'Qadir', 'Redthorn', 'Rythern', 'Sunshadow', 'Willen', 'Zathe'].sample

module Plot
  def self.generate_title
    style = [:under_village, :dungeon_of, :monster_of].sample
    if style == :dungeon_of
      dungeon = ['Dungeon', 'Lair', 'Caverns'].sample
      "The #{dungeon} of #{MONSTER_NAME}"
    elsif style == :monster_of
      "The #{MONSTER_TYPE.to_s.capitalize} of #{VILLAGE_NAME}"
    else
      shadow = ['Shadow', 'Darkness', 'Caverns']
      "The #{shadow} under #{VILLAGE_NAME}"
    end
  end
end
