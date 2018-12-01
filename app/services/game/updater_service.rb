class Game
  class UpdaterService
    attr_accessor :game

    def initialize(game)
      @game = game
    end

    def call(attributes)
      game.update_attributes(attributes)
    end
  end
end
