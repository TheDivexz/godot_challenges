extends Node2D

var cell = preload("res://Cell.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var new_cell = cell.instantiate()
	randomize()
	var random = RandomNumberGenerator.new()
	new_cell.position = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
	add_child(new_cell)

func cell_split(original : Node2D):
	# Changes Velocity to a perpendicular Vector
	original.velocity = Vector2(original.velocity.y,-original.velocity.x)
	var new_cell = cell.instantiate()
	new_cell.position = original.position
	new_cell.velocity = original.velocity * -1
	add_child(new_cell)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		child.position += child.velocity * delta * 10
		if (child.position.x < 0) or (child.position.x > get_viewport().size.x):
			child.position -= child.velocity * delta * 10
			child.velocity.x *= -1
		if (child.position.y < 0) or (child.position.y > get_viewport().size.y):
			child.position -= child.velocity * delta * 10
			child.velocity.y *= -1
		child.update_velocity()
