require 'test_helper'

class Frame::UpdaterServiceTest < ActiveSupport::TestCase
  test '#update updates all attributes' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player)
    frame = Frame.create(player: player, game: game, number: 0, status: :regular)

    service = Frame::UpdaterService.new(frame)
    service.update({ number: 2, status: :strike })

    frame.reload

    assert_equal(frame.number, 2)
    assert_equal(frame.status, 'strike')
  end

  test '#single_update update only one attribute' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player)
    frame = Frame.create(player: player, game: game, number: 0, status: :regular)

    service = Frame::UpdaterService.new(frame)
    service.single_update(:status, :strike)

    frame.reload

    assert_equal(frame.status, 'strike')
  end
end

