extends Node3D

@export var initial_planets : int = 10
@export var spawn_range : int = 20
@export var max_speed : float = 0.2
const gravitational_constant = .0066743
var Planet = preload("res://planet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var random = RandomNumberGenerator.new()
	for i in range(initial_planets):
		var new_planet = Planet.instantiate()
		new_planet.position = Vector3(
			random.randi_range(-spawn_range,spawn_range),
			random.randi_range(-spawn_range,spawn_range),
			random.randi_range(-spawn_range,spawn_range)
		)
		var speed = random.randfn(0.0,max_speed)
		var vel = perpendicular_vector(new_planet.position)
		vel = normalize_vector(vel)
		vel = vel * speed
		new_planet.velocity = vel
		new_planet.mass = random.randf_range(0.0,2.0)
		$Planets.add_child(new_planet)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for planet in $Planets.get_children():
		var force_vec = normalize_vector(planet.position)
		var force = gravity_force($Sun.mass,planet.mass,$Sun.position,planet.position)
		force_vec = force_vec * force
		planet.velocity -= force_vec
		planet.position += planet.velocity

func normalize_vector(vec : Vector3) -> Vector3:
	var magnitude = sqrt(pow(vec.x,2) + pow(vec.y,2) + pow(vec.x,2))
	return (vec / magnitude)

func perpendicular_vector(vec : Vector3) -> Vector3:
	return Vector3(vec.z,vec.y,-vec.x)
	
func gravity_force(mass_1 : float, mass_2 : float, pos_1 : Vector3, pos_2 : Vector3):
	var relative_vec : Vector3 = pos_2 - pos_1
	var radius = sqrt(pow(relative_vec.x,2) + pow(relative_vec.y,2) + pow(relative_vec.x,2))
	radius = pow(radius,2)
	return gravitational_constant * ((mass_1 * mass_2)/radius)
