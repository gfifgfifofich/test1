extends Node2D

var shtp = preload("res://bullet/shotparticles.tscn")
var bullet = preload ("res://Player/guns/railgun/shot/laser.tscn")
var ready = true
var charging = false
var cooling = 0.04
var soundbool = false 
export var ShotHeatMultiplyer = 1.0
var t = 0
func _physics_process(delta):
	
	$sound.global_position = global_position/4
	$soundreverb.global_position = global_position/4
	#Cooling
	if $b1/heat.color.a >0.0 and !charging:
		$b1/heat.color.a-=cooling * delta* Global.Player.CoolingSpeed
		ready = false
	elif !charging:
		ready = true
		if $AnimationPlayer.current_animation!="" and $AnimationPlayer.current_animation_position!=0:
			$AnimationPlayer.play_backwards("charge")
		$sound.seek(0.0)
	t +=delta
	if ready and charging:
		if !soundbool:
			$AnimationPlayer.play("charge")
			$sound.play(0.0)
			soundbool = true
		if $sound.get_playback_position()>=1.9:
			$sound.pitch_scale = 1.0+(0.5-sin(t*2))/30#rand_range(0.98,1.02)
			$sound.seek(1.8)
	
	
	#Repositioning
	if $b1.position.x>2:
		$b1.position.x-=0.4
func shoot(dmg,bulvel,expl,sc,explsc):
	# Heat, position (graphics)
	if ready:
		$soundreverb.play(0.0)
		$shot.play(0)
		$soundlong.stop()
		$sound.stop()
		
		soundbool = false
		Global.texturerect.get_material().set_shader_param("offset",0.0015 * dmg/Global.Player.dmg)
		
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
		bi.heat = ShotHeatMultiplyer
		bi.position=$b1/bn.global_position
		Global.main.spawninst(bi)
