@tool
class_name Playable_Area_2d extends Node2D
enum BORDERS { NORTH = 1, SOUTH = 2, EAST = 4, WEST = 8 }
##Emited when a physics body enter the area bounds
#signal body_entered(body:Node2D)
##Emited when a physics body exit the area bounds
#signal body_exit(body:Node2D)
##Emited when a the area size changed. Will only be called if there a change.
signal size_changed(size:Vector2)

@export var size: Vector2 = Vector2(640,640):
	set(value):
		if (size == value):
			return
		size = value
		update_size()
		size_changed.emit(size)

@export_group('Backgroud')

@export var show_background : bool = true :
	set(value):
		show_background = value
		%Background.visible = show_background
		
@export var background_scale : Vector2 = Vector2(1.0,1.0):
	set(value):
		if (size == value):
			return
		background_scale = value
		update_size()
		#There not need to emit the signal here
		#since this is more for show
		
@export var background_texture : Texture2D :
	set(value):
		if (background_texture == value):
			return
		background_texture = value
		%Background.texture = background_texture

##The material the background will use
##Note: only can take canvas item or shader materials.
@export var background_material : Material  :
	set(value):
		if (background_material == value):
			return
		background_material = value
		%Background.material = background_material
		
@export_group('Borders')

@export_flags('north','south','east','west') var open_borders : int = 1 :
	set(value):
		if (open_borders == value):
			return
		open_borders = value
		update_borders()
		
@export_group('Bounds')
@export_flags_2d_physics var borders_collsion_layer : int = 1 :
	set(value):
		borders_collsion_layer = value
		%Borders.collision_layer = borders_collsion_layer

@export_flags_2d_physics var borders_collsion_mask : int :
	set(value):
		borders_collsion_mask = value
		%Borders.collision_mask = borders_collsion_mask

		
func update_borders():
	if (get_child_count()==0):
		return
	%NorthBorder.disabled = open_borders & BORDERS.NORTH
	%SouthBorder.disabled = open_borders & BORDERS.SOUTH
	%EastBorder.disabled = open_borders & BORDERS.EAST
	%WestBorder.disabled = open_borders & BORDERS.WEST
	
func update_size():
	if (get_child_count()==0):
		return
	%Background.position = -size * background_scale
	%Background.size = size*2 * background_scale
	
	%BoundsShape.shape.size = size*2
	
	%SouthBorder.position.y = size.y
	%EastBorder.position.x = size.x
	%WestBorder.position.x = -size.x
	%NorthBorder.position.y = -size.y
	
	
func _ready() -> void:
	update_size()
	update_borders()


#func _on_body_entered(body: Node2D) -> void:
#	body_entered.emit(body)


#func _on_body_exited(body: Node2D) -> void:
#	body_entered.emit(body)
