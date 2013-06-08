require 'sinatra/base'

class GameEngine < Sinatra::Base
  set :views, Proc.new { Dir.pwd + '/views' }

  get '/' do
    @game = Game.new 'X', 'O'
    erb :index
  end
end
