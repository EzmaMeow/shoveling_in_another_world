class_name Character_2D extends CharacterBody2D


@export var controller: Controller_2D :
	set(value):
		if (controller == value):
			return
		disconnect_controller(controller)
		connect_controller(value)
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

#look in the direction of movement
@export var face_movement_direction : bool
		
var jump_force : float = 0.0

var sprint : float = 1.0

func connect_controller(new_controller:Controller_2D):
	if (new_controller):
		new_controller.client_message_received.connect(on_message_received)
		new_controller.rotate.connect(on_rotate)
		new_controller.up.connect(on_jump)
		new_controller.sprint.connect(on_sprint)
		new_controller.down.connect(on_crouch)
		new_controller.accept.connect(on_accept)
		new_controller.cancel.connect(on_cancel)
		new_controller.action.connect(on_action)
		
func disconnect_controller(old_controller:Controller_2D):
	if (old_controller):
		old_controller.client_message_received.connect(on_message_received)
		old_controller.rotate.disconnect(on_rotate)
		old_controller.up.disconnect(on_jump)
		old_controller.sprint.disconnect(on_sprint)
		old_controller.down.disconnect(on_crouch)
		old_controller.accept.disconnect(on_accept)
		old_controller.cancel.disconnect(on_cancel)
		old_controller.action.connect(on_action)

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
func on_accept(strength:float,action_state: Controller_2D.ACTION_STATE):
	pass
	
func on_cancel(strength:float,action_state: Controller_2D.ACTION_STATE):
	pass

func on_rotate(angle:float,action_state: Controller_2D.ACTION_STATE):
	pass

func on_jump(strength:float,action_state: Controller_2D.ACTION_STATE):
	#print_debug('jumped',strength)
	pass
	
func on_crouch(strength:float,action_state: Controller_2D.ACTION_STATE):
	#print_debug('crouch',strength)
	pass
	
func on_sprint(strength:float,action_state: Controller_2D.ACTION_STATE):
	movement.speed_modifier = strength + 1
	#print_debug('sprint',strength)
	pass
	
func on_action(strength:float,action_state: Controller_2D.ACTION_STATE, id:int ):
	print(id)
	
func _physics_process(_delta: float) -> void:
	if (controller):
		if (movement):
			velocity = movement.caculate_velocity2D(
				velocity,position,_delta,controller.move_direction,state,get_last_slide_collision()
				)
			if(face_movement_direction && velocity != Vector2.ZERO):
				controller.look_direction = velocity.normalized()
			move_and_slide()
				
