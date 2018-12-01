class Game < ApplicationRecord
  has_many :shots
  has_many :frames
  has_many :scores
  has_and_belongs_to_many :players
  belongs_to :current_player, class_name: :Player

  enum status: [:playing, :ended]

  def current_frame_finished?
    count = frames
      .where(number: frame_number)
      .where(status: [:pending])
      .count

    count == 0
  end

  def first_player
    players.first
  end

  def next_frame_number
    frame_number + 1
  end

  def last_frame?
    frame_number == Frame::ENDS_AT
  end

  def next_player
    current_player_index = players.index(current_player)

    players[current_player_index + 1]
  end
end
