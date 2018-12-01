class Frame
  class PreviousScoreUpdaterService
    attr_accessor :current_frame

    def initialize(current_frame)
      @current_frame = current_frame
    end

    def call
      previous_frame = find_previous(current_frame)

      if previous_frame.present?
        calculate_strike_score(previous_frame) if previous_frame.strike?
        calculate_spare_score(previous_frame) if previous_frame.spare?
      end

      current_frame
    end

    private

    def calculate_spare_score(previous_frame)
      new_score = Shot::SPARE + current_frame.first_shot.knocked_down_pins

      frame_updater_service(previous_frame)
        .single_update(:score, new_score)
    end

    def calculate_strike_score(previous_frame)
      new_score = Shot::STRIKE + current_frame.knocked_down_pins

      frame_updater_service(previous_frame)
        .single_update(:score, new_score)


      previous_of_previous_frame = find_previous(previous_frame)


      if previous_of_previous_frame.present? && previous_of_previous_frame.strike?
        calculate_previous_of_previous_frame(previous_of_previous_frame, previous_frame)
      end
    end

    def calculate_previous_of_previous_frame(frame, previous_frame)
      new_score = Shot::STRIKE + previous_frame.knocked_down_pins + current_frame.first_shot.knocked_down_pins

      frame_updater_service(frame)
        .single_update(:score, new_score)
    end

    def find_previous(frame)
      frame_finder_service.previous(frame)
    end

    def frame_finder_service
      Frame::FinderService.new
    end

    def frame_updater_service(frame)
      Frame::UpdaterService.new(frame)
    end
  end
end
