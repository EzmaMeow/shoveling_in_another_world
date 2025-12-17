extends Character_2D
#note: areas can have a few collsion shape, so they could be turn on or off maybe
#but also could the character direction andstate to filter it as well.less nodes 
#that way. could merge sweep and direct area in that case

func on_accept(strength:float, action_state: Controller_2D.ACTION_STATE):
	#need another area for this since it likly to use a diffrent collsion profile
	#also shapes could be swap out, but it may be better to use one
	#action2(aka 3) and above may be dynamic so their shapes may be swap out
	#if they do not create a projectile
	pass

func on_action(strength:float,action_state: Controller_2D.ACTION_STATE,id:int):
	if (strength > 0.0):
		if (!(controller.active_actions & 1 << id)):
			controller.active_actions |= 1 << id
		#may need to check the action state to enable
		#or disable this. also may need to block some input states
		#in case only one can run at a time. but this may be better
		#as a diffrent state or handle with some kind of action handler
		if (id == Controller_2D.ACTIONS.ACTION_0 && %FrontShape2D.disabled):
			%FrontShape2D.disabled = false
		if (id == Controller_2D.ACTIONS.ACTION_1 && %SweepShape2D.disabled):
			%SweepShape2D.disabled = false
		%DirectArea.monitoring = true
	else:
		if (controller.active_actions & 1 << id):
			controller.active_actions ^= 1 << id
		if (id == Controller_2D.ACTIONS.ACTION_0):
			%FrontShape2D.disabled = true
		if (id == Controller_2D.ACTIONS.ACTION_1):
			%SweepShape2D.disabled = true
		%DirectArea.monitoring = false

func _on_direct_area_body_entered(body: Node2D) -> void:
	print_debug('hit: ',body)
	if (body == self):
		#seems it takes the main node, but may not work well if 
		#deeply nested.if for some reason that is needed, adding
		#a filter or using collsion layer/masks would be ideal
		print_debug('is owner. ')
		
func _process(delta: float) -> void:
	#note: the axis seem to need to be flip and or something. rotating 2d is risky, 
	#but since this is an area, it may always be centered around the point it rotates
	%DirectArea.look_at(global_position+Vector2(-controller.look_direction.y,controller.look_direction.x))
	if (velocity != Vector2.ZERO):
		#could use the controller look_direction or something, but most times the 
		#render facing is in the direction of travel. Can change it to other facing
		#if not moving.
		if (velocity.x > 0.0):
			if(%AnimatedSprite2D.animation != "walk_right"):
				%AnimatedSprite2D.frame = 1
				%AnimatedSprite2D.play('walk_right')
		elif (velocity.x < 0.0):
			if(%AnimatedSprite2D.animation != "walk_left"):
				%AnimatedSprite2D.frame = 1
				%AnimatedSprite2D.play('walk_left')
		elif (velocity.y > 0.0):
			if(%AnimatedSprite2D.animation != "walk_front"):
				%AnimatedSprite2D.frame = 1
				%AnimatedSprite2D.play('walk_front')
		elif (velocity.y < 0.0):
			if(%AnimatedSprite2D.animation != "walk_back"):
				%AnimatedSprite2D.frame = 1
				%AnimatedSprite2D.play('walk_back')
		if (!%AnimatedSprite2D.is_playing()):
			%AnimatedSprite2D.frame = 1
			%AnimatedSprite2D.play()
		
	else:
		%AnimatedSprite2D.frame = 0
		%AnimatedSprite2D.pause()
