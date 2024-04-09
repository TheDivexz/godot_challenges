extends Node2D

var framerate_limiter : int = 0
var momentum : Vector2 = Vector2(1,0)
var grid_size : int = 20
@export var grid_height : int = 30
@export var grid_width : int = 40
var grid_position : Vector2 = Vector2(0,0)
var food_position : Vector2 = Vector2(0,0)

func set_food_position():
	var random = RandomNumberGenerator.new()
	random.randomize()
	food_position = Vector2(random.randi_range(0,grid_width),random.randi_range(0,grid_height))
	$Food.position = (food_position * 20) + Vector2(10,10)
	

# Called when the node enters the scene tree for the first time.
func _ready():
	# Draws the border
	var draw_border : Line2D = Line2D.new()
	draw_border.name = "border"
	draw_border.width = 1
	draw_border.set_points(PackedVector2Array([
		Vector2((grid_width + 1) * grid_size,0),
		Vector2((grid_width + 1) * grid_size, (grid_height + 1) * grid_size),
		Vector2(0,(grid_height + 1) * grid_size),
		]))
	add_child(draw_border)
	set_food_position()

# Makes sure the snake stays within range
func check_boundry():
	if grid_position.x > grid_width:
		$Snake.position.x -= grid_size
		grid_position.x -= 1
	if grid_position.x < 0:
		$Snake.position.x += grid_size
		grid_position.x += 1
	if grid_position.y > grid_height:
		$Snake.position.y -= grid_size
		grid_position.y -= 1
	if grid_position.y < 0:
		$Snake.position.y += grid_size
		grid_position.y += 1

# If the food is eaten, add a segment and place the food somehwere else
func is_food_eaten():
	if grid_position == food_position:
		$Snake.add_segment(momentum)
		set_food_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		momentum = Vector2(0,-1)
	if Input.is_action_just_pressed("ui_down"):
		momentum = Vector2(0,1)
	if Input.is_action_just_pressed("ui_left"):
		momentum = Vector2(-1,0)
	if Input.is_action_just_pressed("ui_right"):
		momentum = Vector2(1,0)
		
	framerate_limiter += 1
	
	if framerate_limiter % 12 == 0:
		framerate_limiter = 0
		$Snake.position.x += momentum.x * grid_size
		$Snake.position.y += momentum.y * grid_size
		grid_position += momentum
		check_boundry()
		is_food_eaten()
		$Snake.update_segments(grid_position * 20)
	pass
