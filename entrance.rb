require 'calyx'

class Entrance < Calyx::Grammar
  start :entrances
  rule :entrances, 'in a ruined crypt', 'down a well', 'beneath a sewer grate', 'behind a waterfall', 'in a cave', 'through the roots of a tree', 'a large stone door'
end
