require 'game'

describe Game do
  describe 'Create a new game' do
    it 'creates a new game with an empty Board' do
      game = described_class.new
      expect( game.board ).to be_instance_of Board
    end
  end

  describe 'next_turn' do
    it 'change the player turn when the first one make a move'
    it 'dont change the player turn when the first one makes an invalid move'
  end
end
