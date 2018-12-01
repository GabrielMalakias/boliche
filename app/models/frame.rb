class Frame < ApplicationRecord
  SHOTS = 2
  LAST_FRAME_SHOTS = 3
  ROUNDS_NUMBER = 10
  ENDS_AT = 9

  belongs_to :game
  belongs_to :player
  has_many :shots

  enum status: [:pending, :regular, :spare, :strike]

  default_scope { order(:id) }

  def last?
    number == ENDS_AT
  end

  def finished?
    no_shots? || (shots.first.strike? && !last?)
  end

  def previous?
    previous_number >= 0
  end

  def no_shots?
    if last? && (shots.first.strike? || two_shots_knocked_down_pins == 10)
      shots.count == LAST_FRAME_SHOTS
    else
      shots.count == SHOTS
    end
  end

  def two_shots_knocked_down_pins
    shots.order(:id).limit(2).map do |s|
      s.knocked_down_pins
    end.sum
  end

  def previous_number
    number - 1
  end

  def knocked_down_pins
    shots.sum(:knocked_down_pins)
  end

  def first_shot
    shots.first
  end
end
