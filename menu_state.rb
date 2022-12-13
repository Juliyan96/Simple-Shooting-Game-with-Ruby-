
#This is the menu class. this module is written to display the options available for the user to either choose new game, about or quit
module Engine
  
  class MenuState < GameState    
    TextX = Game::ScreenWidth / 2
    TextY = (2 * Game::ScreenHeight) / 3
    TextGap = 50
    
    #These are the instance variables for the menu state of the game
    def initialize
      @img_background = Game::images["background"]
      @img_logo = Game::images["logo"]
      @font = Game::fonts["menu"]
      @click = Gosu::Sample.new("media/click.wav")	  
      @options = ["New Game", "About", "Quit"] #The array of options that are present in the menu state
      @selected = 0
    end
    
    #This function will update all components of the menu state of the game
    def update
    end
    
	
    
    def draw #This function will draw all the images required for the menu state
      @img_background.draw(0, 0, 0)
      @img_logo.draw_rot(Game::ScreenWidth / 2, 120, ZOrder::Hud, 0)
      @options.size.times do |i| 
        color = option_selected?(i) ?  0xffff0000 : 0xfff4cc00 #The colour when the user is in the option will turn from yellow to red
        @font.draw_rel(@options[i], TextX, TextY + i * TextGap, ZOrder::Hud, 0.5, 0.5, 1, 1, color) 
      end
    end
    
	
	
    #This function is when the user presses ESC which will quit the game 
    def button_down(id)
      case id
      when Gosu::KbEscape then Game.quit
      end
    end
    
    #This function is for the user to hover between options and also will play the click sound on the game 
    def button_up(id)
      case id
      when Gosu::KbDown then next_option! && @click.play
      when Gosu::KbUp then prev_option! && @click.play
      when Gosu::KbReturn, Gosu::KbSpace then select_option && @click.play
      end
    end
    
    #This function will check the tagged option
    def option_selected?(i)
      @selected == i
    end
    
    #This function will tage the next option for the user 
    def next_option!
      @selected = (@selected + 1) % @options.size
    end
    
    #This function will tage the previous option selected by the user
    def prev_option!
      @selected = (@selected - 1) % @options.size
    end
    
    # This function will allow the user to get into the state that will be highlighted in red
    def select_option
      case @options[@selected]
      when "New Game" then Game.game_state = PlayState 
      when "About" then Game.game_state = AboutState 
      when "Quit" then Game.quit 
      end
    end 
  end
  
end
