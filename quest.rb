class Quest
  def self.goals
    #[:defeat_monster, :steal_artifact, :escape_dungeon, :dispel_curse]
    [:defeat_monster]
  end

  def self.generate
    self.new(self.goals.sample)
  end

  attr_reader :goal

  def initialize(goal)
    @goal = goal
  end

  def to_s
    @goal.to_s
  end
end

class DefeatMonster
  def monsters
    #[:dragon, :warlock, :vampire, :orc_chieftan]
    [:dragon]
  end

  def monster_name

  end
end

class MonsterName

end
