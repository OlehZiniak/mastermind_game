class MasterMind
  @@colors = {r:"red",b:"blue",g:"green",y:"yellow",p:"purple",w:"white"}
  attr_reader :computer_choice, :user_choice, :position, :turns


#An object will have two instance variables
#*computer's choice
#*user's choice
  def initialize
    @computer_choice = self.computer_selection
    p @computer_choice
    self.user_selection
    @position = 0
    @turns = 3
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

game = MasterMind.new
game.compare
until game.end_of_game?
  game.next_guess
end

if game.position == 4
  puts "\n CONGRATULATIONS YOU WON!\n"
elsif game.turns == 0
  puts "\n SORRY, NO MORE MOVES LEFT, YOU LOOSE"
end