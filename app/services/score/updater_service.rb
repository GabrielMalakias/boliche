class Score
  class UpdaterService
    attr_accessor :game, :player

    def initialize(game, player)
      @game = game
      @player = player
    end

    def call
      new_score = frame_finder_service
        .sum_score_by_game_and_player(game, player)

      score_finder_service
        .find_by_game_and_player(game, player)
        .update_attribute(:points, new_score)
    end

    private

    def score_finder_service
      Score::FinderService.new
    end

    def frame_finder_service
      Frame::FinderService.new
    end
  end
end
