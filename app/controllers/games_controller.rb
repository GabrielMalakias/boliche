class GamesController < ApplicationController
  def create
    @game = game_creator_service.()

    render 'games/create', status: :created
  end

  def show
    @game = game_finder_service.by_id(params[:id])

    render 'games/show', status: :ok
  end

  def shot
    @game = game_shot_service.call

    render 'games/show', status: :created
  rescue Game::ShotService::EndedError
    head :precondition_failed
  end

  private

  def game_shot_service
    Game::ShotService.new(params[:id], params[:game][:knocked_down_pins])
  end

  def game_finder_service
    Game::FinderService.new
  end

  def game_creator_service
    Game::CreatorService.new(params[:game][:players])
  end
end
