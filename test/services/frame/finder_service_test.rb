require 'test_helper'

class Frame::FinderServiceTest < ActiveSupport::TestCase
  test '#current_frame returns the current frame given a game' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    (1...4).each do |number|
      Frame.create(player: player, game: game, number: number)
    end
    frame = Frame.where(number: 2).first

    service = Frame::FinderService.new
    value = service.current_frame(game)

    assert_equal(value, frame)
  end

  test '#previous returns nil when theres no previous' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    first_frame = Frame.create(player: player, game: game, number: 0)

    service = Frame::FinderService.new
    value = service.previous(first_frame)

    assert_nil(value)
  end

  test '#previous returns the previous frame given a frame' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    first_frame = Frame.create(player: player, game: game, number: 0)
    second_frame = Frame.create(player: player, game: game, number: 1)

    service = Frame::FinderService.new
    value = service.previous(second_frame)

    assert_equal(value, first_frame)
  end

  test '#sum_score_by_game_and_player returns the player score' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player)
    first_frame = Frame.create(player: player, game: game, number: 0, score: 10)
    second_frame = Frame.create(player: player, game: game, number: 1, score: 5)

    service = Frame::FinderService.new
    value = service.sum_score_by_game_and_player(game, player)

    assert_equal(value, 15)
  end
end

