class Array2D < Array
  def initialize(width, height)
    a = Array.new(width)
    a.map! {Array.new(height)}
    return a
  end  
end

