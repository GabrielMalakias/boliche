class FrameSerializer
  include FastJsonapi::ObjectSerializer

  attribute :score, :number

  has_one :player
end

