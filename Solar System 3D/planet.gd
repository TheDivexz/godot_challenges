extends Node3D

@export var velocity : Vector3 = Vector3(0,0,0)
@export var isSun : bool = false
@export var mass : float = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	# Makes the sun bright
	if isSun:
		var shader_material := ShaderMaterial.new()
		var shader = Shader.new()
		shader.code = """
		shader_type spatial;
		render_mode unshaded;
		
		void fragment() {
			ALBEDO = vec3(1.0,1.0,1.0);
		}
		"""
		shader_material.shader = shader
		$MeshInstance3D.set("surface_material_override/0",shader_material)
	else:
		var random = RandomNumberGenerator.new()
		var random_color = Vector3(
			random.randf(),
			random.randf(),
			random.randf()
		)
		$MeshInstance3D.get_surface_override_material(0).set_shader_parameter("setColor",random_color)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
