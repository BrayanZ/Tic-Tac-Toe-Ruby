require 'board'

RSpec::Matchers.define :have_only do |expected|
  match do |actual|
    classes_array = actual.map(&:class).uniq
    classes_array.size == 1 and classes_array[0] == expected
  end
end

describe Board do
  A_MARK = "X"
  ANOTHER_MARK = "O"
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

  describe 'return the winner of the board' do
    let(:cell_marked_1) { stub :cell, mark: A_MARK}
    let(:cell_marked_2) { stub :cell, mark: ANOTHER_MARK}
    let(:winner_horizontal_1) { [cell_marked_1, cell_marked_1, cell_marked_1,
                                 cell_marked_2, cell_marked_1, cell_marked_2,
                                 cell_marked_2, cell_marked_2, cell_marked_2] }
    let(:winner_vertical_1) { [cell_marked_1, cell_marked_1, cell_marked_1,
                               cell_marked_2, cell_marked_1, cell_marked_2,
                               cell_marked_2, cell_marked_1, cell_marked_2] }

    let(:winner_diagonal_1) { [cell_marked_2, cell_marked_1, cell_marked_1,
                               cell_marked_1, cell_marked_2, cell_marked_2,
                               cell_marked_2, cell_marked_1, cell_marked_2] }

    it 'finds the winner of the board in horizontal' do
      board.stub(:cells).and_return(winner_horizontal_1)
      expect(board.winner).to be A_MARK
    end

    it 'finds the winner of the board in vertical' do
      board.stub(:cells).and_return(winner_vertical_1)
      expect(board.winner).to be A_MARK
    end

    it 'finds the winner of the board in diagonal' do
      board.stub(:cells).and_return(winner_diagonal_1)
      expect(board.winner).to be ANOTHER_MARK
    end
  end
end
