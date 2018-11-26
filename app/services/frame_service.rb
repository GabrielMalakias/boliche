class FrameService
  ROUNDS = 10

  def start(game, players)
    (1...11).each do |number|
      players.each do |player|
        create(game, player, nil, number)
      end
    end
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
