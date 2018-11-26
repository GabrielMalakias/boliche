class GameService
  def create(params)
    players = find_players(params)

    start(players, players.last).tap do |game|
      frame_service.start(game, players)
    end
  end

  def shot(id, params)
    game = find_game(params[:id])
    player = current_player(game)
    update_current_player(player)

    shot_service.create(game, player, params[:knocked_down_pins])
  end

  def find(id)
    find_game(id)
  end

  private

  def start(players, current_player)
    Game.create(players: players, current_player: players.first)
  end

  def update_current_player(player)
    game.update_attribute(current_player: player)
  end

  def current_player(game)
    current_player_service.player(game)
  end

  def find_players(params)
    player_service.find(params[:players])
  end

  def find_game(id)
    Game.where(id: id)
      .joins(:frames)
      .first
  end

  def frame_service
    FrameService.new
  end

  def player_service
    PlayerService.new
  end

  def shot_service
    ShotService.new
  end

  def current_player_service
    CurrentPlayerService.new
  end
end
