class Players
    attr_accessor :name, :symbol
    def initialize (name, symbol)
        @name = name
        @symbol = symbol
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
end