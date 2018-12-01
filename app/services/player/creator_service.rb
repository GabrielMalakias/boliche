class Player
  class CreatorService
    attr_accessor :params

    def initialize(params)
      @params = params
    end

    def call
      Player.create(name: params[:name])
    end
  end
end
