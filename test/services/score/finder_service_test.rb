require 'test_helper'

class Score::FinderServiceTest < ActiveSupport::TestCase
  test '#find_by_game_and_player returns the right score' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Montoya')
    game = Game.create(current_player: first_player, players: [first_player, second_player])
    Score.create(game: game, player: first_player, points: 20)
    score = Score.create(game: game, player: second_player, points: 10)

    service = Score::FinderService.new
    result = service.find_by_game_and_player(game, second_player)

    assert_equal(result, score)
  end
end
