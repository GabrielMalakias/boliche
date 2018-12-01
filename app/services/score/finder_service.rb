class Score
  class FinderService
    def find_by_game_and_player(game, player)
      Score.where(game: game,
                  player: player)
        .first
    end
  end
end
