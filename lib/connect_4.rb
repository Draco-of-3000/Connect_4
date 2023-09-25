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
end