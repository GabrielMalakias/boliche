class Game
  class NextFrameService
    attr_accessor :game

    def initialize(game)
      @game = game
    end

    def call
      game_updater_service(game).call(build_attributes)
    end

    private

    def build_attributes
      if game.current_frame_finished?
        move_to_next_frame_attributes
      else
        move_to_next_player_attributes
      end
    end

    def move_to_next_player_attributes
      {
        current_player: game.next_player
      }
    end

    def move_to_next_frame_attributes
      if game.last_frame?
        {
          frame_number: nil,
          status: :ended
        }
      else
        {
          current_player: game.first_player,
          frame_number: game.next_frame_number
        }
      end
    end

    def game_updater_service(game)
      Game::UpdaterService.new(game)
    end
  end
end
