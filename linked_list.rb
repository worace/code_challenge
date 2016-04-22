class Deque
  attr_reader :rest

  def initialize(data = nil, rest = nil)
    @data = data
    @rest = rest
  end

  def push(data)
    if @data.nil?
      @data = data
    elsif @rest.nil?
      @rest = Deque.new(data)
    else
      rest.push(data)
    end
  end

  def tail
    if @rest.nil?
      @data
    else
      @rest.tail
    end
  end

  def shift
    if @data
      d = @data
      @data = nil
      d
    elsif rest
      rest.shift
    else
      nil
    end
  end

  def unshift(data)
    if @data.nil?
      @data = data
    else
      @rest = Deque.new(@data, @rest)
      @data = data
    end
  end

  def pop
    if @rest.nil?
      d = @data
      @data = nil
      d
    elsif @rest.rest.nil?
      d = tail
      @rest = nil
      d
    else
      @rest.pop
    end
  end
end
