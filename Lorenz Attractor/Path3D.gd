extends Path3D

@export var sigma : float = 10.0
@export var beta  : float = 8.0/3.0
@export var rho   : float = 28.0
var previous_point = Vector3(0.01,0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	curve.add_point(Vector3(0.01,0,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var delta_x = (sigma * (previous_point.y - previous_point.x)) * delta
	var delta_y = ((previous_point.x * (rho - previous_point.z)) - previous_point.y) * delta
	var delta_z = ((previous_point.x * previous_point.y) - (beta * previous_point.z)) * delta
	previous_point += Vector3(delta_x,delta_y,delta_z)
	curve.add_point(Vector3(delta_x,delta_y,delta_z))
