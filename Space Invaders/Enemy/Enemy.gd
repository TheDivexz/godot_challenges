extends Node2D
class_name Enemy

@export var velocity : float = 5.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# What to do when it gets hit by Bullet
func destroy():
	queue_free()


func _on_area_2d_area_entered(area):
	print("Game over")
