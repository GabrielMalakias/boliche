class Frame
  class CreatorService
    attr_accessor :game

    def initialize(game)
      @game = game
    end

    def call
      (0...Frame::ROUNDS_NUMBER).each do |number|
        game.players.each do |player|
          create(game, player, nil, number)
        end
      end
    end

    private

    def create(game, player, score, number)
      Frame.create(game: game,
                   player: player,
                   score: score,
                   number: number)
    end
  end
end
