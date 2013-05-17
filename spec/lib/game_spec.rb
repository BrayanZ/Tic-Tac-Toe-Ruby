require 'game'

describe Game do
  A_MARK = :X
  ANOTHER_MARK = :O
  A_POSITION = 2
  ANOTHER_POSITION = 4

  let(:first_player) { double :player, mark: A_MARK }
  let(:second_player) { double :player, mark: ANOTHER_MARK }
  let(:game) { described_class.new(first_player, second_player) }

  describe 'Create a new game' do
    it 'creates a new game with an empty Board' do
      expect( game.board ).to be_instance_of Board
    end
  end

  describe 'changes next player turn when moves' do
    it 'starts with the first plater' do
      expect(game.next_player.mark).to be A_MARK
    end

    it 'change the player turn when the first one make a move' do
      game.move A_POSITION
      expect(game.next_player.mark).to be ANOTHER_MARK
    end

    it 'dont change the player turn when the first one makes an invalid move' do
      game.move A_POSITION
      game.move A_POSITION

      expect(game.next_player.mark).to be ANOTHER_MARK
    end

    it 'rotates correctly the next player' do
      game.move A_POSITION
      game.move ANOTHER_POSITION

      expect(game.next_player.mark).to be A_MARK
    end
  end
end
