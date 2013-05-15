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

  describe 'play at position' do
    let(:a_cell) {stub :cell, marked?: false}

    context 'on an empty board' do
      let(:board) { Board.new }

      it 'has 9 empty cells' do
        expect(board.cells).to have_only EmptyCell
      end

      it 'plays with a mark on a given position' do
        board.stub(:cell_at_position).and_return(a_cell)
        a_cell.should_receive(:mark_with).with(A_MARK)

        board.make_move(mark: A_MARK, cell:A_CELL_POSITION)
      end
    end

    context 'on an initialized board' do
      let(:a_cell) { stub :cell, marked?: false }
      let(:a_marked_cell) { stub :cell, marked?: true }

      it 'tries to play in a position already played' do
        board = Board.new
        board.stub(:cell_at_position).with(A_CELL_POSITION).and_return(a_marked_cell)
        expect(board.make_move(mark: A_MARK, cell: A_CELL_POSITION)).to be_nil
      end

      it 'plays with a mark on a given position' do
        board = Board.new

        board.stub(:cell_at_position).with(A_CELL_POSITION).and_return(a_cell)
        a_cell.should_receive(:mark_with).with(A_MARK)
        board.make_move(mark: A_MARK, cell:A_CELL_POSITION)
      end

    end
  end

  describe 'get the cell at position' do
    A_CELL = "I'm a cell"
    ANOTHER_CELL = "I'm another cell"
    CELLS = [A_CELL, A_CELL, ANOTHER_CELL, A_CELL, A_CELL, A_CELL, A_CELL, A_CELL, A_CELL]

    it 'gets the cell for the given position' do
      board = Board.new
      board.stub(:cells).and_return(CELLS)
      expect(board.cell_at_position(A_CELL_POSITION)).to be ANOTHER_CELL
    end
  end
end
