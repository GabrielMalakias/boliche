require 'test_helper'

class Score::UpdaterServiceTest < ActiveSupport::TestCase
  test '#call updates the score summing all frames' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(current_player: player, players: [player])
    game.scores.create(player: player, points: 0)

    Frame.create(game: game, player: player, score: 30, number: 0)
    Frame.create(game: game, player: player, score: 20, number: 1)
    Frame.create(game: game, player: player, score: 10, number: 2)

    service = Score::UpdaterService.new(game, player)
    service.call

    game.reload

    assert_equal(game.scores.first.points, 60)
  end
end

