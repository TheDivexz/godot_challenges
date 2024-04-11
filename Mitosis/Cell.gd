extends Node2D

@export var velocity : Vector2 = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	# Randomly sets the color when created
	var random = RandomNumberGenerator.new()
	$MeshInstance2D.material.set_shader_parameter("set_color",Vector4(random.randf(),random.randf(),random.randf(),1.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_velocity():
	var random = RandomNumberGenerator.new()
	velocity += Vector2(random.randf_range(-0.5,0.5),random.randf_range(-0.5,0.5))


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == 1 and event.pressed == true:
		get_parent().cell_split(self)
