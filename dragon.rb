require 'calyx'

class Dragon < Calyx::Grammar
  start :spotted_by_dragon
  rule :spotted_by_dragon, :dragon_insult, :dragon_sarcasm
  rule :dragon_article, 'the dragon'
  rule :annoyed_verb, 'grumbles', 'sighs', 'snorts'
  rule :insulting_identity, ['murderous hobo', 0.5], ['petty criminal', 0.25], ['ignorant tourist', 0.25]
  rule :with_wanderlust, ' with wanderlust', ' who should have stayed at home', ''
  rule :dragon_insult, '“Another {insulting_identity}{with_wanderlust},” {annoyed_verb} {dragon_article}. {dragon_futility_remark}'
  rule :dragon_sarcasm, '{dragon_sarcasm_remark} says {dragon_article} {dragon_sarasm_tone}. {dragon_futility_remark}'
  rule :dragon_sarcasm_remark, '“What a surprise,”', '“Well this is new,”'
  rule :dragon_sarasm_tone, 'sarcastically', 'sardonically'
  rule :dragon_futility_remark, '“How many more of you are there?”', '“Surely you don’t expect to survive this?”'
end

dragon = Dragon.new
puts dragon.generate
