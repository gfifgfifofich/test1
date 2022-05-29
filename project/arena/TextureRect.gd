extends TextureRect


func _ready():
	Global.texturerect = self
func _physics_process(delta):
	var offset = get_material().get_shader_param("offset")
	if offset >0:
		get_material().set_shader_param("offset",offset -0.0002)
