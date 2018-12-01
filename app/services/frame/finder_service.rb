class Frame
  class FinderService
    def current_frame(game)
      game
        .frames
        .where(player: game.current_player,
               number: game.frame_number)
        .first
    end

    def previous(frame)
      return nil if not frame.previous?
      Frame.where(game: frame.game,
                  player: frame.player,
                  number: frame.previous_number)
        .first
    end

    def sum_score_by_game_and_player(game, player)
      game
        .frames
        .where(player: player)
        .sum(:score)
    end
  end
end
