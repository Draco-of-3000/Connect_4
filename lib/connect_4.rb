class Players
    attr_accessor :name, :symbol
    def initialize (name, symbol)
        @name = name
        @symbol = symbol
    end
end

class Connect4
    attr_accessor :board, :current_player, :move, :count

    def initialize
        @board = (1..42).to_a.map(&:to_s)
        @current_player = " "
        @move = move
        @count = 0
        @hades = "\u{2620}"
        @hermes = "\u{269A}"
    end

    def get_player_names
        puts "Welcome to Connect 4!"
        print "Player 1, please enter your name: "
        player1_name = gets.chomp
        puts "Are you team Hades or team Hermes #{@player1_name}? Please type Hades or Hermes"
        player1_symbol = gets.chomp.downcase

        until player1_symbol == "hades" || player1_symbol == "hermes"
            puts "Invalid symbol. Please enter 'Hades' or 'Hermes':"
            player1_symbol = gets.chomp.upcase
        end

        player1_symbol = (player1_symbol == 'hades') ? @hades : @hermes


        player_one = Players.new(player1_name, player1_symbol)

        print "Player 2, please enter your name: "
        player2_name = gets.chomp
        player2_symbol = player_one.symbol == @hades ? @hermes : @hades
        player_two = Players.new(player2_name, player2_symbol)
        puts "\n"
        puts "Okay #{player_one.name}, you're up. Make a move."
        display_board
        make_move(player_one, player_two)
    end

    def display_board
        puts seperator
        puts "|   #{@board[0]}   |   #{@board[1]}   |   #{@board[2]}   |   #{@board[3]}   |   #{@board[4]}   |   #{@board[5]}   |   #{@board[6]}   |"
        puts seperator
        puts "|   #{@board[7]}   |   #{@board[8]}   |  #{@board[9]}   |   #{@board[10]}  |   #{@board[11]}    |  #{@board[12]}   |   #{@board[13]}   |"
        puts seperator
        puts "|   #{@board[14]}   |   #{@board[15]}   |   #{@board[16]}  |   #{@board[17]}  |   #{@board[18]}   |   #{@board[19]}   |   #{@board[20]}   |"
        puts seperator
        puts "|   #{@board[21]}   |   #{@board[22]}   |   #{@board[23]}  |   #{@board[24]}  |   #{@board[25]}   |   #{@board[26]}   |   #{@board[27]}   |"
        puts seperator
        puts "|   #{@board[28]}   |   #{@board[29]}   |   #{@board[30]}  |   #{@board[31]}  |   #{@board[32]}   |   #{@board[33]}   |   #{@board[34]}   |"
        puts seperator
        puts "|   #{@board[35]}   |   #{@board[36]}   |   #{@board[37]}  |   #{@board[38]}  |   #{@board[39]}   |   #{@board[40]}   |   #{@board[41]}   |"
        puts seperator
        puts "\n"
    end

    def update_board(move, player_one, player_two)
        if board[move] == player_one.symbol || board[move] == player_two.symbol
            puts "That number is taken, pick another!"
            move = gets.chomp.to_i - 1
        else 
            return
        end
    end

    def seperator
        "-----+-----+-----+-----+-----+-----+------+------+-------"
    end

    def make_move(player_one, player_two)
        while @count < 42
            if (@count == 41) && (!check_winner(player_one) || !check_winner(player_two))
                puts "It's a tie!"
                return
            end
            
            puts "Pick a number from the board #{player_one.name}"
            move = gets.chomp.to_i - 1

            if !valid_move(move)
                puts "Invalid input. Please enter a number between 1 and 42."
                next
            end

            update_board(move, player_one, player_two)
            @board[move] = player_one.symbol
            @count += 1
            display_board
            if check_winner(player_one)
                puts "#{player_one.name} wins!"
                return
            end

            if valid_move(move)
                switch_players(@current_player)
            end 

            puts "Pick a number from the grid above #{player_two.name}"
            move = gets.chomp.to_i - 1

            if !valid_move(move)
                puts "Invalid input. Please enter a number between 1 and 42."
                next
            end

            update_board(move, player_one, player_two)
            @board[move] = player_two.symbol
            @count += 1
            display_board
            if check_winner(player_two)
                puts "#{player_two.name} wins!"
                return
            end
            switch_players(@current_player)

            if (@count == 41) && (!check_winner(player_one) || !check_winner(player_two))
                puts "It's a tie!"
                return
            end
        end
    end

    def valid_move(move)
        move.to_i.between?(0, 41)
    end

    def switch_players(current_player)
        @current_player = @current_player == @hades ? @hermes : @hades
    end

    def check_winner(player)
        winning_combinations = [
            # Rows
            [0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5, 6],
            [7, 8, 9, 10], [8, 9, 10, 11], [9, 10, 11, 12], [10, 11, 12, 13],
            [14, 15, 16, 17], [15, 16, 17, 18], [16, 17, 18, 19], [17, 18, 19, 20],
            [21, 22, 23, 24], [22, 23, 24, 25], [23, 24, 25, 26], [24, 25, 26, 27],
            [28, 29, 30, 31], [29, 30, 31, 32], [30, 31, 32, 33], [31, 32, 33, 34],
            [35, 36, 37, 38], [36, 37, 38, 39], [37, 38, 39, 40], [38, 39, 40, 41],

            # Columns
            [0, 7, 14, 21], [1, 8, 15, 22], [2, 9, 16, 23], [3, 10, 17, 24],
            [4, 11, 18, 25], [5, 12, 19, 26], [6, 13, 20, 27], [7, 14, 21, 28], 
            [8, 15, 22, 29], [9, 16, 23, 30], [10, 17, 24, 31], [11, 18, 25, 32], 
            [12, 19, 26, 33], [13, 20, 27, 34], [14, 21, 28, 35], [15, 22, 29, 36], 
            [16, 23, 30, 37], [17, 24, 31, 38], [18, 25, 32, 39], [19, 26, 33, 40], 
            [20, 27, 34, 41], 


            # Diagonals (bottom-left to top-right)
            [0, 8, 16, 24], [1, 9, 17, 25], [2, 10, 18, 26], [3, 11, 19, 27], 
            [7, 15, 23, 31], [8, 16, 24, 32], [9, 17, 25, 33], [10, 18, 26, 34], [14, 22, 30, 38], [15, 23, 31, 39], [16, 24, 32, 40], 
            [17, 25, 33, 41], 

            # Diagonals (bottom-right to top-left)
            [3, 9, 15, 21], [4, 10, 16, 22], [5, 11, 17, 23], [6, 12, 18, 24], 
            [10, 16, 22, 28], [11, 17, 23, 29], [12, 18, 24, 30], [13, 19, 25, 31],  
            [17, 23, 29, 35], [18, 24, 30, 36], [19, 25, 31, 37], [20, 26, 32, 38]
        ]
        
        winning_combinations.each do |combination|
            if combination.all? { |index| @board[index] == player.symbol }
              return true
            end
        end
        
        false
    end
end
