#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)


#This is the class for the ship. This module will allow the ship to shoot bullets
class Ship < Engine::Sprite
  Speed = 6 #The speed is assigned at 6 for the ship to move horizontally
  Boom = 10
  
  attr_reader :energy
  
  #These are the instance variables for this class
  def initialize
    super 
    @x = Engine::Game::ScreenWidth / 2
    @y = Engine::Game::ScreenHeight - 100
    @z = ZOrder::Ship #This is the layer of the game which the ship will appear
    @image = Engine::Game.images["ship"]
    @radius = 30
	@collision_wav = Gosu::Sample.new("media/collision.wav") #This soundtrack will be added when the aliens collide with the ship
  end
  
  
  def update #This is to update the position of the ship and the firing of the bullets
    Engine::Game.sprites[Alien].each do |alien|
      if collision?(alien) 
        alien.destroy! 
		@collision_wav.play 
        Engine::Game.game_state.decrease_energy #The energy will be reduced by 1
		
      end
    end
  end
  
  #This function is written to move the ship horizontally
  def move(incx)
    @x += incx
    @x = [@x, @image.width / 2].max #This will make sure that the ship stays within the game window
    @x = [@x, Engine::Game::ScreenWidth - @image.width / 2].min #This will make sure that the ship stays within the game window
  end
  
  
  def shoot #This function is to shoot bullets
    Bullet.new(@x, @y - @image.height / 2)
  end
  
  
  def destroy! #This function is to destroy the ship when the ship collides with the alien 5 times
    (rand(3) + 5).times { Explosion.new(@x + rand(Boom * 2) - Boom, @y + rand(Boom * 2) - Boom) }
    kill!
  end
end