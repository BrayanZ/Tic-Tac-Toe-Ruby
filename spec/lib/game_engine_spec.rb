require 'rack/test'
require 'game_engine'

describe 'game engine' do
  include Rack::Test::Methods

  def app
    GameEngine.new
  end

  describe 'start a new game' do
    it 'creates a new game' do
      get('/')
      expect(last_response.body).to match /<h1.*>Tic-Tac-Toe<\/h1>.*(<a.*data-role='cell'.*>.*){9}/m
    end
  end

  describe 'apply a move' do
    it 'makes a move on the current board'
  end
end
