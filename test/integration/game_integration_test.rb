require 'test_helper'

class GameIntegrationTest < ActionDispatch::IntegrationTest
  def test_create
    player_1 = Player.create(name: 'Inigo Montoya')
    player_2 = Player.create(name: 'Montoya')

    assert_difference -> { Game.count } do
      post "/games", params: { game: { players: [player_1.id, player_2.id] } }, as: :json
    end

    expected_response = {"data" => {"id" => Game.last.id, "players" => [player_1, player_2].as_json}}
    assert_response :success

    assert_equal(expected_response, response.parsed_body)
  end

  def test_shot
    player_1 = Player.create(name: 'Montoya')
    game = Game.create(players: [player_1], current_player: player_1)
    frame = Frame.create(player: player_1, game: game, number: 0)

    assert_difference -> { Shot.count } do
      post "/games/#{game.id}/shot", params: { game: { knocked_down_pins: 2 } }, as: :json
    end

    assert_response :success
  end
end
