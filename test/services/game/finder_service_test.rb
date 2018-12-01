require 'test_helper'

class Game::FinderServiceTest < ActiveSupport::TestCase
  test '#by_id returns the right game' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)

    service = Game::FinderService.new
    result = service.by_id(game.id)

    assert_equal(result, game)
  end
end

