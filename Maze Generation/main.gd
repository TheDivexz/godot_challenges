extends Node2D

@export var grid_size = 20
var Cell = preload("res://Cell.tscn")
var cell_array : Array[Node] = []
var cell_stack = []
var frame_rate = 0
var prev_cell = null
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var random = RandomNumberGenerator.new()
	# Creates a grid
	for i in range(grid_size):
		for j in range(grid_size):
			var grid_location = Vector2(i,j)
			var new_cell = Cell.instantiate()
			new_cell.grid_position = grid_location
			new_cell.position = grid_location * 40
			add_child(new_cell)
	# Adds the first Cell to the stack and starts the walk
	cell_array = get_children()
	cell_stack.append(cell_array[0])
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (cell_stack.size() > 0):
		frame_rate = 0
		# Gets the Cell at the top of the stack
		var current_cell = cell_stack[0]
		# Marks the Cell as Visited if it hasn't been already
		if not current_cell.isVisited:
			current_cell.set_visited()
		var neighbors = get_neighbor_coord(current_cell.grid_position)
		# If the current cell has no neighbors remove it from the stack for backtracking
		if neighbors.size() == 0:
			cell_stack.pop_front()
		# Randomly moves to a neighboring cell that hasn't been visited
		else:
			var rand_neighbor = neighbors.pick_random()
			var which_neighbor = rand_neighbor - (current_cell.grid_position.y + (current_cell.grid_position.x * 20))
			var whichDirection = [0,0]
			if which_neighbor == -1:
				whichDirection[0]  = 0
				whichDirection[1]  = 2
			elif which_neighbor == 20:
				whichDirection[0]  = 1
				whichDirection[1]  = 3
			elif which_neighbor == 1:
				whichDirection[0]  = 2
				whichDirection[1]  = 0
			elif which_neighbor == -20:
				whichDirection[0]  = 3
				whichDirection[1]  = 1
			current_cell.remove_wall(whichDirection[0])
			cell_array[rand_neighbor].remove_wall(whichDirection[1])
			cell_stack.push_front(cell_array[rand_neighbor])
func get_neighbor_coord(vec : Vector2) -> Array[int]:
	# I have no idea why it's inversed but we will live with it
	var location_2d : int = vec.y + (vec.x * 20)
	var neighbors : Array[int] = []
	if(vec.x - 1 >= 0) and !cell_array[location_2d - 20].isVisited:
		neighbors.append(location_2d - 20)
	if(vec.x + 1 < grid_size) and !cell_array[location_2d + 20].isVisited:
		neighbors.append(location_2d + 20)
	if(vec.y - 1 >= 0) and !cell_array[location_2d - 1].isVisited:
		neighbors.append(location_2d - 1)
	if(vec.y + 1 < grid_size) and !cell_array[location_2d + 1].isVisited:
		neighbors.append(location_2d + 1)
	return neighbors
	
