


class EnergyBar < Engine::Sprite #This is the class written for the energy bar of the ship as 5 collisions happen the transparent energy bar will fully appear overtaking the white energy bar
  BarWidth = 15 
  
  #These are the instance variables required for this module 
  def initialize
    super 
    @image = Engine::Game.images["energy low"]
    @image_full = Engine::Game.images["energy full"]   
    @x = 50 
    @y = Engine::Game::ScreenHeight - @image.height / 2 - 12
    @z = ZOrder::HudFG #The layer in which the energy bar will appear
    @energy = 0 
  end
  
  
  def draw #This function will draw the energy bar on the game window
    super
    @energy = Engine::Game.game_state.energy
    #Both the energy full and energy low (transparent) images will be clipped together using the clip_to function where the energy low image will take over the energy full image as a collision happens
    Engine::Game.instance.clip_to(@x - @image.width / 2, @y - @image.height / 2, @energy * BarWidth, @image.height) do
      @image, @image_full = @image_full, @image #When 5 collisions happen the transparent image will be swapped with the energy full image
      super 
    end
    
    @image, @image_full = @image_full, @image #The images will be swapped again
  end
end
