extends Node2D

class Drop:
	var velocity : float
	var position : Vector2
	var size : Vector2
	
	func _init():
		var rand = RandomNumberGenerator.new()
		velocity = rand.randf_range(5.0,10.0)
		position = Vector2(randi_range(0,500),randi_range(-500,-100))
		size = Vector2(randi_range(1,3),randi_range(5,7))
	

var drop = preload("res://drop.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(1000):
		var new_drop : Node = drop.instantiate()
		new_drop.setDrop()
		new_drop.position = Vector2(randi_range(-100,1200),randi_range(-1000,-100))
		add_child(new_drop)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		child.position.y += child.velocity
		if child.position.y > get_viewport().size.y:
			child.position = Vector2(randi_range(-100,1200),randi_range(-500,-100))
