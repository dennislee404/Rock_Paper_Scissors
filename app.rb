#https://sinatrarb.com/

require 'sinatra'

get '/' do 
  erb :index
end

post '/start' do 
  @player_name = params[:name]
  @turns = params[:turns].to_i
  @round  = 1
  @win = 0
  @draw = 0
  @lose = 0

  erb :start
end

post '/result' do 

  @player_name = params[:name]
  @turns = params[:turns].to_i
  @round = params[:round].to_i
  @win = params[:win].to_i
  @draw = params[:draw].to_i
  @lose = params[:lose].to_i

  @player_choice = params[:choice]
  @computer_choice = ["rock","paper","scissors"].sample

  if @player_choice == @computer_choice
    @draw += 1
  else
    if @player_choice == "rock"
      if @computer_choice == "scissors"
        @win += 1
      else
        @lose += 1
      end
    elsif @player_choice == "paper"
      if @computer_choice == "rock"
        @win += 1
      else
        @lose += 1
      end
    elsif @player_choice == "scissors"
      if @computer_choice == "paper"
        @win += 1
      else
        @lose += 1
      end
    end
  end

  if @win == @lose
    @outcome = "Its a TIE!!!"
  elsif @win > @lose
    @outcome = "You WIN!!!"
  elsif @lose > @win
    @outcome = "You LOSE!!!"
  end

  if @turns > 0
    erb :start
  else
    erb :result
  end
end
