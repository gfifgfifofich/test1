extends Node2D

var shtp = preload("res://bullet/shotparticles.tscn")
var bullet = preload ("res://Player/guns/railgun/shot/laser.tscn")
var ready = true
var charging = false
var cooling = 0.04
func _physics_process(delta):
	#Cooling
	if $b1/heat.color.a >0.0 and !charging:
		$b1/heat.color.a-=cooling * delta* Global.Player.CoolingSpeed
		ready = false
	elif !charging:
		ready = true
	#Repositioning
	if $b1.position.x>2:
		$b1.position.x-=0.4
func shoot(dmg,bulvel,expl,sc,explsc):
	# Heat, position (graphics)
	if ready:
		
		Global.texturerect.get_material().set_shader_param("offset",0.002 * dmg/Global.Player.dmg)
		
		$b1.position.x=8 
		#particles
		var shtpi = shtp.instance()
		shtpi.position = $b1/bn.global_position
		shtpi.emitting=true
		shtpi.rotation = Global.Player.LookDir
		Global.main.spawninst(shtpi)
		
		#shoot
		var bi = bullet.instance()
		var mult = 1
		bi.scale=sc
		bi.explsc = explsc
		if expl:
			mult = 1.25
			bi.boom=true
		bi.dmg=(dmg)
		bi.position=$b1/bn.global_position
		Global.main.spawninst(bi)
