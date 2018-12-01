class Player
  class FinderService
    def by_ids(ids)
      Player.where(id: ids).all
    end
  end
end
