class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    self.prev.next = self.next
    if !self.next.nil?
      self.next.prev = self.prev
    end
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    return nil if @head.next == @tail
    @head.next
  end

  def last
    return nil if @tail.prev == @head
    @tail.prev
  end

  def empty?
    @head.next == @tail && @tail.prev == @head 
  end

  def get(key)
    return if empty?
    each do |link|
      return link.val if link.key == key
    end   
    nil
  end

  def include?(key)
    return false if empty?
    each do |link|
      return true if link.key == key
    end   
    false  
  end

  def append(key, val)
      new_node = Node.new(key,val)
      if last.nil?
        @tail.prev = new_node
        @head.next = new_node
        new_node.next = @tail
        new_node.prev = @head
      else
        current_last = last
        current_last.next = new_node
        new_node.prev = current_last
        new_node.next = @tail
        @tail.prev = new_node
      end
  end

  def update(key, val)
    return if empty?

    each do |link|
      if link.key == key
        link.val = val
        return
      end
    end
  end

  def remove(key)
    return if empty?
    each do |link|
      if link.key == key
        link.remove
        return
      end
    end
  end

  def each
    current_node = first 
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
    self    
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
