extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$pathing.rotate_x(0.001)
	$pathing.rotate_y(0.001)
	$pathing.rotate_z(0.001)
	pass
