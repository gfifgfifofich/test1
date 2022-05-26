extends Node2D

var shtp = preload("res://bullet/shotparticles.tscn")
var bullet = preload ("res://bullet/bullet.tscn")
var cooling = 0.5
var ready = false
var heatcolormult = 0.5
func _physics_process(delta):
	if $b1/heat.color.a >2.5*heatcolormult:
		ready = false
	if $b1/heat.color.a <=0.0:
		ready = true
	if $b1/heat.color.a >0.0:
		$b1/heat.color.a-=cooling * delta* Global.PlayerCoolingSpeed
	if $b1.position.x>2:
		$b1.position.x-=0.4
func shoot(dmg,bulvel,expl,sc,explsc):
	if $b1/heat.color.a<=2.5*heatcolormult and ready:
		# Heat, position (graphics)
		if ($b1/heat.color.a < 2.5*heatcolormult):
			$b1/heat.color.a+=0.175*heatcolormult
		$b1.position.x=8 
		#particles
		var shtpi = shtp.instance()
		shtpi.position = $b1/bn.global_position
		shtpi.emitting=true
		shtpi.rotation = Global.PlayerLookDir
		Global.main.spawninst(shtpi)
		
		#shoot
		var spr = Vector2(rand_range(10,-10),rand_range(10,-10))
		var bi = bullet.instance()
		var mult = 1
		bi.scale=sc
		bi.vel=($b1/bn.global_position-global_position).normalized()*bulvel+Global.PlayerVelocity/2
		bi.explsc = explsc
		if expl:
			mult = 1.25
			bi.boom=true
		bi.dmg=(dmg)
		bi.position=$b1/bn.global_position
		Global.main.spawninst(bi)
