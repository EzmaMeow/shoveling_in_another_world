#this is meant to be an autoload that keeps certain resources in memory
#it also handle the game state such as making sure loading, new game, start
#game, and quit game works correctly
extends Node


@export var player_controller : Controller_2D = preload("uid://d2ekwkehv68ur")


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): 
		return
	if event.is_action("accept"):
		#get_viewport().set_input_as_handled()
		pass
	if event.is_action("cancel"):
		#get_viewport().set_input_as_handled()
		pass
	if event.is_action("up"):
		player_controller.up.emit(event.get_action_strength("up"))
		get_viewport().set_input_as_handled()
	if event.is_action("down"):
		player_controller.down.emit(event.get_action_strength("down"))
		get_viewport().set_input_as_handled()
	if event.is_action("sprint"):
		player_controller.sprint.emit(event.get_action_strength("sprint"))
		get_viewport().set_input_as_handled()
		
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
