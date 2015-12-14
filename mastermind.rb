class MasterMind
  @@colors = {r:"red",b:"blue",g:"green",y:"yellow",p:"purple",w:"white"}
  attr_reader :computer_choice, :user_choice, :position, :turns


#An object will have two instance variables
#*computer's choice
#*user's choice
  def initialize(mode)
    @mode = mode
    @computer_choice = self.computer_selection
    @user_choice = self.user_selection
    @position = 0
    @turns = 12
  end

#Returns an array of *4* randomly picked colors (computer's choice)
  def computer_selection
    computer_colors = []
    4.times { computer_colors << @@colors.keys.sample }
    computer_colors
  end

#Takes user's guess
  def user_selection
    @user_choice = gets.chomp.split("").map(&:to_sym)
  end

#Compares user's input with computer's choice, and returns hints to the user
  def compare
    @turns -= 1
    correct = @user_choice.zip(@computer_choice).map{|pair| pair[0]<=>pair[1]}
    number = 0
    bufer = @computer_choice.dup #so @computer_choice stays unmodified
    @user_choice.each do |color|
      if bufer.include?(color)
        number+=1
        bufer.delete_at(bufer.index(color))
      end
    end
    @position = correct.count(0)
    puts "\n Nubmer of geussed positions is ------ #{@position}"
    puts " Total number of guessed colors is --- #{number}\n"
    puts "\n THE GAME IS ENDED" if end_of_game?
  end

#Takes new input from user and sends it to #.compare method
  def next_guess
    user_selection
    compare
  end

#Checks if the code is guessed or no more moves left
  def end_of_game?
    return (@position == 4 || @turns == 0) ? true : false
  end
end
#===============================================================================
puts "\n   Hello, this is MasterMind, a game where one player has to guess a secret code of four
colors of another player within 12 turns. Each turn you get some feedback about how good
your guess was -- whether it was exactly correct or just the correct colors in the wrong
place."
puts "\nCode elements:
r -> red         b -> blue        g -> green
y -> yellow      p -> purple      w -> white"
puts "For example if the code is 'blue green white blue'"
puts "it must be resembled as  ->  'bgwb'"
puts "\nPlease select if you want to a codebreaker(1) or a codemaker(2)"

gamemode = gets.chomp.to_i
if gamemode == 1
  puts "\nComputer picked a secret code. Make your guess."
  game = MasterMind.new(1)
  game.compare
  until game.end_of_game?
    game.next_guess
  end
  if game.position == 4
    puts "\n CONGRATULATIONS YOU WON!\n"
  elsif game.turns == 0
    puts "\n SORRY, NO MORE MOVES LEFT, YOU LOOSE"
  end

elsif gamemode == 2
  game = MasterMind.new(2)

else
  puts "INCORRECT INPUT! Please enter 1 or 2"
end
