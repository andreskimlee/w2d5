class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    new_arr = [] 
    self.each do |ele|
      if ele.is_a?(String) 
        new_arr << ele.hash 
      else 
        new_arr << ele.object_id.hash
      end 
      new_arr
    end   
  end
end

class String
  #ord 
  def hash 
    arr = [] 
    self.chars.each do |letter|
      arr << letter.object_id.hash 
    end
    arr 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arr = [] 
    arr << self.keys.hash 
    arr << self.values.hash 
    arr  
  end
end


