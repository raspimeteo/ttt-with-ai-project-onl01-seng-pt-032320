class Game

    attr_accessor :board, :player_1, :player_2, :token

    WIN_COMBINATIONS = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [6, 4, 2]
    ]

    def initialize(player_1 = Players::Human.new('X'), player_2 = Players::Human.new('O'), board = Board.new)
        @board = board
        @player_1 = player_1
        @player_2 = player_2
    end

    def current_player
        @board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def won?
        WIN_COMBINATIONS.detect do |win_combo|
            @board.cells[win_combo[0]] == @board .cells[win_combo[1]] && 
            @board.cells[win_combo[1]] == @board.cells[win_combo[2]] &&
            (@board.cells[win_combo[0]] == 'X' || @board.cells[win_combo[0]] == 'O')
        end
    end

    def draw?
        @board.full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        if won?
            @board.cells[won?.first]
        end
    end

    def turn
        player = current_player
        puts
        puts "Player #{player.token}, what will be your move? ( 1 - 9 )"
        move = player.move(@board)
        if !@board.valid_move?(move)
            turn
        else
            @board.update(move, player)
        end
    end

    def play
        while !over?
            @board.display
            turn
        end
        if won?
            @board.display
            puts
            puts "Congratulations #{winner}!"
        elsif draw?
        @board.display
            puts "Cat's Game!"
        end


    end


end