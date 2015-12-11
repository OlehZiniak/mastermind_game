class MasterMind
  @@colors = {r:"red",b:"blue",g:"green",y:"yellow",p:"purple",w:"white"}
  attr_reader :computer_choice, :user_choice

#An object will have two instance variables
#*computer's choice
#*user's choice
  def initialize
    @computer_choice = self.computer_selection
    p @computer_choice
    self.user_selection
    p @user_choice
  end

#Returns an array of *4* randomly picked colors (computer's choice)
  def computer_selection
    #@@colors.keys.shuffle.take(4) not useful. Takes only uniq values
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
    number = @computer_choice.length - (@computer_choice - @user_choice).length
    correct = @user_choice.zip(@computer_choice).map{|pair| pair[0]<=>pair[1]}
    position = correct.count(0)
    p position, number
  end

  def next_guess
    11.times do
      user_choice
      compare()
    end
  end
end

a = MasterMind.new
a.compare