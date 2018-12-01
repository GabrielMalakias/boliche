class Game
  class FinderService
    def by_id(id)
      Game.where(id: id)
        .includes(:frames)
        .includes(:scores)
        .first
    end
  end
end
