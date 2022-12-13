#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)

#This module is written for the aliens 
class Alien < Engine::Sprite 
  MaxSpeedX = 5 
  MaxSpeedY = 6 
  MinSpeedY = 4 
  Animation = 100 #The animation time for the aliens between the two columns of the image using milliseconds
  Boom = 10 #To kill the alien with the explosion
  
  
  def initialize
    super
    #These are the instance variables required for this module
    @image = Engine::Game.images["aliens"]
    @x = rand(Engine::Game::ScreenWidth)
    @y = -@image[0].height / 2    
    @z = ZOrder::Alien
    @radius = 20
    
    #These are the random assignment of the speed between the minimum and maximum assigned values for the aliens to randomly move
    @speedx = rand(MaxSpeedX * 2) - MaxSpeedX
    @speedy = rand(MaxSpeedY - MinSpeedY) + MinSpeedY
  end
  
  #This will keep updating the movement of the aliens
  def update
    
    @x += @speedx
    @y += @speedy
	
    
    #The aliens will be destroyed once they reach towards the bottom of the game window
    kill! if @y > Engine::Game::ScreenHeight + @image[0].height / 2
    
    #This is to animate the aliens using milliseconds in GOSU taking into consideration the animation time parameter
    @index = Gosu::milliseconds / Animation % @image.size
	
	
  end
  
  # This will destroy the alien with the explosion using the boom parameter
  def destroy!
    (rand(3) + 5).times { Explosion.new(@x + rand(Boom * 2) - Boom, @y + rand(Boom * 2) - Boom) } 
    kill!
  end
  
end