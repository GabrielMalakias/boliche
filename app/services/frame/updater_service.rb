class Frame
  class UpdaterService
    attr_accessor :frame

    def initialize(frame)
      @frame = frame
    end

    def update(attributes)
      frame.update_attributes(attributes)
    end

    def single_update(attribute, value)
      frame.update_attribute(attribute, value)
    end
  end
end
