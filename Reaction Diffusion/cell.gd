extends Node2D

var a : float = 1.0
var b : float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$square.material.set_shader_parameter("a_value",a)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_values(new_a,new_b):
	a = new_a
	b = new_b
	$square.material.set_shader_parameter("a_value",a)
