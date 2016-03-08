class Game
  def initialize(player_choice = 0)
    @choice_hsh = {R:["ROCK", "SCISSORS"], P:["PAPER", "ROCK"], S:["SCISSORS", "PAPER"]}
    @player_wins = {R:0,P:0,S:0}
    @computer_wins = {R:0,P:0,S:0}
    @ties = 0
    @simulation = false
    if player_choice == 0
      @simulation = true
      @player_choice = computer_select
    else
      @player_choice = player_choice.to_sym
    end
  end

  def play
    if @simulation then @player_choice = computer_select end
    computer_select
    output
    if @player_choice == @computer_choice
      @outcome = "It's a Tie!"
      @ties += 1
    elsif @choice_hsh[@player_choice][1] == @choice_hsh[@computer_choice][0]
      @outcome = "PLAYER WINS!"
      @player_wins[@player_choice] += 1
    else
      @outcome = "COMPUTER WINS!"
      @computer_wins[@computer_choice] += 1
    end
    puts @outcome
  end

  def computer_select
    @computer_choice = @choice_hsh.keys.sample
  end

  def output
    puts "Player: #{@choice_hsh[@player_choice][0]} vs Computer: #{@choice_hsh[@computer_choice][0]}"
    puts "-" * 30
  end

  def score
    puts "After 1000 simulations"
    puts "There were #{@ties} ties"
    puts "Player has won #{@player_wins[:R]} times with ROCK"
    puts "Player has won #{@player_wins[:P]} times with PAPER"
    puts "Player has won #{@player_wins[:S]} times with SCISSORS"
    puts "Computer has won #{@computer_wins[:R]} times with ROCK"
    puts "Computer has won #{@computer_wins[:P]} times with PAPER"
    puts "Computer has won #{@computer_wins[:S]} times with SCISSORS"
  end

end

def validate(user_selection, start = false)
  if start == true
    if user_selection.upcase == "S"
      simulation
    elsif user_selection.upcase == "P"
      vs_ai
    end
  elsif user_selection.upcase == "R" || user_selection.upcase == "P" || user_selection.upcase == "S"
    game = Game.new(user_selection.upcase)
    game.play
  elsif user_selection.upcase == "Q"
    puts "Goodbye!"
    exit
  else
    puts "Enter a valid input!"
    vs_ai
  end
end

def vs_ai
  puts "Select (R)ock, (P)aper, (S)cissor or (Q)uit"
  print "> "
  user_selection = validate(gets.chomp)
end

def simulation
  game = Game.new
  1000.times do
    game.play
  end
  game.score
end

def start
  puts "Run (S)imulation or (P)lay vs AI!"
  print "> "
  user_selection = validate(gets.chomp, true)
end
start
