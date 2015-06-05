module GameHelper
  def player_strategies_options
    Player::STRATEGIES_MAPPING.map { |m| m[:title] }
  end

  def cell_inline_styles
    "width: #{cell_width(@game)}% !important;"
  end

  def cell_width(game)
    80 / game.columns_size
  end

  def board_for(game)
    array = []
    for i in 0...game.rows_size
      row = []
      for j in 0...game.columns_size
        move = game.moves.find_by(row: i, column: j)
        cell = if move
                 { row: move.row, column: move.column, token: move.token }
               else
                 { row: i, column: j, token: nil }
               end

        row << cell
      end
      array << row
    end
    array
  end
end
