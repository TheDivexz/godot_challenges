extends Node2D

var relative_segment_array = [Vector2(0,0)]
var absolute_segment_array = [Vector2(0,0)]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_segment(momentum: Vector2):
	var new_segment = MeshInstance2D.new()
	new_segment.mesh = BoxMesh.new()
	new_segment.scale = Vector2(20,20)
	relative_segment_array.push_back(relative_segment_array[-1] - momentum)
	new_segment.position = relative_segment_array[-1] * 20
	absolute_segment_array.push_back(absolute_segment_array[-1] - (momentum * 20))
	add_child(new_segment,true)

func update_segments(grid_position: Vector2):
	# If snake at border, don't move
	if absolute_segment_array[0] == grid_position:
		return
	# snake segment takes up the spot where the one after it was previously
	absolute_segment_array.push_front(grid_position)
	absolute_segment_array.pop_back()
	# Remakes the relative array
	relative_segment_array = []
	for segment in absolute_segment_array:
		relative_segment_array.push_back((segment - grid_position)/20)
		
	var index = 0
	for child in get_children():
		child.position = relative_segment_array[index] * 20
		index += 1
	reset_game()
	
# Checks if the snake is dead and the board needs to be reset
func reset_game():
	if relative_segment_array.count(relative_segment_array[0]) <= 1:
		return
	# Kills all Children
	for child in get_children():
		remove_child(child)
	
	relative_segment_array = [Vector2(0,0)]
	absolute_segment_array = [Vector2(0,0)]
	
	var new_segment = MeshInstance2D.new()
	new_segment.mesh = BoxMesh.new()
	new_segment.scale = Vector2(20,20)
	new_segment.position = Vector2(0,0)
	add_child(new_segment,true)
