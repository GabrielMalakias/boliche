class ShotService
  def create(game, player, knocked_down_pins)
    Shot.create(game: game, player: player, knocked_down_pins: knocked_down_pins)
  end
end
