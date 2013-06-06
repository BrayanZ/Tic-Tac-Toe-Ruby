require 'cell'
class Board
  WINNER_MOVES = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
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

  def completed?
    marks = cells.map { |cell| cell.marked? }
    !marks.include? false
  end

  def winner
    WINNER_MOVES.each do |move|
      marks = marks_at(*move).uniq
      return marks[0] if marks.count == 1
    end
  end

  private

  def marks_at *positions
    cells_at_positions = cells.values_at(*positions)
    cells_at_positions.map { |cell| cell.mark }
  end
end
