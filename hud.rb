
#This is the heads up display bar that will display the energy and the score left for the user to identify
class Hud < Engine::Sprite
  
  #These are the instance variables for the heads up diaplay function
  def initialize
    super
    @image = Engine::Game.images["hud"]
    @x = Engine::Game::ScreenWidth / 2
    @y = Engine::Game::ScreenHeight - @image.height / 2 - 5
    @z = ZOrder::Hud #The layer in which the heads up display will appear in
  end
end
