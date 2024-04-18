extends Node2D
enum direction {
	NORTH, EAST, SOUTH, WEST
}
var walls : Array[bool] = [true,true,true,true]
var cell_size : int = 40
var grid_position : Vector2 = Vector2(0,0)
var isVisited : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	# Draws all four lines of the wall
	var line = Line2D.new()
	line.width = 1
	line.points = [Vector2(0,0),Vector2(cell_size,0)]
	line.name = "North"
	add_child(line)
	line = Line2D.new()
	line.width = 1
	line.points = [Vector2(cell_size,0),Vector2(cell_size,cell_size)]
	line.name = "East"
	add_child(line)
	line = Line2D.new()
	line.width = 1
	line.points = [Vector2(cell_size,cell_size),Vector2(0,cell_size)]
	line.name = "South"
	add_child(line)
	line = Line2D.new()
	line.width = 1
	line.points = [Vector2(0,cell_size),Vector2(0,0)]
	line.name = "West"
	add_child(line)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_visited():
	isVisited = true
	#var box = MeshInstance2D.new()
	#box.mesh = BoxMesh.new()
	#box.position = Vector2(cell_size/2,cell_size/2)
	#box.scale *= 10
	#add_child(box)
	
func remove_wall(wall : int):
	walls[wall] = false
	if wall == 0:
		remove_child($North)
	elif wall == 1:
		remove_child($East)
	elif wall == 2:
		remove_child($South)
	elif wall == 3:
		remove_child($West) 
