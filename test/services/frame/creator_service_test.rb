require 'test_helper'

class Frame::CreatorServiceTest < ActiveSupport::TestCase
  test 'creates a new frames for a game' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [first_player, second_player], current_player: first_player)

    service = Frame::CreatorService.new(game)
    service.call

    game.reload

    assert_equal(game.frames.count, 20)
    assert_equal(game.frames.where(player: first_player).count, 10)
  end
end

