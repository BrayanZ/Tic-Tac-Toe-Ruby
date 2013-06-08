class Game
  attr_reader :board

  def initialize(first_player, second_player)
    @board = Board.new
    @players = [first_player, second_player]
    @current_player_index = 0
  end

  def move position
    update_current_player_index if @board.make_move(current_player_mark, position)
  end

  def current_player
    @players[@current_player_index]
  end

  private

  def current_player_mark
    @players[@current_player_index].mark
  end

  def update_current_player_index
    @current_player_index = (@current_player_index + 1) % 2
  end
end
