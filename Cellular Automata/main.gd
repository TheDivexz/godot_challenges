extends Node2D

@onready var cell = preload("res://cell.tscn")
@export var grid_size := 100
var ordered_list = []
var next_itr = []
# Called when the node enters the scene tree for the first time.
func _ready():
	generate_grid()


func generate_grid():
	for y in grid_size:
		for x in grid_size:
			var new_cell = cell.instantiate()
			new_cell.position = Vector2((x * 10)+5,(y * 10)+5)
			add_child(new_cell)
			ordered_list.append(new_cell)
	for i in 15:
		next_round()

func next_round():
	next_itr = []
	for y in grid_size:
		for x in grid_size:
			# if it's on an edge it's a wall
			if (x == 0) or (x == grid_size-1) or (y == 0) or (y == grid_size-1):
				next_itr.append(true)
				continue
			# count how many neighbors are walls
			var walls = 0
			for dy in range(-1,2):
				for dx in range(-1,2):
					if (ordered_list[(x + dx) + ((y + dy) * grid_size)].isWall) and  (not ((dy == dx) and (dy == 0))):
						walls += 1
			if walls > 4:
				next_itr.append(true)
			else:
				next_itr.append(false)
	update_cells()

func update_cells():
	var index = 0
	while index < ordered_list.size():
		ordered_list[index].isWall = next_itr[index]
		index += 1
