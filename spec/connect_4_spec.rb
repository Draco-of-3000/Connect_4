require './lib/connect_4'

describe Connect4 do
    let(:player_one) { Players.new("Player1", "\u{2620}") }
    let(:player_two) { Players.new("Player2", "\u{269A}") }
    subject(:game) { described_class.new }

    before do
        allow(game).to receive(:gets).and_return("Player1", "\u{2620}", "Player2", "\u{269A}")
    end

    context "when a new game starts" do
        it "initializes with a 7x6 grid and a current player" do
            expect(game.board).to eq([
                "1", "2", "3", "4", "5", "6", "7", 
                "8", "9", "10", "11", "12", "13", "14", 
                "15", "16", "17", "18", "19", "20", "21", 
                "22", "23", "24", "25", "26", "27", "28", 
                "29", "30", "31", "32", "33", "34", "35", 
                "36", "37", "38", "39", "40", "41", "42"]
            )
            expect(game.current_player).to eq(' ')
        end
    end

    describe '#valid_move' do
        context 'if a move is an integer in range' do
            it 'returns true' do
                game.instance_variable_set(:@move, "5")
                expect(game.valid_move).to be(true)
            end
        end

        context 'if a move is an integer out of range' do
            it 'returns false' do
                game.instance_variable_set(:@move, "43")
                expect(game.valid_move).to be(false)
            end
        end

        context 'if a move is a non-numeric value' do
            it 'returns false' do
                game.instance_variable_set(:@move, "a")
                expect(game.valid_move).to be(false)
            end
        end
    end

    describe '#update_board' do
        context 'when a move is taken' do
            before do
                game.instance_variable_set(:@board, [
                    "\u{2620}", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "18", "19", "20", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"])
                game.update_board(1 , player_one, player_two)
            end

            it 'does not update the board when the move is taken' do
                updated_board = game.instance_variable_get(:@board)
                expect(updated_board).to eq([
                    "\u{2620}", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "18", "19", "20", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"]
                )
            end
        end

        context 'when a move is not taken' do
            before do
                game.instance_variable_set(:@board, [
                    "\u{2620}", "\u{269A}", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "18", "19", "20", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"])
                game.update_board(1 , player_one, player_two)
            end

            it 'updates the board correctly' do
                updated_board = game.instance_variable_get(:@board)
                expect(updated_board).to eq([
                    "\u{2620}", "\u{269A}", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "18", "19", "20", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"]
                )
                game.update_board(2 , player_one, player_two)
            end
        end
    end

    describe '#switch_players' do
        subject { game.instance_variable_get(:@current_player) }

        context 'when current player is hades' do
            before { game.instance_variable_set(:@current_player, "\u{2620}") }

            it 'changes current player from hades to hermes' do
                expect(game.switch_players(@current_player)).to eq("\u{269A}")
            end
        end

        context 'when current player is hermes' do
            before { game.instance_variable_set(:@current_player, "\u{269A}") }

            it 'changes current player from hermes to hades' do
                expect(game.switch_players(@current_player)).to eq("\u{2620}")
            end
        end
    end

    describe '#check_winner' do
        context 'when player1 wins horizontally' do
            it 'returns true' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "\u{2620}", "\u{2620}", "\u{2620}", "\u{2620}", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"]
                )
                expect(game.check_winner(player_one)).to be(true)
            end
        end

        context 'when player2 wins horizontally' do
            it 'returns true' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "\u{269A}", "\u{269A}", "\u{269A}", "\u{269A}", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"]
                )
                expect(game.check_winner(player_two)).to be(true)
            end
        end

        context 'when player1 wins vertically' do
            it 'returns true' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "\u{2620}", "18", "19", "20", "21", 
                    "22", "23", "\u{2620}", "25", "26", "27", "28", 
                    "29", "30", "\u{2620}", "32", "33", "34", "35", 
                    "36", "37", "\u{2620}", "39", "40", "41", "42"]
                )
                expect(game.check_winner(player_one)).to be(true)
            end
        end

        context 'when player2 wins vertically' do
            it 'returns true' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "\u{269A}", "18", "19", "20", "21", 
                    "22", "23", "\u{269A}", "25", "26", "27", "28", 
                    "29", "30", "\u{269A}", "32", "33", "34", "35", 
                    "36", "37", "\u{269A}", "39", "40", "41", "42"]
                )
                expect(game.check_winner(player_two)).to be(true)
            end
            
        end

        context 'when player1 wins diagonally' do
            it 'returns true' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "\u{2620}", "19", "20", "21", 
                    "22", "23", "24", "25", "\u{2620}", "27", "28", 
                    "29", "30", "31", "32", "33", "\u{2620}", "35", 
                    "36", "37", "38", "39", "40", "41", "\u{2620}"]
                )
                expect(game.check_winner(player_one)).to be(true)
            end
        end

        context 'when player2 wins diagonally' do
            it 'returns true' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "\u{269A}", "19", "20", "21", 
                    "22", "23", "24", "25", "\u{269A}", "27", "28", 
                    "29", "30", "31", "32", "33", "\u{269A}", "35", 
                    "36", "37", "38", "39", "40", "41", "\u{269A}"]
                )
                expect(game.check_winner(player_two)).to be(true)
            end
        end
    end

    describe '#make_move' do 
        context 'when game ends in a tie' do
            before do
                game.instance_variable_set(:@count, 42)
                game.instance_variable_set(:@board, [
                    "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}",
                    "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}",
                    "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}",
                    "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}",
                    "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}",
                    "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}", "\u{2620}", "\u{269A}"
                  ]
                )
            end
            
            it 'displays "It\'s a tie"' do
                expect { game.make_move(player_one, player_two) }.to output("It's a tie!\n").to_stdout
            end
        end

        context 'when an out of bounds move is made' do
            it 'returns false' do
                game.instance_variable_set(:@board, [
                    "1", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "18", "19", "20", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"]
                )

                move = 43
                result = game.valid_move(move)
                expect(result).to be(false)
            end
        end
    end
end