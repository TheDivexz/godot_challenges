extends Node2D

var planet = preload("res://celestial_object.tscn")
@export var initial_planets : int = 10
const GRAVITY_CONSTANT = 0.66743
var children = []
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var random = RandomNumberGenerator.new()
	for i in range(initial_planets):
		var new_planet = planet.instantiate()
		new_planet.position = Vector2(
			random.randi_range(-get_viewport().size.x/2,get_viewport().size.x/2),
			random.randi_range(-get_viewport().size.y/2,get_viewport().size.y/2)
		)
		# Generates an initial velocity vector that is perpendicular to the sun
		var speed = random.randf_range(0.0,5.0)
		var perpendicular_vector = Vector2(new_planet.position.y,-new_planet.position.x)
		var magnitude = sqrt(pow(perpendicular_vector.x,2) + pow(perpendicular_vector.y,2))
		perpendicular_vector /= magnitude
		perpendicular_vector *= speed
		new_planet.velocity = perpendicular_vector
		new_planet.mass = random.randf_range(0,10)
		$Planets.add_child(new_planet)
	children = $Planets.get_children()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Only worries about the effect of gravity of the sun on the planet.
	# if you take into account the mass of other planets the sun gets flung off into space
	# if you want to take into account the mass of other planets as well you'll never a much bigger area to play with
	
	for child in $Planets.get_children():
		if child == $Planets/Sun:
			continue
		var force = universal_gravitation($Planets/Sun.mass,child.mass,$Planets/Sun.position,child.position)
		child.velocity += force_vector(force,child.position,$Planets/Sun.position)
		
	# In case you want to turn gravity to affect every celestial body
	#for i in range(children.size()):
		#var child_1 = children[i]
		#for j in range(i+1,children.size()):
			#var child_2 = children[j]
			#var force = universal_gravitation(child_1.mass,child_2.mass,child_1.position,child_2.position)
			#child_1.velocity += force_vector(force,child_1.position,child_2.position)
			#child_2.velocity += force_vector(force,child_2.position,child_1.position) 
	
	for child in $Planets.get_children():
			child.position += child.velocity

# Calculates the Gravitational force
func universal_gravitation(mass_1 : float,mass_2 : float,position_1 : Vector2,position_2 : Vector2) -> float:
	var radius = sqrt(pow(position_2.x - position_1.x,2) + pow(position_2.y - position_1.y,2))
	return GRAVITY_CONSTANT * ((mass_1 * mass_2)/pow(radius,2))

func force_vector(gforce : float,position_1 : Vector2,position_2 : Vector2) -> Vector2:
	var relative_vector = Vector2(position_2.x - position_1.x, position_2.y - position_1.y)
	var magnitude = sqrt(pow(position_2.x - position_1.x,2) + pow(position_2.y - position_1.y,2))
	relative_vector /= magnitude
	relative_vector *= gforce
	return relative_vector
