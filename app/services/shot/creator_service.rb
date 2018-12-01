class Shot
  class CreatorService
    attr_accessor :frame

    def initialize(frame)
      @frame = frame
    end

    def call(knocked_down_pins)
      Shot.create(frame: frame, knocked_down_pins: knocked_down_pins)
    end
  end
end
