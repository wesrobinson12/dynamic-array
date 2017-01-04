require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  def [](index)
    check_index(index)
    store[index]
  end

  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  def pop
    raise 'index out of bounds' unless length > 0
    last = self[length - 1]
    self[length - 1], self.length = nil, self.length - 1
    last
  end

  def push(val)
    resize! if length == capacity

    self.length += 1
    self[length - 1] = val

    nil
  end

  def shift
    raise 'index out of bounds' unless length > 0

    val = self[0]

    (1...length).each do |x|
      self[x-1] = self[x]
    end

    self.length -= 1

    val
  end

  def unshift(val)
    resize! if length == capacity

    self.length += 1

    (self.length-1).downto(1).each do |x|
      self[x] = self[x-1]
    end

    self[0] = val

    val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    unless (index >= 0 && index < length)
      raise 'index out of bounds'
    end
  end

  def resize!
    new_store = StaticArray.new(capacity * 2)
    (0...length).each { |x| new_store[x] = self[x] }
    self.capacity *= 2
    store = new_store
  end
end
