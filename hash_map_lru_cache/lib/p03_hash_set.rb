class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      self[key] << key  
      @count += 1
      if @count >= num_buckets
        resize!
      end  
    end    
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
      if include?(key)
        self[key].delete(key) 
        @count -= 1 
    end 
  end

  private

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = Array.new(num_buckets * 2 ) { Array.new }
    @store.each do |subarr| 
      subarr.each do |ele|
        new_mod = ele.hash % new_size.length
        new_size[new_mod] << ele 
      end 
    end   
    @store = new_size 
  end
end
