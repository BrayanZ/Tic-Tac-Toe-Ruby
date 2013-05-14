class Board; end

class EmptyBoard
  def cell_at_position position
    raise NotImplementedError
  end

  def make_move(mark: '' , cell:'' )
    cell_at_position(cell).mark_with(mark)
  end
end
