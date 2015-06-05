class MovesController < ApplicationController
  before_filter :load_game, only: :create

  def create
    move = create_move
    update_stage
    render json: { game: @game.as_json(include: :active_player), move: move }, status: 201
  end

  protected

  def move_params
    params.fetch(:move, {}).permit(:row, :column, :token)
  end

  def load_game
    @game = Game.find(params[:game_id])
  end

  def update_stage
    @game.update_stage!
  end

  def create_move
    @game.active_player.do_the_move(move_params)
  end
end
