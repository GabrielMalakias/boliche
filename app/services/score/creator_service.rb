class Score
  class CreatorService
    attr_accessor :game

    def initialize(game)
      @game = game
    end

    def call
      game.players.each do |player|
        create(game, player)
      end
    end

    private

    def create(game, player)
      Score.create(game: game,
                   player: player,
                   points: 0)
    end
  end
end
