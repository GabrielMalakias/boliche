json.data do
  json.id @game.id
  json.frame_number @game.frame_number
  json.current_player @game.current_player.name

  json.players @game.players, partial: 'players/player', as: :player
  json.frames @game.frames, partial: 'frames/frame', as: :frame
end
