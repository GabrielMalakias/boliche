class FrameService
  ROUNDS = 10

  def start(game, players)
    (0...ROUNDS).each do |number|
      players.each do |player|
        create(game, player, nil, number)
      end
    end
  end

  def shot(frame, knocked_down_pins)
    frame.shots.create(knocked_down_pins: knocked_down_pins)

    if frame.finished?
      case
      when frame.shots.first.strike?
        # pode voltar 2 frames
        # se o anterior for strike volta dois e soma senao soma o atual
        # se o anterior for spare volta 1 e soma shot atual

        frame.update_attribute(:score, 10)
        frame.strike!
      when frame.shots.sum(:knocked_down_pins) == 10

        # volta 1 frame
        # se anterior for strike soma dois shots e coloca no score
        # senao coloca soma um shot no score

        frame.update_attribute(:score, 10)
        frame.spare!
      else
        frame.update_attribute(:score, frame.shots.sum(:knocked_down_pins))
        frame.regular!
      end
    end

    frame.reload
  end

  def find_frame_by_player(frames, current_player, frame_number)
    frames.where(player: current_player, number: frame_number)
  end

  def find_by_game(game_id)
    Frame.where(game_id: game_id)
  end

  private

  def create(game, player, score, number)
    Frame.create(game: game,
                 player: player,
                 score: score,
                 number: number)
  end
end
