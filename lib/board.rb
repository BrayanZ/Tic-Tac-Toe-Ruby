require 'cell'
class Board
  def initialize
    @cells = [EmptyCell.new] * 9
  end

  def cells
    @cells
  end
  def cell_at_position position
    cells[position]
  end

  def make_move(mark: '' , cell:'' )
    cell = cell_at_position(cell)
    cell.mark_with(mark) unless cell.marked?
  end
end
