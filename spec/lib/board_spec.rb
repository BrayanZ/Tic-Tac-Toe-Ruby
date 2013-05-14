require 'board'

describe Board do
  A_MARK = "X"
  A_CELL_POSITION = 3
  A_CELL = "I'm a cell"

  describe 'play at position' do

    context 'on an empty board' do
      it 'plays with a mark on a given position' do
        board = EmptyBoard.new
        board.stub(:cell_at_position).and_return(A_CELL)
        A_CELL.should_receive(:mark_with).with(A_MARK)

        board.make_move(mark: A_MARK, cell:A_CELL_POSITION)
      end
    end

    context 'on an initialized board' do
      it 'plays with a mark on a given position'
      it 'tries to play in a position already played'
    end

  end
end
