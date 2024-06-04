extends Node

@export var collapse_val : float = 0.4
# Called when the node enters the scene tree for the first time.
func _ready():
	print("lines started")
	var point_list = $"../Points".ordered_list
	var density = $"../Points".density
	
	for y in range(density-1):
		for x in range(density-1):
			var top_left = point_list[x + (y*density)].color_val
			var tl_pos : Vector2 = point_list[x + (y*density)].position
			
			var top_right = point_list[(x+1) + (y*density)].color_val
			var tr_pos : Vector2 = point_list[(x+1) + (y*density)].position
			
			var bottom_left = point_list[(x) + ((y+1)*density)].color_val
			var bl_pos : Vector2 = point_list[(x) + ((y+1)*density)].position
			
			var bottom_right = point_list[(x+1) + ((y+1)*density)].color_val
			var br_pos : Vector2 = point_list[(x+1) + ((y+1)*density)].position
			
			var which_case = case_value(top_left,top_right,bottom_left,bottom_right)
			var new_line = Line2D.new()
			new_line.width = 1.0
			match which_case:
				1:
					new_line.add_point(Vector2(
						br_pos.x,
						(tr_pos.y + br_pos.y)/2
					))
					new_line.add_point(Vector2(
						(br_pos.x + bl_pos.x)/2,
						bl_pos.y
					))
				2:
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
					new_line.add_point(Vector2(
						(bl_pos.x + br_pos.x)/2,
						bl_pos.y
					))
				3:
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
					new_line.add_point(Vector2(
						tr_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
				4:
					new_line.add_point(Vector2(
						(tr_pos.x + tl_pos.x)/2,
						tl_pos.y
					))
					new_line.add_point(Vector2(
						tr_pos.x,
						(tr_pos.y + br_pos.y)/2
					))
				5:
					new_line.add_point(Vector2(
						(tr_pos.x + tl_pos.x)/2,
						tr_pos.y
					))
					new_line.add_point(Vector2(
						(bl_pos.x + br_pos.x)/2,
						bl_pos.y
					))
				6:
					new_line.add_point(Vector2(
						(tl_pos.x + tr_pos.x)/2,
						tr_pos.y
					))
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
					var second_line = Line2D.new()
					second_line.width = 1.0
					second_line.add_point(Vector2(
						tr_pos.x,
						(tr_pos.y + br_pos.y)/2
					))
					second_line.add_point(Vector2(
						(bl_pos.x + br_pos.x)/2,
						br_pos.y
					))
					add_child(second_line)
				7:
					new_line.add_point(Vector2(
						(tl_pos.x + tr_pos.x)/2,
						tr_pos.y
					))
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
				8:
					new_line.add_point(Vector2(
						(tl_pos.x + tr_pos.x)/2,
						tr_pos.y
					))
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
				9:
					new_line.add_point(Vector2(
						(tr_pos.x + tl_pos.x)/2,
						tl_pos.y
					))
					new_line.add_point(Vector2(
						tr_pos.x,
						(tr_pos.y + br_pos.y)/2
					))
					var second_line = Line2D.new()
					second_line.width = 1.0
					second_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
					second_line.add_point(Vector2(
						(bl_pos.x + br_pos.x)/2,
						bl_pos.y
					))
					add_child(second_line)
				10:
					new_line.add_point(Vector2(
						(tr_pos.x + tl_pos.x)/2,
						tr_pos.y
					))
					new_line.add_point(Vector2(
						(bl_pos.x + br_pos.x)/2,
						bl_pos.y
					))
				11:
					new_line.add_point(Vector2(
						(tr_pos.x + tl_pos.x)/2,
						tl_pos.y
					))
					new_line.add_point(Vector2(
						tr_pos.x,
						(tr_pos.y + br_pos.y)/2
					))
				12:
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
					new_line.add_point(Vector2(
						tr_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
				13:
					new_line.add_point(Vector2(
						tl_pos.x,
						(tl_pos.y + bl_pos.y)/2
					))
					new_line.add_point(Vector2(
						(bl_pos.x + br_pos.x)/2,
						bl_pos.y
					))
				14:
					new_line.add_point(Vector2(
						br_pos.x,
						(tr_pos.y + br_pos.y)/2
					))
					new_line.add_point(Vector2(
						(br_pos.x + bl_pos.x)/2,
						bl_pos.y
					))
				_:
					pass
			if new_line.points.size() > 0:
				add_child(new_line)
	
	#$"../Points".remove_all()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func case_value(tl : float, tr : float, bl : float, br : float):
	var value := 0
	if br > collapse_val:
		value += 1
	if bl > collapse_val:
		value += 2
	if tr > collapse_val:
		value += 4
	if tl > collapse_val:
		value += 8
	return value
