require 'test_helper'

class Frame::ShotServiceTest < ActiveSupport::TestCase
  test '#call adds a new shot when the frame was not finished' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    frame = Frame.create(player: player, game: game, number: 0)

    service = Frame::ShotService.new(frame)
    value = service.call(5)

    assert_equal(value.status, 'pending')
    assert_equal(value.shots.count, 1)
  end

  test '#call finished the frame when its a strike' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    frame = Frame.create(player: player, game: game, number: 0)

    service = Frame::ShotService.new(frame)
    value = service.call(10)

    assert_equal(value.status, 'strike')
    assert_equal(value.shots.count, 1)
  end

  test '#call calculates the score when its the last frame and is a spare' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    frame = Frame.create(player: player, game: game, number: 9)

    service = Frame::ShotService.new(frame)
    service.call(5)
    service.call(5)
    value = service.call(10)

    assert_equal(value.status, 'spare')
    assert_equal(value.shots.count, 3)
    assert_equal(value.score, 20)
  end

  test '#call calculates the score when its the last frame and is a strike' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    frame = Frame.create(player: player, game: game, number: 9)

    service = Frame::ShotService.new(frame)
    service.call(10)
    service.call(10)
    value = service.call(10)

    assert_equal(value.status, 'strike')
    assert_equal(value.shots.count, 3)
    assert_equal(value.score, 30)
  end

  test '#call calculates the score when its the last frame and is a regular' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    frame = Frame.create(player: player, game: game, number: 9)

    service = Frame::ShotService.new(frame)
    service.call(3)
    value = service.call(2)

    assert_equal(value.status, 'regular')
    assert_equal(value.shots.count, 2)
    assert_equal(value.score, 5)
  end
end
