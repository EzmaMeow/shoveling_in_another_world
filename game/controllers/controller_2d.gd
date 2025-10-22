class_name Controller_2D extends Controller_Base

signal rotate(angle:float)

#most action will have a strengh. 0.0 is off, and anything else is on
#this allow the character to decide how to handle the state also 
#the character can store last strength to see if it was just pressed,
#released. sepreate parameters and function could work, but this may help
#with incorrect state
signal up(strength:float)
signal down(strength:float)
signal accept(strength:float)
signal cancel(strength:float)
signal sprint(strength:float)

@export var move_direction : Vector2
@export var look_direction : Vector2 
