extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Moves the Bullet forward or deletes the bullet if it goes off screen
	for child in get_children():
		if child.position.y < 0:
			remove_child(child)
			continue
		child.position.y -= child.velocity
