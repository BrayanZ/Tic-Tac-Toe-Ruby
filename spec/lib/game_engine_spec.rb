require 'rack/test'
require 'game_engine'

describe 'game engine' do
  include Rack::Test::Methods

  A_CELL_NUMBER = '5'
  IS_GAME_OVER = true

  def app
    GameEngine.new
  end
  
  def session
    last_request.env['rack.session']
  end

  describe 'start a new game' do
    it 'creates a new game' do
      get('/')
      expect(last_response.body).to match /<h1.*>Tic-Tac-Toe<\/h1>.*(<a.*data-role='cell'.*>.*){9}/m
    end

    it 'saves a new game in session' do
      game = double :game
      Game.stub(:new).and_return(game)

      get('/')
      expect(session['game']).to eq game
    end
  end

  describe 'apply a move' do
    it 'makes a move on the current board' do
      game = double :game
      game.should_receive(:move).with(A_CELL_NUMBER.to_i)
      post('/play_cell', { cell: A_CELL_NUMBER }, 'rack.session' => { 'game' => game })
    end

    it 'returns a json with the new board' do
      game = double(:game, over?: IS_GAME_OVER).as_null_object
      board = stub :board, winner: nil
      game.stub(:board).and_return(board)

      post('/play_cell', { cell: A_CELL_NUMBER }, 'rack.session' => { 'game' => game})
      expect(last_response.body).to eq({ board: board, is_game_over: IS_GAME_OVER, winner: nil }.to_json)
    end
  end
end
