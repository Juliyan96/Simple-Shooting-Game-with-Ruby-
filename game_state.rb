#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)


module Engine
  #This is the gamestate class which will allow the game to be updated each time the user chooses to press a button
  class GameState
    
    
    def initialize
      raise 
    end
    
    #This will update all game components belonging to this gamestate
    def update
    end
    
    #This will draw all game sprites and backgrounds that belong to this state
    def draw
      raise 
    end
    
    #This function will get called if the user releases a button
    def button_up(id)
    end
    
    #This function will get called if the user presses a button
    def button_down(id)
    end
  end
end