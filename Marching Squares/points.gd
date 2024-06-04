extends Node

var dot := preload("res://dot.tscn")
@export var density := 10
var ordered_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	print("point started")
	randomize()
	var spacing := 1000.0 / density
	for y in density:
		for x in density:
			var colorize = randf_range(0,1)
			var new_dot : MeshInstance2D = dot.instantiate()
			new_dot.position = Vector2((spacing * x) + 4, (spacing * y) + 4)
			new_dot.color_val = colorize
			add_child(new_dot)
			ordered_list.append(new_dot)
	print("point finished")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func remove_all():
	for child in get_children():
		remove_child(child)
