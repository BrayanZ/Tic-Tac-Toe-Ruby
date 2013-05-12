require 'game'

describe Game do
  describe 'Create a new game' do
    it 'creates a new game with an empty Board' do
      game = described_class.new
      expect( game.board ).to be_instance_of EmptyBoard
    end
  end
end
