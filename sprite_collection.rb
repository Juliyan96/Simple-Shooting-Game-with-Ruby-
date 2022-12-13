

module Engine

  #This is the sprite collection class. This module allows the sprites to be listed into an array to be accessed in other modules
  class SpriteCollection
    
    attr_reader :sprites

    #The instance variable for this class are the sprite images which is the hashmap of the images
    def initialize
      @sprites = Hash.new
    end

    
    def add(obj) #This function is to add new sprites into the existing sprite collection
      init_list(obj.class) unless @sprites[obj.class]
      @sprites[obj.class].push(obj)
    end
    
    
    def remove(obj) #This function is to remove sprites from the sprite collection
      @sprites[obj.class].delete(obj) if @sprites[obj.class]
    end
    
    
    def init_list(class_name) #This function is to intialize the sprite collection in the hash map in specific order
      @sprites[class_name] = Array.new
    end
    
    
    def update #This function will update all the sprites in the sprite collection during gameplay
      @sprites.each_value do |list|
        list.each {|x| x.update}
        list.reject!{|x| x.die?} #This will delete the sprites which have already collided
      end
    end
    
    
    def draw #This function is to draw all the sprites in the sprite collection
      @sprites.each_value do |list|
        list.each {|x| x.draw}
      end
    end
  end
end
