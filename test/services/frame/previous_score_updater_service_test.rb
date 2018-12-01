require 'test_helper'

class Frame::PreviousScoreUpdaterServiceTest < ActiveSupport::TestCase
  test 'updates previous and previous frame when both are strikes' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player])

    third_frame_shots = []
    2.times do
      third_frame_shots << Shot.create(knocked_down_pins: 4)
    end

    first_frame_shots = [Shot.create(knocked_down_pins: 10)]
    second_frame_shots = [Shot.create(knocked_down_pins: 10)]

    first_frame = Frame.create(game: game,
                               player: player,
                               number: 0,
                               status: :strike,
                               shots: first_frame_shots)

    second_frame = Frame.create(game: game,
                                player: player,
                                number: 1,
                                status: :strike,
                                shots: second_frame_shots)

    third_frame = Frame.create(game: game,
                               player: player,
                               number: 2,
                               status: :regular,
                               shots: third_frame_shots)

    service = Frame::PreviousScoreUpdaterService.new(third_frame)

    service.call

    assert_equal(first_frame.reload.score, 24)
    assert_equal(second_frame.reload.score, 18)
  end

  test 'updates previous frame when it is a strike' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player])

    second_frame_shots = []
    2.times do
      second_frame_shots << Shot.create(knocked_down_pins: 4)
    end

    first_frame_shots = [Shot.create(knocked_down_pins: 10)]

    first_frame = Frame.create(game: game,
                               player: player,
                               number: 0,
                               status: :strike,
                               shots: first_frame_shots)

    second_frame = Frame.create(game: game,
                                player: player,
                                number: 1,
                                score: 8,
                                status: :regular,
                                shots: second_frame_shots)

    service = Frame::PreviousScoreUpdaterService.new(second_frame)

    service.call

    assert_equal(first_frame.reload.score, 18)
    assert_equal(second_frame.reload.score, 8)
  end

  test 'updates previous frame when it is a spare' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player])

    second_frame_shots = []
    2.times do
      second_frame_shots << Shot.create(knocked_down_pins: 4)
    end

    first_frame_shots = [Shot.create(knocked_down_pins: 10)]

    first_frame = Frame.create(game: game,
                               player: player,
                               number: 0,
                               status: :spare,
                               shots: first_frame_shots)

    second_frame = Frame.create(game: game,
                                player: player,
                                number: 1,
                                score: 8,
                                status: :regular,
                                shots: second_frame_shots)

    service = Frame::PreviousScoreUpdaterService.new(second_frame)

    service.call

    assert_equal(first_frame.reload.score, 14)
    assert_equal(second_frame.reload.score, 8)
  end
end
