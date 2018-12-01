class Shot < ApplicationRecord
  STRIKE = 10
  SPARE = STRIKE

  belongs_to :frame

  def strike?
    knocked_down_pins == STRIKE
  end
end
