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
    game.replay_moves_on_console
    game.console_game.board.map do |row|
      row.map do |cell|
        { row: cell.row, column: cell.column, token: cell.token }
      end
    end
  end
end
