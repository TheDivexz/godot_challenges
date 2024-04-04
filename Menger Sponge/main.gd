extends Node3D

@export var rotation_speed : float = 0.01
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	$Cube.rotate_x(rotation_speed)
	$Cube.rotate_y(rotation_speed)
	$Cube.rotate_z(rotation_speed)
	pass
