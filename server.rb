require 'sinatra/base'
require './lib/player'
require './lib/game'

class RockPaperScissors < Sinatra::Base
  set :views, './views'
  set :public_dir, './public'
  enable :sessions
  set :session_secret, "something"

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    GAME = Game.new
    erb :index
  end

  get '/new-game' do
  	erb :new_player
  end

  post '/register' do 
    session[:name] = params[:name]
    GAME.add(Player.new(params[:name]))
    GAME.add(Player.new("computer"))
    erb :gameplay
  end

  get '/gameplay' do
    erb :gameplay
  end

  post "/gameplay" do
    GAME.start!
    GAME.players[0].picks = params[:pick]
  	GAME.players[1].picks = generate_computer_pick

    if GAME.winner == GAME.players[1]
      GAME.players[1].score += 1
    elsif GAME.winner == GAME.players[0] 
      GAME.players[0].score += 1
    end
  
  	erb :gameplay
  end

  def generate_computer_pick
  	["Rock","Paper","Scissors"].sample
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
