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

  def make_move(mark, position)
    cell = cell_at_position(position).mark_with(mark)
    @cells[position] = cell unless cell.nil?
    cell
  end

  def over?
    marks = cells.map { |cell| cell.marked? }
    !marks.include? false
  end
end
