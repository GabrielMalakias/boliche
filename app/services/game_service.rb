class GameService
  def create(params)
    players = find_players(params)

    start(players).tap do |game|
      frame_service.start(game, players)
    end
  end

  def shot(id, params)
    game = find_game(id)
    frame = find_frame(game.frames, game.current_player, game.frame_number)

    frame = frame_service.shot(frame, params[:knocked_down_pins])

    next_frame(game) if frame.finished?

    game.reload
  end

  def find_frame(frames, current_player, number)
    frames.where(player: current_player, number: number).first
  end

  def find(id)
    find_game(id)
  end

  private

  def next_frame(game)
    attributes = {}

    if game.current_frame_finished?
      attributes = {
        current_player: game.players.first,
        frame_number: game.frame_number + 1
      }
    else
      current_player_index = game.players.index(game.current_player)
      attributes = {
        current_player: game.players[current_player_index + 1]
      }
    end

    game.update_attributes(attributes)
  end

  def start(players)
    Game.create(players: players, current_player: players.first)
  end

  def update_current_player(player)
    game.update_attribute(current_player: player)
  end

  def find_players(params)
    player_service.find(params[:players])
  end

  def find_game(id)
    Game.where(id: id)
      .includes(:frames)
      .first
  end

  def frame_service
    FrameService.new
  end

  def player_service
    PlayerService.new
  end
end
