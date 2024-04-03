extends Node2D

class star_struct:
	var position: Vector2
	var velocity_vector: Vector2
	
# Checks if the star is out of the screen or not
func out_of_bounds(current_position: Vector2):
	var viewport_width = get_viewport().size.x / 2
	var viewport_height = get_viewport().size.y / 2
	return abs(current_position.x) > viewport_width or abs(current_position.y) > viewport_height

# Creates a new position and Velocity Vector for the star
func new_positon_and_velocity(near_middle : bool = false):
	var viewport_width = get_viewport().size.x / 2
	var viewport_height = get_viewport().size.y / 2
	if near_middle:
		viewport_width *= 0.5
		viewport_height *= 0.5
	var random = RandomNumberGenerator.new()
	random.randomize()
	var star_position = Vector2(random.randi_range(-viewport_width, viewport_width),random.randi_range(-viewport_height, viewport_height))
	var velocity = random.randi_range(1,20)
	var magnitude = sqrt((star_position.x ** 2) + (star_position.y ** 2))
	var velocity_vector : Vector2 = Vector2((star_position.x/magnitude) * velocity,(star_position.y/magnitude) * velocity)
	var return_struct : star_struct = star_struct.new()
	return_struct.position = star_position
	return_struct.velocity_vector = velocity_vector
	return return_struct
 
# Called when the node enters the scene tree for the first time.
var star = preload("res://star.tscn")
func _ready():
	print(typeof(get_viewport().size))
	randomize()
	# Creates 1000 Stars
	for i in range(1000):
		var instance: Node = star.instantiate()
		var star_properties : star_struct = new_positon_and_velocity()
		instance.position = star_properties.position
		instance.set_velocity_vector(star_properties.velocity_vector)
		add_child(instance,true)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for child in get_children():
		if child.get_class() != "Camera2D":
			child.position = Vector2(
				child.position.x + child.velocity_vector.x,
				child.position.y + child.velocity_vector.y
			)
			if out_of_bounds(child.position):
				var new_points : star_struct = new_positon_and_velocity(true)
				child.position = new_points.position
				child.set_velocity_vector(new_points.velocity_vector)
		
