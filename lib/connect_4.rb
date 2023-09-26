class Players
    attr_accessor :name, :symbol, :move
    def initialize (name, symbol)
        @name = name
        @symbol = symbol
        @move = move
    end
end

class Connect4
    attr_accessor :board, :current_player

    def initialize
        @board = (1..42).to_a.map(&:to_s)
        @current_player = " "
    end

    def get_player_names
        puts "Welcome to Connect 4!"
        print "Player 1, please enter your name: "
        player1_name = gets.chomp
        puts "Are you team Hades or team Hermes #{@player1_name}? Please type Hades or Hermes"
        player1_symbol = gets.chomp.upcase

        until player1_symbol == "hades" || symbol1 == "hermes"
            puts "Invalid symbol. Please enter 'Hades' or 'Hermes':"
            player1_symbol = gets.chomp.upcase
        end

        player_one = Players.new(@player1_name, player1_symbol)

        print "Player 2, please enter your name: "
        player2_name = gets.chomp
        player2_symbol = player_one.symbol == "hades" ? "hermes" : "hades"
        player_two = Players.new(@player2_name, player2_symbol)
        puts "\n"
        puts "Okay #{player_one.name}, you're up. Make a move."
        display_board
        make_move(player_one, player_two)
    end

    def display_board
        puts seperator
        puts "|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |  #{@board[6]} |"
        puts seperator
        puts "|  #{@board[7]}  |  #{@board[8]}  | #{@board[9]}  | #{@board[10]}  | #{@board[11]}  | #{@board[12]}  | #{@board[13]} |"
        puts seperator
        puts "| #{@board[14]}  | #{@board[15]}  | #{@board[16]}  | #{@board[17]}  | #{@board[18]}  | #{@board[19]}  | #{@board[20]} |"
        puts seperator
        puts "| #{@board[21]}  | #{@board[22]}  | #{@board[23]}  | #{@board[24]}  | #{@board[25]}  | #{@board[26]}  | #{@board[27]} |"
        puts seperator
        puts "| #{@board[28]}  | #{@board[29]}  | #{@board[30]}  | #{@board[31]}  | #{@board[32]}  | #{@board[33]}  | #{@board[34]} |"
        puts seperator
        puts "| #{@board[35]}  | #{@board[36]}  | #{@board[37]}  | #{@board[38]}  | #{@board[39]}  | #{@board[40]}  | #{@board[41]} |"
        puts seperator
        puts "\n"
    end

    def seperator
        "-----+-----+-----+-----+-----+-----+------"
    end

    def valid_move
        @move.to_i.between?(1, 42)
    end
end

game = Connect4.new
game.display_board