json.data do
  json.id @game.id

  json.players @game.players, partial: 'players/player', as: :player
end
