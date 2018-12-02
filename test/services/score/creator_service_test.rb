require 'test_helper'

class Score::CreatorServiceTest < ActiveSupport::TestCase
  test '#call creates a new game for players' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Montoya')
    game = Game.create(current_player: first_player, players: [first_player, second_player])

    service = Score::CreatorService.new(game)
    service.call

    game.reload

    assert_equal(game.scores.count, 2)
    assert_equal(game.scores.first.points, 0)
    assert_equal(game.scores.last.points, 0)
  end
end

