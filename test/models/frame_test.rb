require 'test_helper'

class FrameTest < ActiveSupport::TestCase
  test 'SHOTS to equal 2' do
    assert_equal(Frame::SHOTS, 2)
  end

  test 'LAST_FRAME_SHOTS to equal 3' do
    assert_equal(Frame::LAST_FRAME_SHOTS, 3)
  end

  test 'ROUNDS_NUMBER to equal 10' do
    assert_equal(Frame::ROUNDS_NUMBER, 10)
  end

  test 'ENDS_AT to equal 9' do
    assert_equal(Frame::ENDS_AT, 9)
  end

  test '#last? returns false when number isnt 9' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 10)

    assert_equal(frame.last?, false)
  end

  test '#last? returns true when number is 9' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 9)

    assert_equal(frame.last?, true)
  end

  test '#finished? returns true when theres two shots for this frame' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 2)
    frame.shots.create(knocked_down_pins: 4)
    frame.shots.create(knocked_down_pins: 2)

    assert_equal(frame.finished?, true)
  end

  test '#finished? returns true when theres one shot and its a strike' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 2)
    frame.shots.create(knocked_down_pins: 10)

    assert_equal(frame.finished?, true)
  end

  test '#finished? returns false when theres two shots but its the last frame' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 9)
    frame.shots.create(knocked_down_pins: 10)
    frame.shots.create(knocked_down_pins: 10)

    assert_equal(frame.finished?, false)
  end

  test '#previous? returns true when its not the first frame' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 8)

    assert_equal(frame.previous?, true)
  end

  test '#previous? returns false when its the first frame' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 0)

    assert_equal(frame.previous?, false)
  end

  test '#no_shots? returns true when this frame already has two shots' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 8)
    frame.shots.create(knocked_down_pins: 10)
    frame.shots.create(knocked_down_pins: 10)

    assert_equal(frame.no_shots?, true)
  end

  test '#no_shots? returns false when this frame has just one shot' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 8)
    frame.shots.create(knocked_down_pins: 3)

    assert_equal(frame.no_shots?, false)
  end

  test '#no_shots? returns true when its the last frame and its a strike' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 9)
    frame.shots.create(knocked_down_pins: 10)
    frame.shots.create(knocked_down_pins: 3)
    frame.shots.create(knocked_down_pins: 3)

    assert_equal(frame.no_shots?, true)
  end

  test '#two_shots_knocked_down_pins returns 8 when has two shots with 4 knocked down pins' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 9)
    frame.shots.create(knocked_down_pins: 4)
    frame.shots.create(knocked_down_pins: 4)
    frame.shots.create(knocked_down_pins: 2)

    assert_equal(frame.two_shots_knocked_down_pins, 8)
  end

  test '#previous_number returns 8 when number is 9' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 9)

    assert_equal(frame.previous_number, 8)
  end

  test '#knocked_down_pins sum all knocked down pins' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 9)
    frame.shots.create(knocked_down_pins: 4)
    frame.shots.create(knocked_down_pins: 4)
    frame.shots.create(knocked_down_pins: 2)

    assert_equal(frame.knocked_down_pins, 10)
  end

  test '#first_shot returns the first shot' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    frame = Frame.create(player: player, game: game, number: 8)
    frame.shots.create(knocked_down_pins: 4)
    frame.shots.create(knocked_down_pins: 2)

    assert_equal(frame.first_shot.knocked_down_pins, 4)
  end
end

