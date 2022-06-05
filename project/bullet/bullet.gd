extends KinematicBody2D
var vel=Vector2()
var copart=preload("res://bullet/bulcolpart.tscn")
var expl=preload("res://bullet/explode.tscn")
var dmg = 1
var boom =false
var astri 
var dead = false
var en = false
var explsc = Vector2(1,1)
var deadtim = 0
var t = 2
var heat = 0.1
func _ready():
	$Node2D.width=3.771*scale.y
	
func _physics_process(delta):
	if !dead:
		
		move_and_slide(vel,Vector2(0,1))
		t-=1
		if t <=0:
			t=2
			$Node2D.add_point(global_position)
		rotation=0
		rotation = get_angle_to(vel+global_position)
		if is_on_wall() or is_on_ceiling() or is_on_floor():
			RIP()
	else:
		$Polygon2D.visible=false
		deadtim+=delta
		if deadtim>=0.2:
			queue_free()
func _on_Area2D_body_entered(body):
	if !dead:
		if (body.is_in_group("enemies") or body.is_in_group("parts")) and !en:
			body.damage(dmg)
			body.heat+=heat
			RIP()
		elif body.name =="player" and en:
			body.damage(dmg)
			RIP()
func RIP():
	dead = true
	$Node2D.stop()
	if boom:
		var explodi = expl.instance()
		explodi.position = position
		explodi.scale=explsc
		explodi.dmg=dmg
		explodi.en = en
		Global.main.spawninst(explodi)
	else:
		var coparti = copart.instance()
		
		coparti.rotation = rotation
		coparti.emitting=true
		coparti.position=position
		Global.main.spawninst(coparti)
