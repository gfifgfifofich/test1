extends Area2D
var dmg = 0
var en = false
var damag = 0
var sc = 0
func _ready():
	sc = scale
	scale = Vector2(1,1)
	dmg *=(sc.x/16+1)
	damag = dmg
	$Particles2D.emitting=true
	$Polygon2D.get_material().set_shader_param("offset",Vector2(rand_range(500,-500),rand_range(500,-500)))
func _physics_process(delta):
	$Polygon2D.color.a-=0.03
	scale+=sc/40
	dmg = damag*$Polygon2D.color.a
	if $Particles2D.emitting==false:
		queue_free()


func _on_explode_body_entered(body):
	if !en:
		if body.is_in_group("enemies") or body.is_in_group("parts"):
			body.damage(dmg)
	else:
		if body.name == "player":
			body.damage(1)
