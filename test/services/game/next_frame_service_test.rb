require 'test_helper'

class Game::NextFrameServiceTest < ActiveSupport::TestCase
  test '#call moves to a new frame when current frame is finished' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [first_player, second_player],
                       current_player: second_player,
                       frame_number: 0)
    Frame.create(game: game, player: first_player, status: :strike, number: 0)
    Frame.create(game: game, player: second_player, status: :strike, number: 0)

    service = Game::NextFrameService.new(game)
    service.call

    game.reload

    assert_equal(game.current_player, first_player)
    assert_equal(game.frame_number, 1)
  end

  test '#call ends the game when its the last frame' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [first_player, second_player],
                       current_player: second_player,
                       frame_number: 9)
    Frame.create(game: game, player: first_player, status: :strike, number: 9)
    Frame.create(game: game, player: second_player, status: :strike, number: 9)

    service = Game::NextFrameService.new(game)
    service.call

    game.reload

    assert_nil(game.frame_number)
    assert_equal(game.status, 'ended')
  end

  test '#call moves to the next player' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Inigo')
    game = Game.create(players: [first_player, second_player],
                       current_player: second_player,
                       frame_number: 9)

    Frame.create(game: game, player: first_player, status: :strike, number: 9)
    Frame.create(game: game, player: second_player, status: :pending)

    service = Game::NextFrameService.new(game)
    service.call

    game.reload

    assert_equal(game.current_player, second_player)
  end
end

