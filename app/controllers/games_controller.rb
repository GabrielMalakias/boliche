class GamesController < ApplicationController
  def create
    game = service.create(clean_params)

    render json: serialize(game), status: :created
  end

  def show
    game = service.find(params[:id])

    render json: serialize(game)
  end

  def frames
    frames = frame_service.find_by_game(params[:id])

    render json: serialize_frames(frames)
  end

  def shot
    game = service.shot(params[:id], clean_params)

    render json: serialize(game), status: :created
  end

  private

  def serialize(game)
    GameSerializer.new(game).serialized_json
  end

  def serialize_frames(frames)
    FrameSerializer.new(frames).serialized_json
  end

  def service
    GameService.new
  end

  def frame_service
    FrameService.new
  end

  def clean_params
    params.require(:game).permit!
  end
end
