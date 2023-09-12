#https://sinatrarb.com/

require 'sinatra'

get '/' do 
  erb :index
end

post '/start' do 
  @player_name = params[:name]
  @turns = params[:turns].to_i

  erb :start
end

post '/result' do 
  @player_name = params[:name]
  @turns = params[:turns].to_i

  @player_choice = params[:choice]
  @computer_choice = ["rock","paper","scissors"].sample

  if @player_choice == @computer_choice
    @outcome = "It's a TIE!!!"
  else
    if @player_choice == "rock"
      if @computer_choice == "scissors"
        @outcome = "You WIN!!!"
      else
        @outcome = "You LOSE!!!"
      end
    elsif @player_choice == "paper"
      if @computer_choice == "rock"
        @outcome = "You WIN!!!"
      else
        @outcome = "You LOSE!!!"
      end
    elsif @player_choice == "scissors"
      if @computer_choice == "paper"
        @outcome = "You WIN!!!"
      else
        @outcome = "You LOSE!!!"
      end
    end
  end

  erb :result
end
