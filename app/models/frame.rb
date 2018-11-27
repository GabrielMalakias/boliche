class Frame < ApplicationRecord
  ENDS_AT_FRAME = 9

  SHOTS = 2
  LAST_FRAME_SHOTS = 3

  belongs_to :game
  belongs_to :player
  has_many :shots

  enum status: [:pending, :regular, :spare, :strike]

  def last?
    number == ENDS_AT_FRAME
  end

  def finished?
    if last?
      shots.count == LAST_FRAME_SHOTS
    else
      shots.count == SHOTS
    end
  end
end
