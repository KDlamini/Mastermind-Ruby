require_relative 'colors'

#Validation module
module Validate
    #Create a method that will validate user input
    def input_valid?(input, colors, columns)
        control = [true] * columns
        test_arr = Array.new
        code = input.split("")
        code.each do |key|
            if colors.has_key?(key)
                test_arr.push(true)
            end
        end

        test_arr == control ? true : false
    end

    #clear screen
    def clear
        print "\e[2J\e[f"
    end
end

#Initiate Game
 class Game
    include Validate
    attr_accessor :board, :rows, :columns
    attr_reader :secret_code
    @@colors = {"r" => :red, "g" => :green, "b" => :blue, "w" => :white, "y" => :yellow }
    

    def initialize()
        @columns = 4
        @rows = 10
        @board = Board.new(@rows, @columns)
        @secret_code = computer_generated_code()
    end

    def play_game
        welcome()
        set_up()
    end

    #Color selection for player to choose combinations
    def color_options
        print "   _______________________________________________\n\n"
        @@colors.each do |(k,v)|
            print "  | #{k} = #{Token.new.new_token[:token] = "\u25cf".send(v)} "
        end
        print "|\n   _______________________________________________\n\n"
        print "Select the correct letter matching a respective color. \n"
        print "Create a combination of #{@columns} colors without spaces/commas. (e.g 'rgbw')\n\n"
    end

    protected

    #Welcome message
    def welcome
        self.clear
        message = "--------------Welcome to Mastermind--------------\n\n".send(:yellow)
        description = "This is a game where you try to guess the secret code.\nThe secret code has five(8) colours represented with r, g, b, w and y.\nYou have 8 tries to guess the code.\nYou can choose from the following colors:\n\nr = red, g = green, b = blue, w = white, y = yellow.\n\n"
        print message.send(:bold)
        print description.send(:red)
    end

    #Layout for choosing to either make code or break code
    def set_up
        print "To be a Codebreaker, Press 1 \n"
        print "To be a Codemaker, Press 0 \n"
        input = gets.strip

        case input 
        when "0"
            sleep 1
            self.clear
            print "----------------Welcome Codemaker---------------- \n\n".send(:green).send(:bold)
            Codemaker.new(@@colors, @columns)
        when "1"
            sleep 1
            self.clear
            print "----------------Welcome Codebreaker-------------- \n".send(:green).send(:bold)
            sleep 1
            color_options()
            @board.display_board()
            Codebreaker.new(@@colors, @secret_code)
        else
            self.clear()
            print "Please select 0 or 1\n"
            set_up()
        end
    end

    #Randomly generate secret code when game is initiated
    def computer_generated_code
        code = ""
        keys = ["r","g","b","w","y"]
        @columns.times { code.concat(keys[rand(5)]) }
        code
    end
end

#Initiate a Board class tha will populate board
class Board
    attr_accessor :new_board

    def initialize(row_number, column_number)
        @new_board = create_board(row_number, column_number)
    end

    #Use provided rows and columns to populate board
    def create_board(row_number, column_number)
        board = Array.new
        row = Array.new
        column_number.times do
            row.push(Token.new)
        end
        row_number.times do
            board.push(row)
        end
        board
    end

    #Display board with default tokens
    def display_board
        @new_board.each do |row|
            print "                 | "
            row.each do|obj|
                print "#{obj.new_token[:token].send(obj.new_token[:color])} "
            end
            print "|\n"
        end
    end
end

#Create token class that will populate tokens on the board
class Token
    attr_accessor :new_token
    def initialize(token = "\u25cb", color = :black)
        @new_token = {token: token, color: color}
    end
end

#Create player that will attempt to break code
class Player
    include Validate
    attr_accessor :board, :player_code
    attr_reader :columns, :colors

    def initialize(colors, board, columns)
        @colors = colors
        @columns = columns
        @board = board
        @player_code = ""
    end

    #Retrieve player combinations and validate
    def user_input
        guesses = Array.new
        begin
            input = gets.chomp
            raise if !(self.input_valid?(input, @colors, @columns))
        rescue StandardError
            print "Please enter the correct combination of #{@columns} letters:\n"
            retry
        end
        
        @player_code = input
        code = input.split('')
        
        code.each do |key|
            guesses.push(Token.new("\u25cf", @colors[input[key]]))
        end
        guesses
    end
