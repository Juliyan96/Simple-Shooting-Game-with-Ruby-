#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)

#This module is written for the movement of the fired bullets and for the bullet collision with the aliens
class Bullet < Engine::Sprite
  Speed = 8 
  Boom = 10 
  
  
  def initialize(x, y) #These are the instance variables that are required for the bullets
    super()
    @bullet = Gosu::Sample.new("media/gun_shot.wav") 
    @image = Engine::Game.images["bullet"] 
    @x = x
    @y = y
    @z = ZOrder::Bullet #The layer of the bullets that will be seen in
    @radius = 8    
  end
  
  
  def update #This is to update the bullet on its trajectory and for collision
    @y -= Speed 
        
    collide = false #This is for the collision of the aliens with the bullet. Initially, the collision is equal to false
    Engine::Game.sprites[Alien].each do |alien| 
      if collision?(alien) 
        collide = true 
        alien.destroy! 
		@bullet.play 
        Engine::Game.game_state.increase_score!(10) # The score will be increased by 10 in the updates for the game state
      end
    end
    
    
    kill! if @y <= -@image.height / 2 or collide #the alien will be destroyed if it collides with the alien or reaches the bottom of the screen
  end
end