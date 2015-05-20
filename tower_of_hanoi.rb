class TowerOfHanoi

    def initialize(number_of_discs = 3)
      @number_of_discs = number_of_discs
      @rods = [Array.new, Array.new, Array.new]
      @move_count = 0

      puts "Welcome to Tower of Hanoi!  Type 'play' to start!"

    end


    def play
      #build starting board
      @number_of_discs.downto(1) do |disc_number|
        @rods[0] << disc_number
      end

      prompt_move
    end


     #prompt for next move
    def prompt_move
      render
      puts "Move ##{@move_count+1}: enter where you'd like to move from and to in the format: 1,3. Enter 'q' to quit."
      @user_input = gets.chomp
      puts "You entered: #{@user_input}."
      test_input
    end


    #show board
    def render
      #puts @rods

      #flip into rows

      (@number_of_discs-1).downto(0) do |row|
        #print row
        @rods.each do |column|
          if column.empty? || column[row].nil?
            print " "
          else
            print column[row]
          end
        end
        print "\n"
      end
      print "123\n"

    end


    def test_input
      if @user_input == "q"
        puts "You quit after #{@move_count} moves.  Thanks for playing!"
        exit
      end

      @user_from = @user_input[0].to_i
      @user_to = @user_input[2].to_i

      #if valid, send move
      # fail conditions: from/to rod not between 1 and 3; from value not bigger than min value of to array
      if @user_from.between?(1,3) && @user_to.between?(1,3) && not(@rods[@user_from-1].empty?) && ( @rods[@user_to-1].empty? || @rods[@user_from-1].min < @rods[@user_to-1].min )
        @user_move = [@user_from,@user_to]
        make_move
      else
        puts "\033[31mMove appears invalid.  Please try again.\033[0m" #\033[*m changes the color to/from red!
        prompt_move
      end
    end


    #when move received
    def make_move
      #add 1 to move count
      @move_count += 1
      #move top disc accordingly
      @rods[@user_move[1]-1] << @rods[@user_move[0]-1].pop
      win_test
      prompt_move
    end


    #test for victory conditions
    def win_test
      win if @rods[0].empty? && ( @rods[1].empty? || @rods[2].empty? )
    end


    def win
      render
      puts "Congratulations!  You won in #{@move_count} moves!"
      exit
    end

end