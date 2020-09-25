require_relative 'colors'

#Initiate Game
 class Game
    attr_accessor :board
    @@colors = {"r" => :red, "g" => :green, "b" => :blue, "w" => :white, "y" => :yellow } 

    def initialize()
        @board = Board.new(10,4)
        play_game()
    end

    def play_game
        welcome()
        set_up()
    end

    protected

    def welcome
        print "------------Welcome to Mastermind-----------\n"
    end

    def set_up
        print "To be a Codemaker, Press 0 \n"
        print "To be a Codebreaker, Press 1 \n"
        input = gets.chomp.to_i

        if input == 0
            print "------------Welcome Codemaker-------------- \n"
            color_options()
        elsif input == 1
            print "------------Welcome Codebreaker------------- \n"
            color_options()
            @board.display_board()
        else
            "Please select 0 or 1"
            set_up()
        end
    end

    def color_options
        print "_____________________________________________\n\n"
        @@colors.each do |(k,v)|
            print "| #{k} = #{Token.new.new_token[:token].send(v)} "
        end
        print "|\n_____________________________________________\n"
        print "Select the correct letter matching a respective color. \n"
        print "Create a combination of 4 colors without spaces or commas. \n"
    end
end

#Initiate a Board class tha will populate board
class Board
    attr_accessor :board

    def initialize(row_number, column_number)
        @board = create_board(row_number, column_number)
    end

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

    def display_board
        board.each do |row|
            print "| "
            row.each do|obj|
                print "#{obj.new_token[:token].send(obj.new_token[:color])} "
            end
            print " |\n"
        end
    end
end

#Create tokens that will populate on the board
class Token
    attr_accessor :new_token
    def initialize(token = "\u25cb", color = :black)
        @new_token = {token: token, color: color}
    end
end

#Create player that will attempt to break code
class Player
    def initialize()
        
    end
end

mastermind = Game.new