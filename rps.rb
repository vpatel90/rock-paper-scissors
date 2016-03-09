require './paint/lib/paint.rb'
require './art.rb'

class Table
  def initialize(arr2d)
    @arr2d = arr2d
    @num_rows = @arr2d.length
    @num_columns = @arr2d[0].length
    @top_bottom_border = ("+" + "-" * 16) * @num_columns + "+"
  end

  def create_table
    puts @top_bottom_border
    puts create_rows
    puts @top_bottom_border

  end

  def create_rows
    @color_arr = [:blue, :red, :green, :yellow]
    @arr2d.each do |row|
      @color = @color_arr.pop
      row.each do |item|
        item = Paint[item, @color]
        item = " " * ((25-item.length)/2) + item
        print "|" +  item.ljust(25," ")
      end
      if row == @arr2d.last
        print "|"
        return
      else
        print "| \n"
      end
    end
  end
end

class Game
  def initialize(player_choice = 0)
    @choice_hsh = { R:["ROCK", "SCISSORS", ROCK_L, ROCK_R],
                    P:["PAPER", "ROCK", PAPER_L, PAPER_R],
                    S:["SCISSORS", "PAPER", SCISSORS_L, SCISSORS_R]}
    @player_wins = {R:0,P:0,S:0}
    @computer_wins = {R:0,P:0,S:0}
    @ties = {R:0,P:0,S:0}
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

    if @player_choice == @computer_choice
      @win_msg = Paint["It's a Tie!", :blue]
      @ties[@player_choice] += 1
    elsif @choice_hsh[@player_choice][1] == @choice_hsh[@computer_choice][0]
      @owin_msg = Paint["PLAYER WINS!", :green]
      @player_wins[@player_choice] += 1
    else
      @win_msg = Paint["COMPUTER WINS!", :red]
      @computer_wins[@computer_choice] += 1
    end
    output
  end

  def computer_select
    @computer_choice = @choice_hsh.keys.sample
  end

  def output
    @player_output = Paint["Player: #{@choice_hsh[@player_choice][0]}", :green]
    @computer_output = Paint["Computer: #{@choice_hsh[@computer_choice][0]}", :red]
    @output = @player_output.ljust(35," ") + " " + @computer_output
    @div = Paint["-" * 60, :blue]
    puts @output
    print_hands
    puts @div
    puts @win_msg
    puts @div
  end

  def print_hands
    @player_hand = @choice_hsh[@player_choice][2]
    @computer_hand = @choice_hsh[@computer_choice][3]
    @player_hand.each_with_index do |hand_part, index|
      hand_part = Paint[hand_part, :green]
      cpu_hand_part = Paint[@computer_hand[index], :red]
      print hand_part.ljust(35," ") +" "+ cpu_hand_part
      puts

    end
  end

  def score
    @score_tracker = [["","Rock", "Paper", "Scissor", "Total"],
                      ["Player Wins", "#{@player_wins[:R]}", "#{@player_wins[:P]}", "#{@player_wins[:S]}", "#{@player_wins.values.reduce(:+)}"],
                      ["CPU Wins", "#{@computer_wins[:R]}", "#{@computer_wins[:P]}", "#{@computer_wins[:S]}", "#{@computer_wins.values.reduce(:+)}"],
                      ["Ties", "#{@ties[:R]}", "#{@ties[:P]}", "#{@ties[:S]}", "#{@ties.values.reduce(:+)}"]]
    score_table = Table.new(@score_tracker)
    score_table.create_table
  end

end

def validate(user_selection, start = false)
  if start == true
    if user_selection.upcase == "S"
      simulation
    elsif user_selection.upcase == "P"
      vs_ai
    elsif user_selection.upcase == "Q"
      puts "Goodbye!"
      exit
    else
      puts "Enter a valid input!"
      start
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
  start
end

def simulation
  game = Game.new
  1000.times do
    game.play
  end
  game.score
  start
end

def start
  puts "Run (S)imulation or (P)lay vs AI! or (Q)uit"
  print "> "
  user_selection = validate(gets.chomp, true)
end
system "clear"
start
