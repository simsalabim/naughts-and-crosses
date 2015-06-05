# == Schema Information
#
# Table name: games
#
#  id               :integer          not null, primary key
#  name             :string
#  rows_size        :integer
#  columns_size     :integer
#  winning_row_size :integer
#  active_player_id :integer
#  winner_id        :integer
#  completed        :boolean          default(FALSE), not null
#  winner_row       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Game < ActiveRecord::Base
  serialize :winner_row, Array

  has_many :players
  has_many :moves, through: :players
  has_one :winner, class_name: 'Player'
  belongs_to :active_player, class_name: 'Player'

  accepts_nested_attributes_for :players
  after_create :assign_active_player

  def console_game
    return @console_game if @console_game

    @console_game = NoughtsAndCrosses::Game.new(rows_size, columns_size, winning_row_size)
    players.each { |player| @console_game.add_player(player.console_player) }
    @console_game.prepare
    @console_game
  end

  def update_stage!
    replay_moves_on_console
    set_completion_or_pass_turn!
  end

  def replay_moves_on_console
    moves.each do |move|
      cell = console_game.cell_at(move.row, move.column)
      console_game.occupy(cell, move.token)
      console_game.pass_turn
    end
  end

  def clone_with_the_same_setup
    game = self.class.new(rows_size: rows_size, columns_size: columns_size, winning_row_size: winning_row_size)
    players.each { |player| game.players << Player.new(strategy: player.strategy, token: player.token) }
    game.save!
    game
  end

  private

  def assign_active_player
    self.active_player = players.find_by(token: console_game.active_player.token)
    save!
  end

  def set_completion_or_pass_turn!
    if console_game.game_over?
      winner_id = active_player.id unless console_game.draw?
      update_attributes!(completed: true, winner_row: console_game.winner_row, winner_id: winner_id)
    else
      self.active_player = players.find_by(token: console_game.active_player.token) if console_game.active_player
      save!
    end
  end
end
