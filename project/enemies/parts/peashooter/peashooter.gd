extends KinematicBody2D

var shtp = preload("res://bullet/shotparticles.tscn")
var bullet = preload ("res://bullet/bullet.tscn")
export var cooling = 1.0
var coolingmult = cooling
var ready = false
export var hp = 5
var coldmg = 0
var alphamult = 0.35 # multiplicator for easier manipulations with heat
var heatgaindmg = 0.3
var heat = 0.0
var maxheat = 2.0


var parent
func _ready():
	parent =get_parent()
	var found = false
	while !found:
		if parent.is_in_group("enemies"):
			found = true
		else:
			parent = parent.get_parent()
func _physics_process(delta):
	cooling = parent.coolingspeed * coolingmult
	if heat >2.0:
		ready = false
	if heat <=0.0:
		ready = true
	
	
	if heat >0.0:
		heat-=cooling * delta
	if heat>2:
		heat-=0.4
	$b1/heat.color.a = heat * alphamult


func shoot(dmg,bulvel,expl,sc,explsc):
	if heat<=2.0 and ready:
		# Heat, position (graphics)
		if (heat < 2.0):
			heat+=0.75
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
