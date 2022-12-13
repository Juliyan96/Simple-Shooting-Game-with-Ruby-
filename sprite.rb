

module Engine
  
  # Sprite objects are the different moving elements of the game. For example, a 
  # space ship, an enemy, a bullet, etc.
  #
  # Custom sprite classes should inherit from this one.
  class Sprite

    attr_reader :x, :y, :z, :image, :blend_mode, :alpha, :angle, :radius, :size

    #These are the instance variables that are created for the sprite class in this module
    def initialize
      @x = 0
      @y = 0
      @z = 0
      @image = nil
      @blending = :default
      @alpha = 1.0
      @angle = 0
      @index = 0
      @radius = 0
      @size = 1.0     
      @die = false 
      Game.sprite_collection.add(self) #this will add the new sprites to the sprite collection   
    end

    #This function is written to update the sprites
    def update
    end
    
    
    def draw #This function is to draw the sprites on the game window
      if @image.class == Array
        img = @image[@index] #This is to draw the animation for the aliens
		
      else
        img = @image #If the images are not animated they will be drawn just as images on the game window
      end
	  
      img.draw_rot(@x, @y, @z, @angle, 0.5, 0.5, @size, @size, alpha_to_color(@alpha), @blending)
    end
    
    
    def kill! #This function is to remove the sprite from the game window if the sprite (i.e: Alien) is killed
      @die = true
    end
    
    #This function is written to check if the sprite is killed or not
    def die?
      @die
    end
    
    #This function is written to check if there is a collision between the sprites (i.e: bullet and the alien/ alien and the ship)
    def collision?(other)
      Gosu::distance(@x, @y, other.x, other.y) < @radius * @size + other.radius * other.size
    end
    
    protected
    
    #This is to create the white colour in Gosu as a new colour
    def alpha_to_color(alpha)
      Gosu::Color.new((alpha * 0xff).to_i, 255, 255, 255)
    end

  end
end
