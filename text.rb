require './plot'
require './entrance'
require './introduction'
require './space'
require './directions'
require './chamber'
require './labyrinth'

puts "# #{Plot.generate_title}"
puts
puts "A generated gamebook."
puts
puts "By Mark Rickerby for NaNoGenMo2015."
puts

intro = Introduction.new

puts "## Prologue"
puts
puts intro.generate
puts

labyrinth = Labyrinth.new(1000)
labyrinth.generate

labyrinth.chambers.each do |chamber|
  puts "## #{chamber.section_heading}"
  puts
  puts chamber.section_body
  puts
  puts chamber.exit_directions
  puts
end
