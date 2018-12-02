require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test '#current_frame_finished? returns true when theres no pending frame for current number' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, frame_number: 2)
    Frame.create(player: player, game: game, number: 2, status: :strike)

    game.reload

    assert_equal(game.current_frame_finished?, true)
  end

  test '#current_frame_finished? returns false when theres a pending frame for current number' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Montoya')
    game = Game.create(players: [first_player, second_player],
                       current_player: first_player,
                       frame_number: 2)
    Frame.create(player: first_player, game: game, number: 2, status: :strike)
    Frame.create(player: second_player, game: game, number: 2)

    game.reload

    assert_equal(game.current_frame_finished?, false)
  end

  test '#first_player returns the first player' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Montoya')
    game = Game.create(players: [first_player, second_player],
                       current_player: first_player)

    assert_equal(game.first_player, first_player)
  end

  test '#next_frame_number returns frame number plus 1' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player,
                       frame_number: 8)

    assert_equal(game.next_frame_number, 9)
  end

  test '#last_frame? returns true when frame number is 9' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player,
                       frame_number: 9)

    assert_equal(game.last_frame?, true)
  end

  test '#last_frame? returns false when frame number isnt 9' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player,
                       frame_number: 3)

    assert_equal(game.last_frame?, false)
  end

  test '#next_player returns the next player' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Montoya')
    game = Game.create(players: [first_player, second_player],
                       current_player: first_player)

    assert_equal(game.next_player, second_player)
  end
end
