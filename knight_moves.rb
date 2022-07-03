# https://www.theodinproject.com/lessons/ruby-knights-travails
# create a tree of potential moves for the knight, then search that tree for the shortest path to particular square

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

def knight_moves(start, finish, queue = [[start]])
  next_layer = []
  queue.each do |path|
    coord = path[-1]
    return path if coord == finish

    node = Node.new(coord)
    possible_moves = node.possible_moves
    if possible_moves.include? finish then
      return path.push(finish)
    else
      possible_moves.each do |move|
        new_path = path.dup
        new_path.push(move)
        next_layer.push(new_path)
      end
    end
  end

  queue = next_layer
  knight_moves(start, finish, queue)
end

def knight_moves_log(start, finish)
  path = knight_moves(start, finish)
  puts "You can go from #{start} to #{finish} in #{path.length} moves."
  puts "Here is the path:"
  path.each_with_index { |move, index| puts "#{index + 1}) #{move}" }
end

knight_moves_log([3,3], [4,3]) # 3 == [[3,3],[4,5],[2,4][4,3]]
knight_moves_log([0,0], [1,2]) # 1 == [[0,0],[1,2]]
knight_moves_log([3,3], [0,0]) # 2 == [[3,3],[1,2],[0,0]]