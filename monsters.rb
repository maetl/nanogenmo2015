module Monsters
  class Bestiary
    #INDEX = [:animals, :humanoids, :monstrosities, :oozes, :undead]
    ANIMALS = [:dire_bat, :bristle_boar, :diseased_rat, :pit_viper, :giant_lizard, :giant_scorpion, :giant_spider]
    HUMANOIDS = [:goblin, :cave_troll, :ogre]
    MONSTROSITIES = [:blood_worm, :death_worm]
    OOZES = [:slime, :carnivorous_blob, :shoggoth]
    UNDEAD = [:skeleton, :ghoul, :murder_crow]

    INDEX = [ANIMALS, HUMANOIDS, MONSTROSITIES, OOZES, UNDEAD]

    def generate
      send(generate_monster)
    end

    def generate_monster
      generate_type.sample
    end

    def generate_type
      INDEX.sample
    end

    def dire_bat
      { skill: 7, strength: 7, stamina: 7, name: 'Dire Bat' }
    end

    def bristle_boar
      { skill: 9, strength: 14, stamina: 18, name: 'Bristle Boar' }
    end

    def diseased_rat
      { skill: 7, strength: 5, stamina: 3, name: 'Diseased Rat' }
    end

    def pit_viper
      { skill: 11, strength: 8, stamina: 6, name: 'Pit Viper' }
    end

    def giant_lizard
      { skill: 11, strength: 8, stamina: 6, name: 'Pit Viper' }
    end

    def giant_scorpion
      { skill: 10, strength: 12, stamina: 12, name: 'Giant Scorpion' }
    end

    def giant_scorpion
      { skill: 11, strength: 12, stamina: 12, name: 'Giant Spider' }
    end

    def goblin
      { skill: 11, strength: 8, stamina: 6, name: 'Pit Viper' }
    end

    def cave_troll
      { skill: 10, strength: 12, stamina: 12, name: 'Giant Scorpion' }
    end

    def ogre
      { skill: 11, strength: 12, stamina: 12, name: 'Giant Spider' }
    end

    def blood_worm
      { skill: 10, strength: 12, stamina: 12, name: 'Blood Worm' }
    end

    def death_worm
      { skill: 11, strength: 12, stamina: 12, name: 'Death Worm' }
    end

    def slime
      { skill: 11, strength: 12, stamina: 12, name: 'Slime' }

    end

    def carnivorous_blob
      { skill: 11, strength: 12, stamina: 12, name: 'Carnivorous Blob' }
    end

    def shoggoth
      { skill: 11, strength: 12, stamina: 12, name: 'Shoggoth' }
    end

    def skeleton
      { skill: 11, strength: 12, stamina: 12, name: 'Skeleton' }
    end

    def ghoul
      { skill: 11, strength: 12, stamina: 12, name: 'Ghoul' }
    end

    def murder_crow
      { skill: 11, strength: 12, stamina: 12, name: 'Murder Crow' }
    end

  end
end

monster = Monsters::Bestiary.new
puts monster.generate
