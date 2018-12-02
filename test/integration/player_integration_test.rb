require 'test_helper'

class PlayerIntegrationTest < ActionDispatch::IntegrationTest
  def test_create
    name = 'Inigo Montoya'

    assert_difference -> { Player.count } do
      post "/players", params: { name: name }, as: :json
    end

    expected_response = { "data" => {"id" => Player.last.id, "name" => name} }

    assert_response :success
    assert_equal(expected_response, response.parsed_body)
  end
end
