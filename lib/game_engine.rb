require 'sinatra/base'

class GameEngine < Sinatra::Base
  enable :sessions
  set :views, Proc.new { Dir.pwd + '/views' }

  get '/' do
    @game = Game.new 'X', 'O'
    session[:game] = @game
    erb :index
  end
end
