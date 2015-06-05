# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  strategy   :string
#  token      :string
#  game_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Player < ActiveRecord::Base
  belongs_to :game
  has_many :moves

  STRATEGIES_MAPPING = [
    { title: 'Human', class: NoughtsAndCrosses::Player::Human },
    { title: 'AI: expert', class: NoughtsAndCrosses::Player::AI::WinBlockOrOptimal },
    { title: 'AI: random',  class: NoughtsAndCrosses::Player::AI::Random }
  ]

  def human?
    console_player_class == NoughtsAndCrosses::Player::Human
  end

  def console_player_class
    STRATEGIES_MAPPING.find { |m| m[:title] == strategy }[:class]
  end

  def console_player
    console_player_class.new(token)
  end

  def do_the_move(move_params)
    if human?
      moves.create!(move_params)
      game.replay_moves_on_console
    else
      make_move
    end
  end

  def make_move
    game.replay_moves_on_console
    cell = game.console_game.active_player.make_move
    moves.create!(row: cell.row, column: cell.column, token: cell.token)
  end
end
