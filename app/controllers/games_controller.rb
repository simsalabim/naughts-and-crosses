class GamesController < ApplicationController
  before_filter :load_game, only: [:show, :rematch]

  def show
    gon.game = @game.as_json(include: :active_player)
  end

  def new
    @game = Game.new(rows_size: 3, columns_size: 3, winning_row_size: 3)
    @game.players = [Player.new(token: 'x'), Player.new(token: 'o')]
  end

  def create
    game = Game.create!(game_params)
    redirect_to game_path(game)
  end

  def rematch
    new_game = @game.clone_with_the_same_setup
    redirect_to game_path(new_game)
  end

  protected

  def load_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:rows_size, :columns_size, :winning_row_size, players_attributes: [:token, :strategy])
  end
end
