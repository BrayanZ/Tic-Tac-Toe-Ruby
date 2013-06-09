require 'sinatra/base'
require 'json'

class GameEngine < Sinatra::Base
  enable :sessions
  set :views, Proc.new { Dir.pwd + '/views' }
  set :public_folder, Dir.pwd + "/assets/"

  get '/' do
    Player = Struct.new(:mark)
    @game = Game.new(Player.new('X'), Player.new('O'))
    session[:game] = @game
    erb :index
  end

  post '/play_cell' do
    result = play_on_position(session[:game], params['cell'].to_i)
    result.to_json
  end

  private

  def play_on_position(game, position)
    game.move(position)
    { board: game.board, is_game_over: game.over?,  winner: game.board.winner }

  end
end
