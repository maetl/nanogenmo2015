require 'calyx'

class Entrance < Calyx::Grammar
  start :entrances
  rule :entrances, 'staircase in a ruined crypt', 'down a well', 'beneath a sewer grate', 'behind a waterfall', 'cave entrance', 'through the roots of a tree', 'a large stone door'
end
