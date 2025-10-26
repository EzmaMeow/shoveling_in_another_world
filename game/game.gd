#this is meant to be an autoload that keeps certain resources in memory
#it also handle the game state such as making sure loading, new game, start
#game, and quit game works correctly
extends Node


@export var player_controller : Controller_2D = preload("uid://d2ekwkehv68ur")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("accept"):
		#get_viewport().set_input_as_handled()
		pass
	if event.is_action("cancel"):
		#get_viewport().set_input_as_handled()
		pass
	if event.is_action("up"):
		player_controller.jump.emit(event.get_action_strength("up"))
		get_viewport().set_input_as_handled()
	if event.is_action("down"):
		player_controller.crouch.emit(event.get_action_strength("down"))
		get_viewport().set_input_as_handled()
	if event.is_action("sprint"):
		player_controller.sprint.emit(event.get_action_strength("sprint"))
		get_viewport().set_input_as_handled()
		
func _physics_process(delta: float) -> void:
	var input_direction = Vector2(Input.get_axis("left","right"),Input.get_axis("forward","back"))
	player_controller.move_direction = input_direction
	#print(get_viewport().get_camera_2d().global_position)
	if (get_viewport().get_camera_2d()):
		#RenderingServer.global_shader_parameter_set("WORLD_POS_2D", get_viewport().get_camera_2d().position)
		RenderingServer.global_shader_parameter_set("world_pos_2D", get_viewport().get_camera_2d().get_screen_center_position())
		#RenderingServer.global_shader_parameter_set("world_pos_2D", get_viewport().get_camera_2d().global_position)
		#RenderingServer.global_shader_parameter_set("viewport_size", get_window().size)
		#RenderingServer.global_shader_parameter_set("world_pos_2D", get_viewport().get_visible_rect().position)
		RenderingServer.global_shader_parameter_set("viewport_size", get_viewport().get_visible_rect().size*get_viewport().get_camera_2d().zoom)
