require 'test_helper'

class Game::UpdaterServiceTest < ActiveSupport::TestCase
  test '#call updates all attributes' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player)

    service = Game::UpdaterService.new(game)
    service.call({ frame_number: 2, status: :ended })

    game.reload

    assert_equal(game.frame_number, 2)
    assert_equal(game.status, 'ended')
  end
end

