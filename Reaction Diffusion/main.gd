extends Node2D

var cell = preload("res://cell.tscn")
var cell_grid = []
var new_cell_grid = []
var weights = [0.05,0.2,0.05,0.2,-1,0.2,0.05,0.2,0.05]
var grid_size = 100

@export var delta_a : float = 1.0
@export var delta_b : float = 0.5
@export var feed    : float = 0.055
@export var kill    : float = 0.062
# Called when the node enters the scene tree for the first time.
class updated_values:
	var a = 1.0
	var b = 0.0
func _ready():
	for i in range(grid_size):
		for j in range(grid_size):
			var new_cell = cell.instantiate()
			new_cell.position += Vector2(i * 5,j * 5)
			new_cell.scale *= 5
			cell_grid.append(new_cell)
			add_child(new_cell)
			new_cell_grid.append(updated_values.new())
	
	## Place a small amount of poison in the center
	var poison_zone = (grid_size)/2 + (grid_size * grid_size)/2
	for i in range(-5,5):
		for j in range(-5,5):
			cell_grid[poison_zone + i + (j * grid_size)].update_values(0,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var index : int = 0
	for old_cell in cell_grid:
		var a = old_cell.a
		var b = old_cell.b
		var da = a + (((delta_a * laplaceA(index)) - (a * b * b) + (feed * (1 - a))))
		var db = b + (((delta_b * laplaceB(index)) + (a * b * b) - (b * (kill + feed))))
		new_cell_grid[index].a = da
		new_cell_grid[index].b = db
		index += 1
	
	index = 0
	for old_cell in cell_grid:
		old_cell.update_values(new_cell_grid[index].a,new_cell_grid[index].b)
		index += 1
	pass
func laplaceA(index):
	var sum = 0
	# top left
	if(index - grid_size - 1 >= 0) and (index - grid_size - 1 < cell_grid.size()):
		sum += cell_grid[index - grid_size - 1].a * weights[0]
	# top
	if(index - 1 >= 0) and (index - 1 < cell_grid.size()):
		sum += cell_grid[index - 1].a * weights[1]
	# top right
	if(index + grid_size - 1 < cell_grid.size()) and (index + grid_size - 1 >= 0):
		sum += cell_grid[index + grid_size - 1].a * weights[2]
	# left
	if(index - grid_size >= 0) and (index - grid_size < cell_grid.size()):
		sum += cell_grid[index - grid_size].a * weights[3]
	# Center Square weight
	sum += cell_grid[index].a * weights[4]
	# right
	if(index + grid_size >= 0) and (index + grid_size < cell_grid.size()):
		sum += cell_grid[index + grid_size].a * weights[5]
	# bottom left
	if(index - grid_size + 1 >= 0) and (index - grid_size + 1 < cell_grid.size()):
		sum += cell_grid[index - grid_size + 1].a * weights[6]
	# bottom
	if(index + 1 >= 0) and (index + 1 < cell_grid.size()):
		sum += cell_grid[index+ 1].a * weights[7]
	# bottom right
	if(index + 1 + grid_size >= 0) and (index + 1 + grid_size < cell_grid.size()):
		sum += cell_grid[index+ 1 + grid_size].a * weights[7]
	return sum
func laplaceB(index):
	var sum = 0
	# top left
	if(index - grid_size - 1 >= 0) and (index - grid_size - 1 < cell_grid.size()):
		sum += cell_grid[index - grid_size - 1].b * weights[0]
	# top
	if(index - 1 >= 0) and (index - 1 < cell_grid.size()):
		sum += cell_grid[index - 1].b * weights[1]
	# top right
	if(index + grid_size - 1 < cell_grid.size()) and (index + grid_size - 1 >= 0):
		sum += cell_grid[index + grid_size - 1].b * weights[2]
	# left
	if(index - grid_size >= 0) and (index - grid_size < cell_grid.size()):
		sum += cell_grid[index - grid_size].b * weights[3]
	# Center Square weight
	sum += cell_grid[index].b * weights[4]
	# right
	if(index + grid_size >= 0) and (index + grid_size < cell_grid.size()):
		sum += cell_grid[index + grid_size].b * weights[5]
	# bottom left
	if(index - grid_size + 1 >= 0) and (index - grid_size + 1 < cell_grid.size()):
		sum += cell_grid[index - grid_size + 1].b * weights[6]
	# bottom
	if(index + 1 >= 0) and (index + 1 < cell_grid.size()):
		sum += cell_grid[index+ 1].b * weights[7]
	# bottom right
	if(index + 1 + grid_size >= 0) and (index + 1 + grid_size < cell_grid.size()):
		sum += cell_grid[index+ 1 + grid_size].b * weights[7]
	return sum
