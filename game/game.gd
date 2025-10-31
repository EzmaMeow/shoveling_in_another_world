#this is meant to be an autoload that keeps certain resources in memory
#it also handle the game state such as making sure loading, new game, start
#game, and quit game works correctly
extends Node


@export var player_controller : Controller_2D = preload("uid://d2ekwkehv68ur")


func _unhandled_input(event: InputEvent) -> void:
	#Note: could handle all input that call a signal that
	#may block that input, but might need a way
	#to respond back. could have a object pass as a parameter
	#or have one on the controller. the latter may
	#be a risk so parameter be better
	#maybe the character can set it handled
	#without knowing what, but that would assume the character knows
	#it is an input. truth is if most game input is handle in one place,
	#then setting it handled is not nessary
	var action_state : Controller_2D.ACTION_STATE
	if Engine.is_editor_hint(): 
		return
	if (event.is_pressed()):
		action_state = Controller_2D.ACTION_STATE.START
	elif (event.is_released()):
		action_state = Controller_2D.ACTION_STATE.END
		
	if event.is_action("accept"):
		player_controller.accept.emit(event.get_action_strength("accept"),action_state)
		#get_viewport().set_input_as_handled()
		pass
	if event.is_action("cancel"):
		player_controller.cancel.emit(event.get_action_strength("cancel"),action_state)
		#get_viewport().set_input_as_handled()
		pass
	if event.is_action("up"):
		player_controller.up.emit(event.get_action_strength("up"),action_state)
		get_viewport().set_input_as_handled()
	if event.is_action("down"):
		player_controller.down.emit(event.get_action_strength("down"),action_state)
		get_viewport().set_input_as_handled()
	if event.is_action("sprint"):
		player_controller.sprint.emit(event.get_action_strength("sprint"),action_state)
		get_viewport().set_input_as_handled()
	if event.is_action("action0"):
		player_controller.action.emit(
			event.get_action_strength("action0"), action_state,
			Controller_2D.ACTIONS.ACTION_0
		)
		#get_viewport().set_input_as_handled()
	if event.is_action("action1"):
		player_controller.action.emit(
			event.get_action_strength("action1"), action_state,
			Controller_2D.ACTIONS.ACTION_1
		)
		#get_viewport().set_input_as_handled()
	if event.is_action("action2"):
		player_controller.action.emit(
			event.get_action_strength("action2"), action_state,
			Controller_2D.ACTIONS.ACTION_2
		)
		#get_viewport().set_input_as_handled()
		
func update_globals():
	if (get_viewport().get_camera_2d()):
		RenderingServer.global_shader_parameter_set("world_pos_2D", get_viewport().get_camera_2d().get_screen_center_position())
		
func _physics_process(delta: float) -> void:
	update_globals()
	if Engine.is_editor_hint(): 
		return
	var input_direction = Vector2(Input.get_axis("left","right"),Input.get_axis("forward","back"))
	player_controller.move_direction = input_direction
	#print(get_viewport().get_camera_2d().global_position)
