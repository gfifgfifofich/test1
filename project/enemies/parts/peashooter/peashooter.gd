extends KinematicBody2D

var shtp = preload("res://bullet/shotparticles.tscn")
var bullet = preload ("res://bullet/bullet.tscn")
var cooling = 1.0
var ready = false
var hp = 5
var coldmg = 0
func _physics_process(delta):
	
	if $b1/heat.color.a >2.0:
		ready = false
	if $b1/heat.color.a <=0.0:
		ready = true
		
		
	if $b1/heat.color.a >0.0:
		$b1/heat.color.a-=cooling * delta* Global.PlayerCoolingSpeed
		
	if $b1.position.x>2:
		$b1.position.x-=0.4
		
func shoot(dmg,bulvel,expl,sc,explsc):
	if $b1/heat.color.a<=2.0 and ready:
		# Heat, position (graphics)
		if ($b1/heat.color.a < 2.0):
			$b1/heat.color.a+=0.75
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
		bi.vel=($b1/bn.global_position-global_position).normalized()*bulvel
		bi.explsc = explsc
		if expl:
			mult = 1.25
			bi.boom=true
		bi.dmg=(dmg)
		bi.en = true
		bi.position=$b1/bn.global_position
		Global.main.spawninst(bi)

func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
