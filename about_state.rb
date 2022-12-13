

#This state of the game is the about state which features the Name

module Engine #Requires the engine module to access the hashmap of images and fonts
  
  class AboutState < GameState
    
    def initialize #These are the instance variables created for this module.
      @img_background = Game.images["background"]
      @img_about = Game.images["about"]
      @font_small = Game.fonts["small"]
      @font_about = Game.fonts["small"]
    end

    
    def draw #This will display the below mentioned texts along with the about.png image on the game window
      @img_background.draw(0, 0, 0)
      @img_about.draw_rot(Game::ScreenWidth / 2, 120, ZOrder::Hud, 0)

      @font_small.draw_rel("Made by", Game::ScreenWidth / 2, 200, ZOrder::Hud, 0.5, 0.5)
      @font_about.draw_rel("Juliyan Gunasinghe", Game::ScreenWidth / 2, 250, ZOrder::Hud, 0.5, 0.5)
      
      
    end

    
    def button_up(id) #This will return to the main menu if the user press down the ESC,ENTER or the SPACE bar
      
      Game.game_state = MenuState if id == Gosu::KbEscape or id == Gosu::KbReturn or Gosu::KbSpace
    end
  end
end
