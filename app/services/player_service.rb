class PlayerService
  def create(params)
    Player.create(params)
  end

  def find(ids)
    Player.where(id: ids).all
  end
end
