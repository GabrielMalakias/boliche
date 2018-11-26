class Game < ApplicationRecord
  has_many :shots
  has_many :frames
  has_and_belongs_to_many :players
  belongs_to :current_player, class_name: :Player
end
