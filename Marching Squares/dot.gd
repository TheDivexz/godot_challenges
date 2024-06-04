extends MeshInstance2D

var color_val := 0.0:
	set(new_col):
		color_val = new_col
		material.set_shader_parameter("grayscale",new_col)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
