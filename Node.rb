class Node
  attr_accessor :state, :parent, :successors, :fvalue, :gvalue, :hvalue, :successors
  @dimension = 3
  
  def initialize(state, parent = nil)
    @state = state
    @fvalue = 0
    @gvalue = 0
    @hvalue = 0
    @parent = parent
    @successors = Array.new
  end
  
  def == obj    
    @state == obj.state
  end
  
  def to_s
    stringvalue = ""
    for i in 0..2 do
      for j in 0..2 do
        stringvalue +="#{@state[i][j].to_s + " " }"
      end
      stringvalue += "\n"
    end
    stringvalue
  end
  
  def calcFvalue
    @fvalue = @gvalue + @hvalue
  end
  
  def moveZeroLeft()
    i, j = getIndexOf 0
    @state[i][j] , @state[i][j-1] = @state[i][j-1], @state[i][j] 
  end
  
  def moveZeroRight()
    i, j = getIndexOf 0
    @state[i][j] , @state[i][j+1] = @state[i][j+1], @state[i][j] 
  end
  
  def moveZeroUp()    
    i, j = getIndexOf 0
    @state[i][j] , @state[i-1][j] = @state[i-1][j], @state[i][j] 
  end
  
  def moveZeroDown()    
    i, j = getIndexOf 0
    @state[i][j] , @state[i+1][j] = @state[i+1][j], @state[i][j] 
  end  
  
  def getIndexOf(number)
    result = Array.new
    for i in 0..2 do
      for j in 0..2 do
        if(@state[i][j] == number)
          result << i << j
          break
        end
      end
    end
    result
  end  
  
  def deep_copy
    Marshal.load(Marshal.dump(self))
  end
  
  def reset_node_attributes
    parent = nil
    successors = Array.new
    fvalue = 0
    gvalue = 0
    hvalue = 0
  end

  
  
end

  