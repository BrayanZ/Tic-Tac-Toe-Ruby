require 'board'

RSpec::Matchers.define :have_only do |expected|
  match do |actual|
    classes_array = actual.map(&:class).uniq
    classes_array.size == 1 and classes_array[0] == expected
  end
end

describe Board do
  A_MARK = "X"
  A_CELL_POSITION = 2
  let(:board) { Board.new }

  describe 'play at position' do
    let(:a_cell) {stub :cell }
    let(:a_marked_cell) { stub :cell, mark_with: nil }

    it 'has 9 empty cells' do
      expect(board.cells).to have_only EmptyCell
    end

    it 'plays with a mark on a given position' do
      board.stub(:cell_at_position).and_return(a_cell)
      a_cell.should_receive(:mark_with).with(A_MARK)

      board.make_move(A_MARK, A_CELL_POSITION)
    end

    it 'tries to play in a position already played' do
      board.stub(:cell_at_position).with(A_CELL_POSITION).and_return(a_marked_cell)
      expect(board.make_move(A_MARK, A_CELL_POSITION)).to be_nil
    end
  end

  describe 'get the cell at position' do
    A_CELL = "I'm a cell"
    ANOTHER_CELL = "I'm another cell"
    CELLS = [A_CELL, A_CELL, ANOTHER_CELL, A_CELL, A_CELL, A_CELL, A_CELL, A_CELL, A_CELL]

    it 'gets the cell for the given position' do
      board.stub(:cells).and_return(CELLS)
      expect(board.cell_at_position(A_CELL_POSITION)).to be ANOTHER_CELL
    end
  end

  describe 'Game completed' do
    let(:cell) { stub :cell, marked?: true}
    let(:game_over) { [cell] * 9 }

    it 'verifies if the game is completed, when all the cells are marked' do
      board.stub(:cells).and_return(game_over)
      expect(board).to be_completed
    end
  end
end
