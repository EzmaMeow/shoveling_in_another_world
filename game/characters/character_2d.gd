class_name Character_2D extends CharacterBody2D


@export var controller: Controller_2D :
	set(value):
		if (value):
			value.client_message_received.connect(on_message_received)
			value.rotate.connect(on_rotate)
			value.up.connect(on_jump)
			value.sprint.connect(on_sprint)
			value.down.connect(on_crouch)
		elif (controller):
			controller.client_message_received.disconnect(on_message_received)
			controller.rotate.connect(on_rotate)
			controller.up.connect(on_jump)
			controller.sprint.connect(on_sprint)
			controller.down.connect(on_crouch)
		controller = value

@export var state : Character_State = Character_State.new():
	set(value):
		if (value):
			if (value.unique):
				state = value.duplicate()
				return
		state = value
@export var movement : Character_Movement = Character_Movement.new()

@export var camera : Camera2D
		
var jump_force : float = 0.0

var sprint : float = 1.0

func on_message_received(message:Variant):
	if (message == 'exiting' and camera):
		camera.enabled = false
	elif (message == 'entering' and camera):
		camera.enabled = true
		#if message.has('Jump') :#and is_on_floor():
			#jump_force = 10.0
	#		var input_direction : Vector2 = message['direction']
	#		#move_direction = Vector3(input_direction.x, input_direction.y,0.0)
	#		move_direction = Vector3(input_direction.y,0.0,-input_direction.x)


func on_rotate(angle:float):
	pass

func on_jump(strength:float=1.0):
	#print_debug('jumped',strength)
	pass
	
func on_crouch(strength:float=1.0):
	#print_debug('crouch',strength)
	pass
	
func on_sprint(strength:float=1.0):
	movement.speed_modifier = strength + 1
	#print_debug('sprint',strength)
	pass
	
func _physics_process(_delta: float) -> void:
	if (controller):
		if (movement):
			velocity = movement.caculate_velocity2D(
				velocity,position,_delta,controller.move_direction,state,get_last_slide_collision()
				)
			move_and_slide()
				
