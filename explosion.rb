

#This is the function written for the explosion as the bullet collides with the aliens, where the yellow coloured image will keep growing while becoming transparent
class Explosion < Engine::Sprite
  
  AlphaStep = 1.0 / 30
  SizeStep = 1.0 / 30
  
  #These are the instance variables required for this function
  def initialize(x, y)
    super()
    @image = Engine::Game.images["boom"]   
    @x = x
    @y = y
    @z = ZOrder::Explosion
    @blending = :additive
    @alpha = 1
    @size = rand(2) + 1
  end
  
  
  def update #This is to update the explosion to get bigger and to become more transparent
    @size += SizeStep 
    @alpha -= AlphaStep 
    
    
    kill! if @alpha <= 0 #The image will be no longer seen as the image becomes fully transparent
  end
  
end
