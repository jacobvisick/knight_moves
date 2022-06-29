# https://www.theodinproject.com/lessons/ruby-knights-travails
# create a tree of potential moves for the knight, then search that tree for the shortest path to particular square
#
#    [can move] [can move]            [can move]    [can move]
#      |          |                       |            |
#      ==============[current space node]==============     ------[etc]
#      |          |                       |            |    |
#    [can move] [can move]            [can move]    [can move]--->
#
# BFS! DFS would be infinite loop (i.e. children refer to each other, so cannot explore all children first)
# BFS = add all neighbors to queue, explore one at a time
#
#  potential_moves = [
#    [x+1, y+2],
#    [x-1, y+2],
#    [x+2, y+1],
#    [x+2, y-1],
#    [x-2, y+1],
#    [x-2, y-1],
#    [x-1, y-2],
#    [x+1, y-2]
#  ]

class Node
  attr_reader :coordinates, :possible_moves

  def initialize(coords)
    @coordinates = coords
    x, y = coords
    @possible_moves = [
      [x+1, y+2],
      [x-1, y+2],
      [x+2, y+1],
      [x+2, y-1],
      [x-2, y+1],
      [x-2, y-1],
      [x-1, y-2],
      [x+1, y-2]
    ].filter { |x, y| x.between?(0,7) && y.between?(0,7) }

  end

end 

def knight_moves(start, finish, queue = [[start]], distance = 0)
  layer = queue.shift

  next_layer = []
  layer.each do |coord|
    return distance if coord == finish
    node = Node.new(coord)

    if node.possible_moves.include?(finish) then
       return distance + 1
    else
      next_layer.push(node.possible_moves)
    end
  end

  queue = next_layer
  knight_moves(start, finish, queue, distance + 1)
end

p knight_moves([3,3], [4,3]) # 3 == [[3,3],[4,5],[2,4][4,3]]
p knight_moves([0,0], [1,2]) # 1 == [[0,0],[1,2]]
p knight_moves([3,3], [0,0]) # 2 == [[3,3],[1,2],[0,0]]