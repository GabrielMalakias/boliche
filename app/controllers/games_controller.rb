class GamesController < ApplicationController
  def create
    @game = service.create(clean_params)

    render 'games/create', status: :created
  end

  def show
    @game = service.find(params[:id])

    render 'games/show', status: :ok
  end

  def shot
    @game = service.shot(params[:id], clean_params)

    render 'games/show', status: :created
  end

  private

  def serialize(game)
    options = { include: [:frames, :'frames.shots', :'frames.shots'] }

    GameSerializer.new(game, options).serialized_json
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