end

#Initiate class that will handle guesses fron player
class Codebreaker
    include Validate

    def initialize(colors, secret_code)
        @initiate_game = Game.new
        @colors = colors
        @columns = @initiate_game.columns
        @rows = @initiate_game.rows
        @board = @initiate_game.board
        @secret_code = secret_code
        initiate_code_breaker()
    end

    def initiate_code_breaker
        player = Player.new(@colors, @board, @columns)
        i = 0

        @rows.times do
            #puts @secret_code
            print "\n---------------------------------------------------\n".send(:yellow).send(:bold)
            user_input = player.user_input()
            print "---------------------------------------------------\n".send(:yellow).send(:bold)
            print "                 ...Initializing...".send(:red).send(:bold)
            sleep 1
            self.clear
            player_code = player.player_code
            arrow = [Token.new("\u276D", :white)]

            if player_code == @secret_code
                @board.new_board[i] = user_input + arrow + flags(player_code, @secret_code)
                Game.new.color_options()
                @board.display_board()
                print "\n      ------------Congratulations!!!-----------".send(:green).send(:bold)
                print "\n      You have succesfully broke the code! wow!\n"
                break
            end
            
            @board.new_board[i] = user_input + arrow + flags(player_code, @secret_code)
            Game.new.color_options()
            @board.display_board()

            i += 1
        end

        if player.player_code != @secret_code
            print "\n         You have failed to break the code!"
            print "\n         ------------Game Over!!!----------\n".send(:yellow).send(:bold) 
        end
    end

    protected

    #Create flags that will give hints about secret code combination
    def flags(player_code, secret_code)
        guess = player_code.slice(0..player_code.size)
        computer_code = secret_code.slice(0..secret_code.size)
        looper = computer_code.size
        flags = Array.new
        i = 0; j = 0

        looper.times do
            if computer_code[i] == guess[i]
                flags.push(Token.new("\u2691", :red))
                guess[i] = "O"; computer_code[i] = "X"
            end
            i += 1
         end
         
        looper.times do
            if computer_code.include?(guess[j])
                flags.push(Token.new("\u2691", :white))
                computer_code[computer_code.index(guess[j])] = "X"  
            end
            j += 1
        end
        flags
    end
end

class Codemaker
    include Validate
    def initialize(colors, columns)
        @colors = colors
        @columns = Game.new.columns
        @secret_code = ""
        set_up()
    end

    def set_up
        print "To play against another player, Press 0 \n"
        print "To play against computer AI, Press 1 \n"
        input = gets.strip

        case input
            when "0"
                sleep 1
                self.clear
                print "----------------Create Secret Code--------------- \n".send(:blue).send(:bold)
                sleep 1
                initiate_game = Game.new
                initiate_game.color_options()
                secret_code()
                initiate_game.color_options()
                initiate_game.board.display_board()
                Codebreaker.new(@colors, @secret_code)
            when "1"
                sleep 1
                self.clear
                print "----------------Create Secret Code--------------- \n".send(:blue).send(:bold)
                sleep 1
                initiate_game = Game.new
                initiate_game.color_options()
                secret_code()
                print "\n\n\n\n          ...AI currently in development...\n\n".send(:red).send(:bold)
                #AIcodebreaker.new
            else
                self.clear()
                "Please select 0 or 1"
                set_up()
        end
    end

    def secret_code
        begin
            code = gets.chomp
            raise if !(self.input_valid?(code, @colors, @columns))
        rescue StandardError
            print "Please enter the correct combination of #{@columns} letters:\n"
            retry
        end
        
        print "                 ...Initiating...".send(:red).send(:bold)
        sleep 1
        @secret_code = code
        print "\n------------Secret Code Initiatlized-------------- \n\n".send(:green)
        sleep 1
        self.clear
        print "                    ...PLAY...\n\n".send(:yellow).send(:bold)
        sleep 1
    end
end

mastermind = Game.new
mastermind.play_game()