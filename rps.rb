class Game
  def initialize(player_choice)
    @player_choice = player_choice.to_sym
    @choice_hsh = {R:["Rock", "Scissors"], P:["Paper", "Rock"], S:["Scissors", "Paper"]}
  end

  def play
    puts "You selected #{@choice_hsh[@player_choice][0]}"
    computer_select
    if @player_choice == @computer_choice
      puts "Its a Tie"
    elsif @choice_hsh[@player_choice][1] == @choice_hsh[@computer_choice][0]
      puts "You Win!"
    else
      puts "You Lose!"
    end
  end

  def computer_select
    @computer_choice = @choice_hsh.keys.sample
    puts "Computer selected #{@choice_hsh[@computer_choice][0]}"
  end
end



puts "Select (R)ock, (P)aper, or (S)cissor!"
print "> "
user_selection = gets.chomp.upcase

game = Game.new(user_selection)

game.play
