class FrameSerializer
  include FastJsonapi::ObjectSerializer

  attribute :score, :number, :status

  has_one :player
  has_many :shots
end

