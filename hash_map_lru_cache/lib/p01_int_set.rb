class MaxIntSet
  attr_reader :store 
  def initialize(max)
    @max = max 
    @store = Array.new(max, false) 
  end

  def insert(num)
    raise "Out of bounds" if !is_valid?(num) 
    validate!(num) 
  end

  def remove(num)
    @store[num] = false if is_valid?(num)
  end

  def include?(num)
    return false if !is_valid?(num) 
    return @store[num] 
  end

  private

  def is_valid?(num)
    num >= 0 && num < @store.length
  end

  def validate!(num)
    @store[num] = true
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if !include?(num)
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      self[num] << num 
      @count += 1
      if @count >= num_buckets
        resize!
      end  
    end    
  end

  def remove(num)
    if include?(num)
      self[num].delete(num) 
      @count -= 1 
    end 
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = Array.new(num_buckets * 2 ) { Array.new }
    @store.each do |subarr| 
      subarr.each do |ele|
        new_mod = ele % new_size.length
        new_size[new_mod] << ele 
      end 
    end   
    @store = new_size 
  end

end
