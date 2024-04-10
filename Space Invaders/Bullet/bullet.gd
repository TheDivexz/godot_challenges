extends Node2D
class_name Bullet

@export var velocity : int = 20
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Destroys Bullet and Alien
func _on_area_2d_area_entered(area):
	area.get_parent().destroy()
	queue_free()
