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
    game = session[:game]
    game.move params['cell'].to_i
    game.board.to_json
  end
end
