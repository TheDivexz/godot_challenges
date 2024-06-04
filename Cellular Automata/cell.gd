extends MeshInstance2D

@export var isWall : bool = false:
	set(value):
		isWall = value
		if value:
			material.set_shader_parameter("colorval",0.0)
		else:
			material.set_shader_parameter("colorval",1.0)
@export var threshold = 0.6
# Called when the node enters the scene tree for the first time.
func _ready():
	var randfloat = randf()
	isWall = (randfloat < threshold)
