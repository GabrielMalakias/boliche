class CurrentPlayerService
  def player(game)
    players = game.players.to_a

    first_player = players.pop

    current_player = first_player

    shots_counter = shots_number(first_player, game)

    game.players.map do |player|
      player_shots_number = shots_number(player, game)

      if player_shots_number < shots_counter
        current_player = player
        shots_counter = player_shots_number
      end
    end

    current_player
  end

  private

  def shots_number(player, game)
    Shot.where(player: player, game: game).count
  end
end
