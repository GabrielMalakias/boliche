class Game
  class CreatorService
    attr_accessor :players_ids

    def initialize(players_ids)
      @players_ids = players_ids
    end

    def call
      players = find_players
      game = create_game(players)
      create_frames(game)
      create_scores(game)

      game.reload
    end

    private

    def create_scores(game)
      score_creator_service(game).call
    end

    def create_frames(game)
      frame_creator_service(game).call
    end

    def create_game(players)
      Game.create(players: players,
                  current_player: players.first)
    end

    def find_players
      players_finder_service.by_ids(players_ids)
    end

    def score_creator_service(game)
      Score::CreatorService.new(game)
    end

    def frame_creator_service(game)
      Frame::CreatorService.new(game)
    end

    def players_finder_service
      Player::FinderService.new
    end
  end
end
