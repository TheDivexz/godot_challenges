extends Node2D

@export var velocity : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setDrop():
	var rand = RandomNumberGenerator.new()
	velocity = rand.randf_range(10.0,30.0)
	$raindrop.scale = Vector2(randi_range(1,3),randi_range(5,7))
