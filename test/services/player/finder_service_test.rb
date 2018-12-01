require 'test_helper'

class Player::FinderServiceTest < ActiveSupport::TestCase
  test '#by_ids returns players' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Inigo Montoya')
    ids = [first_player.id, second_player.id]


    service = Player::FinderService.new
    players = service.by_ids(ids)

    assert_equal(players, [first_player, second_player])
  end
end

