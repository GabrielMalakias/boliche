class GameSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  set_type :game

  has_many :frames
end
