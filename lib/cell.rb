class Cell
  def initialize(mark)
    @mark = mark
  end

  def mark_with(_); end

  def mark
    @mark
  end

  def marked?
    raise NotImplementedError
  end
end

class EmptyCell < Cell
  def initialize
    @mark = nil
  end

  def mark_with(mark)
    Cell.new(mark)
  end
end

