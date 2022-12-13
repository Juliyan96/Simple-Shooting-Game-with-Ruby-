#Kavinda Kashi Juliyan Gunasinghe
#Student ID: 101222630
#Custom Program (COS10009)


#This is the file to be executed in order to play the game
require 'rubygems'
require 'gosu'

#I have used the required_relative as all modules are related to each other


require_relative 'engine' 
require_relative 'zorder'
require_relative 'aliens'
require_relative 'bullet'
require_relative 'energy_bar'
require_relative 'explosion'
require_relative 'hud'
require_relative 'ship'


game = Engine::Game.instance
game.show