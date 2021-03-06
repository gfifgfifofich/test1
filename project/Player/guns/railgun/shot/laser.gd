extends KinematicBody2D
var vel=Vector2()
var copart=preload("res://Player/guns/railgun/shot/collisionparticles.tscn")
var expl=preload("res://bullet/explode.tscn")
var dmg = 0
var boom =false
var dead = false
var explsc = Vector2(1,1)
var colormult = 2
var lifeframes = 15
var heat = 1.0

func _ready():
	rotation = 0
	rotation = get_angle_to(get_global_mouse_position())
func _physics_process(delta):
	lifeframes -=1
	if lifeframes <=0:
		dead = true
	colormult-=delta
	$Area2D/Polygon2D.color.g8 = 255*colormult
	$Area2D/Polygon2D.color.b8 = 237*colormult
	$Area2D/Polygon2D.color.a =min(colormult-1,1)
	if colormult-1<=0:
		queue_free()
func _on_Area2D_body_entered(body):
	if !dead:
		if body.is_in_group("enemies") or body.is_in_group("parts"):
			body.damage(dmg)
			body.heat+=heat*(dmg/Global.Player.dmg)
			if boom:
				var explodi = expl.instance()
				var laservec = $laserend.global_position - global_position
				var relpos = global_position - body.global_position
				explodi.rotation = rotation
				explodi.position=body.global_position + relpos - ((relpos.x* laservec.x + relpos.y* laservec.y) /(laservec.x*laservec.x+laservec.y*laservec.y))*laservec 
				
				explodi.scale=explsc
				explodi.dmg=dmg
				Global.main.spawninst(explodi)
			else:
				var coparti = copart.instance()
				
				coparti.rotation = rotation
				coparti.z_index = 1000
				coparti.speed_scale = 1
				coparti.scale = Vector2(scale.y,scale.y)
				coparti.emitting=true
				
				 
				var laservec = $laserend.global_position - global_position
				var relpos = global_position - body.global_position
				coparti.position=body.global_position + relpos - ((relpos.x* laservec.x + relpos.y* laservec.y) /(laservec.x*laservec.x+laservec.y*laservec.y))*laservec 
				Global.main.spawninst(coparti)

