#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)


#This is the playstate class. This module contains the ingame functions when the player had chosen the new game option in the menu state
module Engine
  class PlayState < GameState
    attr_reader :energy, :score
    
    MaxEnergy = 5 #The maximum energy assigned is 5. If the ship collides 5 times with aliens the game will be over
    
    #These are the instance variables that are created for this module
    def initialize
      @game_over = false 
      [Alien, Bullet, EnergyBar, Explosion, Hud, Ship].each {|x| Game.sprite_collection.init_list(x)} 
	  @game_done = Gosu::Song.new ("media/game_over.wav") 
      @captain = Ship.new
      @img_background = Game.images["background"]
      @font_score = Game.fonts["score"] 
      Hud.new 
      EnergyBar.new 
      @score = 0 #Initial score is set at 0
      @energy = MaxEnergy       
    end
    
    
    def draw #This is to draw all game imgaes including the sprites and the background and other images
      @img_background.draw(0, 0, 0)
      @img_game_over.draw_rot(Game::ScreenWidth/2, Game::ScreenHeight/3, ZOrder::Hud, 0) if game_over? #If the game is over it will draw the game over image
      @font_score.draw_rel(@score.to_s, Game::ScreenWidth - 20, Game::ScreenHeight - 5, ZOrder::Hud + 1, 1.0, 1.0) #This will draw the score at the bottom of the screen
      Game.sprite_collection.draw #This will draw all the sprites on the screen accessed through the sprite_collection module
    end
    
    
    def update #This will update the images and sounds of the play state
      process_input
      Alien.new if rand(100) < 10 #If the number of aliens in the game window are less than 10 it will draw more aliens
      Game.sprite_collection.update #This will update all sprites of the game
    end
    
    
    def button_up(id)
      case id
      when Gosu::KbSpace then @captain.shoot if not game_over? #If the game is not over the ship will keep shooting bullets
      when Gosu::KbEscape then Game.game_state = MenuState #If ESC is pressed the game will return to the menu state
      when Gosu::KbReturn then Game.game_state = MenuState if game_over? #When the game finishes the ENTER key will return the game into the menu state
      end
    end
    
    
    def process_input #This is the function to move the ship left and right if the game is not over 
      @captain.move(-Ship::Speed) if Game.instance.button_down?(Gosu::KbLeft) and not game_over?
      @captain.move(Ship::Speed) if Game.instance.button_down?(Gosu::KbRight) and not game_over?
    end
    
    
    def start_game_over #This function will show the game over image when the game finishes and play the game ove soundtrack
      @img_game_over = Game.images["gameover"]
      @game_over = true
	  @game_done.play
    end
    
    #This function will return whether the game is over or not
    def game_over?	  
      @game_over
    end
    
    #This function is when the bullet collides with the alien, 10 is added to the score
    def increase_score!(x)
      @score += x
    end
    
    #When energy reaches 0 the game will be over
    def decrease_energy
      @energy -= 1
      if @energy <= 0
        Game.sprites[Ship].first.destroy! unless Engine::Game.sprites[Ship].empty?
        Game.game_state.start_game_over
      end
    end
  end
end