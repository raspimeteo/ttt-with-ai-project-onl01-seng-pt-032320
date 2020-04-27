module Players

    attr_accessor :board

    class Computer < Player

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

        CORNERS = [0, 8, 2, 6]



        def move(board)
            @board = board
            # winning move?
            # a. iterate over winning combos and see if any of them have 2 cells that equal current_player.token and one valid_move?
            # b. winning move
            # block?
            # a. iterate over winning combos and see if any of them have 2 cells that equal other_player.token and one valid_move?
            # b. blocking move
            # center?
            # a. check if board.cells[4] is a valid move
            # b. take center
            # corners?
            # a. iterate over the corners and see if any of them == other_player.token
            # b. if yes take the opposite corner
            # c. if no iterate over the corners and see if any of them == current_player.token
            # d. if yes take the opposite corner
            # e. if no take any corner
            # random
            # a. make random move
            if winning_move? != nil
                input = winning_move? + 1
                # puts "winning_move = #{input}",""
            elsif block? != nil
                input = block? + 1
                # puts "blocking move = #{input}",""
            elsif corners? != nil
                input = corners? + 1
                # puts "corner move = #{input}",""
            elsif center? != nil
                input = 5
                # puts "center move = #{input}",""
            else
                until !@board.taken?(input)
                    input = (1..9).to_a.sample
                    # puts "random move = #{input}",""
                end
            end
            
            sleep(1)
            input.to_s
            
        end  
        
        def winning_move?
            winning_line = WIN_COMBINATIONS.detect do |win_combo|
                (@board.cells[win_combo[0]] == token && @board.cells[win_combo[1]] == token && @board.cells[win_combo[2]] == ' ' ||
                @board.cells[win_combo[0]] == token && @board.cells[win_combo[2]] == token && @board.cells[win_combo[1]] == ' ' ||
                @board.cells[win_combo[1]] == token && @board.cells[win_combo[2]] == token && @board.cells[win_combo[0]] == ' ')
            end
            if winning_line
                winning_cell = winning_line.detect {|cell| @board.cells[cell] == ' '}
            end
            winning_cell
        end

        def block?
            token == 'X' ? test_token = 'O' : test_token = 'X'
            blocking_line = WIN_COMBINATIONS.detect do |block_combo|
                # binding.pry
                (@board.cells[block_combo[0]] == test_token && @board.cells[block_combo[1]] == test_token && @board.cells[block_combo[2]] == ' ' ||
                @board.cells[block_combo[0]] == test_token && @board.cells[block_combo[2]] == test_token && @board.cells[block_combo[1]] == ' ' ||
                @board.cells[block_combo[1]] == test_token && @board.cells[block_combo[2]] == test_token && @board.cells[block_combo[0]] == ' ')
            end
            if blocking_line
                blocking_cell = blocking_line.detect {|cell| @board.cells[cell] == ' '}
            end
            blocking_cell
        end

        def corners?
            token == 'X' ? test_token = 'O' : test_token = 'X'
            corner_taken_by_opponent = CORNERS.detect do |corner|
                @board.cells[corner] == test_token
            end
            case
                when corner_taken_by_opponent == 0 && !@board.taken?(9)
                move = 8
                when corner_taken_by_opponent == 8 && !@board.taken?(1)
                move = 0
                when corner_taken_by_opponent == 2 && !@board.taken?(7)
                move = 6
                when corner_taken_by_opponent == 6 && !@board.taken?(3)
                move = 2
                else
                    move = CORNERS.shuffle.find {|corner| @board.cells[corner] == " "}
            end
            move
        end

        def center?
            if !@board.taken?(5)
                return 5
            end
        end

    end

end