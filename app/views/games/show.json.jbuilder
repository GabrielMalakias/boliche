json.data do
  json.id @game.id
  json.frame_number @game.frame_number
  json.current_player @game.current_player.name
  json.status @game.status

  json.players @game.players, partial: 'players/player', as: :player
  json.frames @game.frames, partial: 'frames/frame', as: :frame
  json.scores @game.scores, partial: 'scores/score', as: :score
end
