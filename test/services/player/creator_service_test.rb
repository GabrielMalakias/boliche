require 'test_helper'

class Player::CreatorServiceTest < ActiveSupport::TestCase
  test '#call creates a new game for players' do
    params = { name: 'Inigo Montoya' }
    service = Player::CreatorService.new(params)
    player = service.call

    assert_equal(player.new_record?, false)
    assert_equal(player.name, 'Inigo Montoya')
  end
end

