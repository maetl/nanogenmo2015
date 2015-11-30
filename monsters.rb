module Monsters
  class Bestiary
    ANIMALS = [:dire_bat, :bristle_boar, :diseased_rat, :pit_viper, :giant_lizard, :giant_scorpion, :giant_spider]

    HUMANOIDS = [:goblin, :cave_troll, :ogre]

    MONSTROSITIES = [:blood_worm, :death_worm]

    OOZES = [:slime, :carnivorous_blob, :shoggoth]

    UNDEAD = [:skeleton, :ghoul, :murder_crow]

    INDEX = [ANIMALS, HUMANOIDS, MONSTROSITIES, OOZES, UNDEAD]

    def generate
      send(generate_monster)
    end

    def generate_text
      monster = generate
      "#{monster[:name].upcase} (STRENGTH: #{monster[:strength]}, STAMINA: #{monster[:stamina]})"
    end

    def generate_monster
      generate_type.sample
    end

    def generate_type
      INDEX.sample
    end

    def all_text
      INDEX.reduce([]) do |index, type|
        index << type.reduce([]) do |types, ref|
          monster = send(ref)
          types << "#{monster[:name].upcase} (STRENGTH: #{monster[:strength]}, STAMINA: #{monster[:stamina]})"
        end
      end.flatten
    end

    def dire_bat
      { strength: 7, stamina: 7, name: 'Dire Bat' }
    end

    def bristle_boar
      { strength: 14, stamina: 18, name: 'Bristle Boar' }
    end

    def diseased_rat
      { strength: 5, stamina: 3, name: 'Diseased Rat' }
    end

    def pit_viper
      { strength: 8, stamina: 6, name: 'Pit Viper' }
    end

    def giant_lizard
      { strength: 8, stamina: 6, name: 'Pit Viper' }
    end

    def giant_scorpion
      { strength: 12, stamina: 12, name: 'Giant Scorpion' }
    end

    def giant_spider
      { strength: 12, stamina: 12, name: 'Giant Spider' }
    end

    def goblin
      { strength: 8, stamina: 6, name: 'Pit Viper' }
    end

    def cave_troll
      { strength: 14, stamina: 20, name: 'Cave Troll' }
    end

    def ogre
      { strength: 12, stamina: 20, name: 'Ogre' }
    end

    def blood_worm
      { strength: 10, stamina: 12, name: 'Blood Worm' }
    end

    def death_worm
      { strength: 10, stamina: 18, name: 'Death Worm' }
    end

    def slime
      { strength: 6, stamina: 7, name: 'Slime' }
    end

    def carnivorous_blob
      { strength: 10, stamina: 14, name: 'Carnivorous Blob' }
    end

    def shoggoth
      { strength: 12, stamina: 20, name: 'Shoggoth' }
    end

    def skeleton
      { strength: 9, stamina: 9, name: 'Skeleton' }
    end

    def ghoul
      { strength: 10, stamina: 12, name: 'Ghoul' }
    end

    def murder_crow
      { strength: 8, stamina: 8, name: 'Murder Crow' }
    end
  end
end
