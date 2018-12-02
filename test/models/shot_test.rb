require 'test_helper'

class ShotTest < ActiveSupport::TestCase
  test 'STRIKE to equal 10' do
    assert_equal(Shot::STRIKE, 10)
  end

  test 'SPARE to equal 10' do
    assert_equal(Shot::SPARE, 10)
  end

  test '#strike? returns true when knocked down pins is equal 10' do
    shot = Shot.new(knocked_down_pins: 10)

    assert_equal(shot.strike?, true)
  end

  test '#strike? returns false when knocked down pins isnt equal 10' do
    shot = Shot.new(knocked_down_pins: 8)

    assert_equal(shot.strike?, false)
  end
end

