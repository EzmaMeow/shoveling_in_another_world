#contains ways to caculate velocity
#base class only move in the provided direction scaled
#to the state base_speed if vaild
class_name Character_Movement extends Resource

#this can have varibles
@export var base_speed : float = 0.0
@export var speed_modifier : float = 1.0



func caculate_velocity3D(
		velocity:Vector3, position:Vector3, delta:float, direction:Vector3 = Vector3(), 
		state:Character_State = null, collision:KinematicCollision3D = null, 
		data:Dictionary = {}
	) -> Vector3:
		if (state):
			return direction * (base_speed+state.speed) * speed_modifier
		return direction * base_speed * speed_modifier
		
func caculate_velocity2D(
		velocity:Vector2, position:Vector2, delta:float, direction:Vector2 = Vector2(),
		state:Character_State = null, collision:KinematicCollision2D = null, 
		data:Dictionary = {}
	)-> Vector2:
		if (state):
			return direction * (base_speed+state.speed) * speed_modifier
		return direction * (base_speed) * speed_modifier
