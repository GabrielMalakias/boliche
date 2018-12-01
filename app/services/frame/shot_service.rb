class Frame
  class ShotService
    attr_accessor :frame

    def initialize(frame)
      @frame = frame
    end

    def call(knocked_down_pins)
      shot_creator_service(frame).call(knocked_down_pins)

      update_finished if frame.finished?

      frame.reload
    end

    private

    def update_finished
      case
      when frame.shots.first.strike?
        update_strike
      when frame.two_shots_knocked_down_pins == Shot::SPARE
        update_spare
      else
        update_regular
      end
    end

    def update_strike
      attributes = { status: :strike }

      if frame.last?
        attributes.merge!(score: frame.shots.sum(:knocked_down_pins))
      end

      frame_updater_service(frame).update(attributes)
    end

    def update_spare
      attributes = { status: :spare }

      if frame.last?
        attributes.merge!(score: frame.shots.sum(:knocked_down_pins))
      end

      frame_updater_service(frame).update(attributes)
    end

    def update_regular
      attributes = { score: frame.shots.sum(:knocked_down_pins),
                     status: :regular }

      frame_updater_service(frame).update(attributes)
    end

    def frame_updater_service(frame)
      Frame::UpdaterService.new(frame)
    end

    def shot_creator_service(frame)
      Shot::CreatorService.new(frame)
    end
  end
end
