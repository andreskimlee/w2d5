require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
  end

  def set(key, val)
    @count += 1
  end

  def get(key)
  end

  def delete(key)


    @count -=1
    if count >= num_buckets
      resize!
    end
  end

  def each(&prc)
    # prc ||= Proc.new { |k,v| }
    @store.each do |linked_list|
      linked_list.each do |node|
        prc.call(node.key, node.val)  
      end    
    end   
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_size = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |linked_list| 
      linked_list.each do |link|
        key = link.key
        val = link.val
        new_mod = key.hash % new_size.length
        new_size.set(key,val)
      end 
    end   
    @store = new_size 
  end

  def bucket(key)

    # optional but useful; return the bucket corresponding to `key`
  end
end
