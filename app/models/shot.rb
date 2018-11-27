class Shot < ApplicationRecord
  STRIKE = 10

  belongs_to :frame

  def strike?
    knocked_down_pins == STRIKE
  end
end
