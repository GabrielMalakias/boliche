require 'test_helper'

class Game::CreatorServiceTest < ActiveSupport::TestCase
  test '#call creates a new game for players' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Inigo Montoya')

    service = Game::CreatorService.new([first_player.id, second_player.id])

    game = service.call

    assert_equal(game.players.count, 2)
    assert_equal(game.current_player, first_player)
    assert_equal(game.scores.count, 2)
    assert_equal(game.frames.count, 20)
  end
end

