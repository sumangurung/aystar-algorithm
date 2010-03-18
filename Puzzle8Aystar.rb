class Puzzle8Aystar
  attr_accessor :startNode, :goalNode
  @openList
  @closedList
  
  def initialize(startNode, goalNode)
    @startNode = startNode
    @goalNode = goalNode
  end
  
  def searchInitialize
    @openList = Array.new
    @closedList = Array.new
  end
  
  def aystar()
    searchInitialize
    found = false
    
    @openList << @startNode
    while(!@openList.empty? && found == false)
      @openList.sort! {|a,b| a.fvalue <=> b.fvalue}

      bestNode = @openList.delete_at(0)      
      @closedList << bestNode     

      if(bestNode == @goalNode)
        found = true
        break
      else
        successors = expand(bestNode)
        successors.each do |e|

          e.parent = bestNode
          gFunc(e)

          #checking if the successor is in open list and if so, updating its parent and the gvalue, fvalue and add as nodes successor, if necessary
          @openList.each do |open|

            if(open == e)              
              if(e.gvalue < open.gvalue)

                open.gvalue = e.gvalue
                open.calcFvalue               
                open.parent = bestNode
                bestNode.successors << open
                open.successors.delete(bestNode) if open.successors.include?(bestNode)
              end
            end
          end

          #checking if the successor is in closed list and if so, updating its parent, gvalue, fvalue, and add as nodes successors if necessary and propagating the change
          @closedList.each do |closed|
            if(closed == e)
              if(e.gvalue < closed.gvalue)
                closed.gvalue = e.gvalue
                closed.calcFvalue
                bestNode.successors << closed
                closed.parent = bestNode
                closed.successors.delete(bestNode) if closed.successors.include?(bestNode)
                propagateChange(closed)
              end
            end
          end
          
          #if successor is not in open list and closed list, then add to nodes successors, calculate hvalue and fvalue and add to openlist

          if((!@openList.include?e) && (!@closedList.include?e))
            bestNode.successors << e
            
            yield(e, @goalNode)
            e.calcFvalue

            @openList << e
            
          end           
          
        end
      end      
    end
    
    if(found)
      printPath(bestNode)
    else
      puts 'No Path found'
    end
  end
  

  
  def propagateChange(node)
    toDoList = Array.new
    toDoList << node
    while(!toDoList.empty?)
      curNode = toDoList.pop
      curNode.successors.each do |x|

        gFunc(x)
        toDoList << x        
      end
    end   

  end
  
  

  
  def expand(node)
    successors = Array.new
    indexRow, indexCol = node.getIndexOf(0)
   # puts "indexrow #{indexRow} , indexcol #{indexCol}"
    if(indexRow>0)
      temp  = get_deep_copy(node)
      temp.moveZeroUp 
      successors << temp
    end
    if(indexRow < 2)      
      temp = get_deep_copy(node)
      temp.moveZeroDown
      successors << temp
    end
    if(indexCol > 0 )
      temp = get_deep_copy(node)
      temp.moveZeroLeft
      successors << temp
    end
    if(indexCol < 2)
      temp = get_deep_copy(node)
      temp.moveZeroRight   
      successors << temp
    end
    
    successors           
  end 
    
  def get_deep_copy(node)
    temp = node.deep_copy
    temp.reset_node_attributes
    temp
  end
  

  
  def gFunc(node)
    node.gvalue = node.parent.gvalue + 1
  end
  
    def printPath(node)
    depth = 0
    stack = Array.new    
    until node.nil?
      stack.push node
      node = node.parent
      depth += 1  
    end    

    stack.reverse.each do |x|
      puts ""
      puts x
    end    
    puts "Puzzle solved in #{depth} moves"
  end
  

end

    
    
      