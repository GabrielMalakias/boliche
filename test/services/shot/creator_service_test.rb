require 'test_helper'

class Shot::CreatorServiceTest < ActiveSupport::TestCase
  test '#call creates a new shot' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 0)

    service = Shot::CreatorService.new(frame)
    assert_difference -> { Shot.count } do
      service.call(10)
    end

    assert_equal(Shot.last.knocked_down_pins, 10)
  end
end

