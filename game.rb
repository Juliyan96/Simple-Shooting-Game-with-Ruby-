#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)


require 'singleton' #Singleton module is required in otder to create the hashmaps

module Engine
  class Game < Gosu::Window
    include Singleton
    #The size of the game window and the fading time between gamestates are assigned here    
    ScreenWidth = 550
    ScreenHeight = 600
    FadingTime = 1000

    def initialize #These are the instance variables for the main game window and the hashmap variables to store the fonts and the images of the game     
      super(ScreenWidth, ScreenHeight, false)
      self.caption = "Space Fight by Juliyan Gunasinghe"
      @@sprite_collection = SpriteCollection.new
      @@images = Hash.new #This is to load the hashmap for the images
      @@fonts = Hash.new  #This is to load the hasmap for fonts   
      load_images
      load_fonts
      @@img_fade = @@images["black"]
      @@fading_off = false
      @@fading_on = false
      @@end_fade = 0
      @@start_fade = 0     
      @@change_game_state = nil
      @@game_state = MenuState.new
    end

    

    #This will return the hashmap list of the images
    def Game.images
      @@images
    end
    
    #This will return the hashmap list for the 3 fonts used in this game
    def Game.fonts
      @@fonts
    end
    
    #This is to return the hashmap list of the sprites only in this game
    def Game.sprites
      @@sprite_collection.sprites
    end
    
    # This function will return the sprite collection
    def Game.sprite_collection
      @@sprite_collection
    end
    
    #This function will return the game state which the user is currently in
    def Game.game_state
      @@game_state
    end
    
    #This function is to switch between game states with a fade off of the background image
    def Game.game_state=(st)
      @@change_game_state = st.new
      Game.fade_off(FadingTime)
    end
    
    #This function is to quit the game
    def Game.quit
      self.instance.close
    end
    
    #This function is for the fading off of the game which is required for the fading off 
    def Game.fade_off(time)
      return if Game.fading?
      @@start_fade = Gosu::milliseconds
      @@end_fade = @@start_fade + time
      @@fading_off = true
    end
    
    #This function is for the fading in towards the game to change between different game states
    def Game.fade_on(time)
      return if Game.fading?
      @@start_fade = Gosu::milliseconds
      @@end_fade = @@start_fade + time
      @@fading_on = true
    end
    
    #This will return whether the fade is running or not
    def Game.fading?
      @@fading_off or @@fading_on
    end
    
    #This function will end the fade transitions
    def Game.end_fade!
      @@fading_off = false
      @@fading_on = false
    end

    # Unless the game is fading, the game will update 
    def update
      @@game_state.update unless Game.fading?      
      Game.end_fade! if Gosu::milliseconds >= @@end_fade and Game.fading?
      
      #This will update the changes between the game states with the fade coming in with the fade_on function 
      if @@change_game_state and not Game.fading?
        @@game_state = @@change_game_state
        @@change_game_state = nil
        Game.fade_on(FadingTime)
      end
    end

    # This function will draw all the game components on the game window
    def draw
      @@game_state.draw

      if Game.fading?
        delta = (Gosu::milliseconds - @@start_fade).to_f / (@@end_fade - @@start_fade)
        alpha = @@fading_off ? delta : 1 - delta
        @@img_fade.draw(0, 0, ZOrder::Fade, 1, 1, Gosu::Color.new((alpha * 0xff).to_i, 0xff, 0xff, 0xff))
      end
    end

    # To call if the user chooses to release the ESC, ENTER or SPACE
    def button_up(id)
      @@game_state.button_up(id)
    end

    # To call if the user chooses to press the ESC, ENTER or SPACE
    def button_down(id)
      @@game_state.button_down(id)
    end

    # This function consists of the images that will be loaded into the hashmap 
    def load_images
      @@images["black"] = Gosu::Image.new(self, "media/black.png", true)
      @@images["background"] = Gosu::Image.new(self, "media/background.png", true)
      @@images["ship"] = Gosu::Image.new(self, "media/ship.png", false)
      @@images["bullet"] = Gosu::Image.new(self, "media/bullet.png", false)
      @@images["aliens"] = Gosu::Image.load_tiles(self, "media/aliens.png", 48, 42, false)	  
      @@images["energy full"] = Gosu::Image.new(self, "media/energy_full.png", false)
      @@images["energy low"] = Gosu::Image.new(self, "media/energy_low.png", false)
      @@images["hud"] = Gosu::Image.new(self, "media/hud.png", false)
      @@images["boom"] = Gosu::Image.new(self, "media/boom.png", false)
      @@images["gameover"] = Gosu::Image.new(self, "media/game_over.png", false)
      @@images["logo"] = Gosu::Image.new(self, "media/game_logo.png", false)
      @@images["about"] = Gosu::Image.new(self, "media/about.png", false)
    end
    
    # These are the fonts that will be loaded into the @@fonts hashmap
    def load_fonts
      @@fonts["menu"] = Gosu::Font.new(self, "Courier", 50)
      @@fonts["score"] = Gosu::Font.new(self, "Courier", 50)
      @@fonts["small"] = Gosu::Font.new(self, "Courier", 30)
    end

  end

end