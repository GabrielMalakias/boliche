require 'test_helper'

class PlayerTest < ActionDispatch::IntegrationTest
  def test_create
    name = 'Inigo Montoya'

    assert_difference -> { Player.count } do
      post "/players", params: { name: name }, as: :json
    end

    assert_response :success
    assert_equal({"id" => Player.last.id, "name" => name}, response.parsed_body)
  end
end
