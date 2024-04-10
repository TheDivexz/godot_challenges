extends Node2D

var enemy = preload("res://Enemy/Enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var velocity_tracker : float = 5.0
	for row in range(4):
		for col in range(23):
			var new_enemy = enemy.instantiate()
			new_enemy.position = Vector2(col * 50, row * 50)
			new_enemy.velocity = velocity_tracker
			add_child(new_enemy)
		velocity_tracker *= -1.1
	
# Moves the child to the next row if it reaches the end of the line
func move_down(child):
	if (child.position.x > get_viewport().size.x) or (child.position.x < 0):
		child.position.x -= child.velocity
		child.position.y += 46
		child.velocity *= -1.1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		child.position.x += child.velocity
		move_down(child)
