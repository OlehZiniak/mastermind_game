class MasterMind
  #@@colors = %w(red blue green yellow purple white) #stores color options
  @@colors = {r:"red",b:"blue",g:"green",y:"yellow",p:"purple",w:"white"}
  def initialize
  end
end

#operates computer
class ComputerMind < MasterMind
  attr_reader :computer_choice

  #Object will have instance variable -- an array of 4 random colors
  def initialize
    @computer_choice = self.computer_selection
  end

  #Returns an array of *4* randomly picked colors
  def computer_selection
    computer_colors = []
    4.times { computer_colors << @@colors.keys.sample }
    computer_colors
  end
  # #Compares computer's and user's arrays
  # def compare(user_set)
  #   @computer_choice.each do |color|

  #   end
  # end
end

class HumanMind < MasterMind
  attr_accessor :user_choice
  #Object will have instance variable, an array, which will be mutable by user
  def initialize
    @user_choice = gets.chomp.split("").map(&:to_sym)
  end
  #============ не забудь дописати перевырку на кількість і валідність


  def compare(comp_set) #c_set is an obj of CompMind
    # correct_number = 0
    # @user_choice.uniq.each do |color|
    #   if comp_set.computer_choice.include?(color)
    #     correct_number+=1
    #   end
    # end
    comp_choice = comp_set.computer_choice #gets ComputerMind::@computer_choice
    correct_number = comp_choice.length - (comp_choice - @user_choice).length
    correctness = @user_choice.zip(comp_choice).map{|pair| pair[0]<=>pair[1]}
    correct_position = correctness.count(0)
    p correct_position, correct_number
  end
end

p a = ComputerMind.new
p b = HumanMind.new

p b.compare(a)

