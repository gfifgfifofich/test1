extends KinematicBody2D
var rps = 4.781231
var pos1 = Vector2()
var pos2 = Vector2()
export var velrotation= true
export var arm = false
export var damaged = false
var rotationspeed = 0.0
func _physics_process(delta):
	$Polygon2D2.rotation+=3.14159 *2 * rps * delta
	$gun.rotation = get_angle_to(Global.Player.position) - deg2rad(90)
	if arm:
		if rotationspeed<100:
			rotationspeed +=1.0
		$gun.get_material().set_shader_param("speed",rotationspeed)
	if velrotation:
		rotation = 0
		pos1 = position
		rotation = get_angle_to(position + pos1 - pos2) - deg2rad(92)
		pos2 = position
	if damaged:
		$Particles2D.emitting=true
		rotation += 3.14159 *2 * delta
