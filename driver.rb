require 'Puzzle8Aystar.rb'
require 'Node.rb'


def mda(width, height)
  a = Array.new(width)
  a.map! {Array.new(height)}
  return a
end
  
def second_heuristic(startstate, endstate)
  puzzle = Puzzle8Aystar.new(Node.new(startstate), Node.new(endstate))

  puts 'find path using the second heuristic function. Implemented using closure'

  puzzle.aystar do   |node, goalnode|
    count = 0
    for i in 0..2 do
      for j in 0..2 do
        l, m = goalnode.getIndexOf(node.state[i][j])
        count += (i-l).abs + (j-m).abs        
      end
    end

    node.hvalue = count
  end
end

def first_heuristic(startstate, endstate)
  puzzle8 = Puzzle8Aystar.new(Node.new(startstate), Node.new(endstate))
  puts 'find path using the first heuristic function. Implemented using closure'
  puzzle8.aystar do   |node, goalnode|
    count = 0
    for i in 0..2 do
      for j in 0..2 do
        if(node.state[i][j] != goalnode.state[i][j])
          count += 1
        end
      end
    end

    node.hvalue = count
  end
end




startstate = mda(3,3)
endstate = mda(3,3)

startstate =[[3,7,6],[5,1,2], [4,0,8]]
endstate = [[5,3,6],[7,0,2],[4,1,8]]
first_heuristic(startstate, endstate)


startstate =[[2,1,6],[4,0,8], [7,5,3]]
endstate = [[1,2,3],[8,0,4],[7,6,5]]
second_heuristic(startstate, endstate)

#startstate =[[2,4,3],[1,0,6], [7,5,8]]
#startstate =[[1,5,8],[0,2,3], [4,6,7]]
#startstate =[[2,0,7],[8,5,4], [3,6,1]]
#startstate = [8,7,6],[5,4,3],[2,1,0]]
#endstate = [[1,2,3],[4,5,6],[7,8,0]]






