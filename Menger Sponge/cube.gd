extends Node3D

@export var current_scale : float = 2.0

func split_up_boxes():
	var boxes : Array[Node] = get_children()
	for box in boxes:
		for z in range(-1,2):
			for y in range(-1,2):
				for x in range(-1,2):
					# Punches out the middle
					if ((z == 0) and ((z == x) or (z == y))) or ((x == 0) and ((x == z) or (x == y))) or ((y == 0) and ((y == x) or (y == z))):
						continue
					var new_box = MeshInstance3D.new()
					new_box.mesh = BoxMesh.new()
					var scaling = box.scale.x/3.0
					new_box.scale = Vector3(scaling,scaling,scaling)
					new_box.position = Vector3(((x+1)*scaling) + box.position.x,((y+1)*scaling) + box.position.y,((z+1)*scaling) + box.position.z)
					add_child(new_box,true)
		remove_child(box)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		split_up_boxes()
