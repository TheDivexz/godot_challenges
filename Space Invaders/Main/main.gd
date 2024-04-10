extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
var Bullet = preload("res://Bullet/bullet.tscn")
func _process(delta):
	# Move the Ship
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	$Player.position.x += direction * $Player.speed
	# doesn't let the player go out of bounds
	if ($Player.position.x < 25) or ($Player.position.x > get_viewport().size.x - 25):
		$Player.position.x -= direction * $Player.speed
		
	# Fires a Bullet
	if Input.is_action_just_pressed("ui_accept"):
		var bullet : Node2D = Bullet.instantiate()
		bullet.position = $Player.position
		$Bullets.add_child(bullet)

func game_over():
	for child in get_children():
		child.queue_free()
