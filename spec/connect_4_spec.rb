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
                game.instance_variable_set(:@move, "1")
                game.instance_variable_set(:@board, [
                    "\u{2620}", "2", "3", "4", "5", "6", "7", 
                    "8", "9", "10", "11", "12", "13", "14", 
                    "15", "16", "17", "18", "19", "20", "21", 
                    "22", "23", "24", "25", "26", "27", "28", 
                    "29", "30", "31", "32", "33", "34", "35", 
                    "36", "37", "38", "39", "40", "41", "42"])
                game.update_board(@move, player_one, player_two)
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
    end
end