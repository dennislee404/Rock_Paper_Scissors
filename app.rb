#https://sinatrarb.com/

require 'sinatra'
enable :sessions

# get '/test' do 
#   erb :test
# end

# get '/' do 
#   session[:leaderboard] = []
#   erb :main
# end

get '/' do 
  if session[:leaderboard] == nil
    session[:leaderboard] = []
  else
    session[:leaderboard] = session[:leaderboard]
  end

  erb :index
end

post '/start' do 
  session[:player_name] = params[:name]
  session[:rounds] = params[:rounds].to_i
  session[:results] = []

  erb :start
end

post '/result' do 
  @player_choice = params[:choice]
  @computer_choice = ["rock","paper","scissors"].sample

  result = check_game(@player_choice,@computer_choice)
  session[:results] << result

  # puts "========"
  # puts @player_choice
  # puts @computer_choice
  # puts session[:results]

  if session[:results].length < session[:rounds]
    erb :start

  else
    @win = session[:results].count("Win!")
    @draw = session[:results].count("Tie!")
    @lose = session[:results].count("Lose!")

    @scoreboard = {
      "player_name" => session[:player_name],
      "win_count" => @win
       }

    session[:leaderboard] << @scoreboard
    erb :result
  end
  
end

def check_game(player,computer)
  if player == computer
    return "Tie!"
  elsif player == "rock" && computer == "scissors" or 
        player == "paper" && computer == "rock" or 
        player == "scissors" && computer == "paper"
    return "Win!"
  else
    return "Lose!"
  end
end