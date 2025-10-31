class_name Controller_2D extends Controller_Base

enum ACTION_STATE {NONE,START,ACTIVE,END,CANCELED}
enum ACTIONS {ACCEPT,CANCEL,SPRINT,UP,DOWN,ACTION_0,ACTION_1,ACTION_2}

signal rotate(angle:float)

#most action will have a strengh. 0.0 is off, and anything else is on
#this allow the character to decide how to handle the state also 
#the character can store last strength to see if it was just pressed,
#released. sepreate parameters and function could work, but this may help
#with incorrect state
signal up(strength:float,action_state: ACTION_STATE)
signal down(strength:float,action_state: ACTION_STATE)
signal accept(strength:float,action_state: ACTION_STATE)
signal cancel(strength:float,action_state: ACTION_STATE)
signal sprint(strength:float,action_state: ACTION_STATE)
#not all actions will have a dedicated signal
#some may be abstract and dependent on the character
#like primary and secondary actions or number key assign actions
signal action(strength:float,action_state: ACTION_STATE,id:int)

@export var move_direction : Vector2
@export var look_direction : Vector2 

@export var active_actions : ACTIONS
