require 'test_helper'

class Game::ShotServiceTest < ActiveSupport::TestCase
  test '#call raises error when the game was ended' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player], current_player: player, status: :ended)

    service = Game::ShotService.new(game.id, 10)

    assert_raises Game::ShotService::EndedError do
      service.call
    end
  end

  test '#call adds a new shot, calculates the result and ends the game' do
    player = Player.create(name: 'Inigo Montoya')
    game = Game.create(players: [player],
                       current_player: player, frame_number: 9)
    Score.create(game: game, player: player)

    Frame.create(player: player,
                         number: 8,
                         score: 8,
                         game: game,
                         status: :regular)

    frame = Frame.create(player: player,
                         number: 9,
                         game: game)

    frame.shots.create(knocked_down_pins: 10)
    frame.shots.create(knocked_down_pins: 10)

    service = Game::ShotService.new(game.id, 10)
    game = service.call

    assert_equal(game.current_player, player)
    assert_equal(game.status, 'ended')
    assert_equal(game.scores.first.points, 38)
    assert_equal(game.frames.last.status, 'strike')
    assert_equal(game.frames.last.score, 30)
  end

  test '#call adds a new shot, adds the score, and moves to the next player' do
    first_player = Player.create(name: 'Inigo Montoya')
    second_player = Player.create(name: 'Montoya')
    game = Game.create(players: [first_player, second_player],
                       current_player: first_player, frame_number: 0)
    Score.create(game: game, player: first_player)
    Score.create(game: game, player: second_player)

    first_frame = Frame.create(player: first_player,
                               number: 0,
                               game: game)

    first_frame.shots.create(knocked_down_pins: 3)

    Frame.create(player: second_player,
                 game: game,
                 number: 0)

    service = Game::ShotService.new(game.id, 5)
    game = service.call

    assert_equal(game.current_player, second_player)
    assert_equal(game.frames.first.status, 'regular')
    assert_equal(game.frames.first.score, 8)
    assert_equal(game.scores.first.points, 8)
  end
end

