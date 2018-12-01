class Game
  class ShotService
    EndedError = Class.new(StandardError)

    attr_accessor :id, :knocked_down_pins

    def initialize(id, knocked_down_pins)
      @id = id
      @knocked_down_pins = knocked_down_pins
    end

    def call
      game = find_game(id)

      raise_game_ended_error if game.ended?

      frame = find_frame(game)

      frame = frame_shot_service(frame).call(knocked_down_pins)
      move_and_update(game, frame) if frame.finished?

      game.reload
    end

    private

    def move_and_update(game, frame)
      game.reload
      current_player = game.current_player

      game_next_frame_service(game).call
      frame_previous_score_updater_service(frame).call
      score_updater_service(game, current_player).call
    end

    def find_game(id)
      game_finder_service.by_id(id)
    end

    def find_frame(game)
      frame_finder_service.current_frame(game)
    end

    def frame_finder_service
      Frame::FinderService.new
    end

    def frame_shot_service(frame)
      Frame::ShotService.new(frame)
    end

    def game_finder_service
      Game::FinderService.new
    end

    def game_next_frame_service(game)
      Game::NextFrameService.new(game)
    end

    def frame_previous_score_updater_service(frame)
      Frame::PreviousScoreUpdaterService.new(frame)
    end

    def score_updater_service(game, player)
      Score::UpdaterService.new(game, player)
    end

    def raise_game_ended_error
      raise EndedError, 'For playing again, start a new one'
    end
  end
end
