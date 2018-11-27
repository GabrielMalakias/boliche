class Game < ApplicationRecord
  has_many :shots
  has_many :frames
  has_and_belongs_to_many :players
  belongs_to :current_player, class_name: :Player

  def current_frame_finished?
    count = frames
      .where(number: frame_number)
      .where(status: [:pending])
      .count

    count == 0
  end
end
