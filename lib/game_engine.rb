require 'sinatra/base'

class GameEngine < Sinatra::Base
  enable :sessions
  set :views, Proc.new { Dir.pwd + '/views' }

  get '/' do
    @game = Game.new({mark: 'X'}, {mark: 'O'})
    session[:game] = @game
    erb :index
  end

  post '/play_cell' do
    game = session[:game]
    game.move params['cell'].to_i
  end
end
