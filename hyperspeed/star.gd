extends Node2D

@export var velocity_vector: Vector2 = Vector2(0,0)
func update_tail():
	$trail.set_points(PackedVector2Array([-velocity_vector,Vector2(0,0)]))
	
func set_velocity_vector(new_velocity: Vector2):
	velocity_vector = new_velocity
	update_tail()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
