extends KinematicBody2D
export var dethparticles = preload("res://enemies/particles/destroy.tscn")

export var hp = 10
export var speed = 3
#shooter component
export var dmg = 1 # bullet damage
var bvel = 250 # bullet velocity
export var expl = false # exploding?
var bscale = Vector2(1,1)# bullet scale
var explscale = Vector2(0,0) # explosion scale
export var frate = float (1.0/1) # 1.0/(shots per sec) ((((1.0/4 == 4 shots / sec))))
var coldmg = 1

var heat = 0
var maxheat = 2.0
var coolingspeed = 0.05
export var stockcoolingspeed = 0.1
var colmult = 1
var radiatorCount = 0
var t = 0

var PartsCount=0
var TotalHeat = 0

var targetposition = Vector2()
var seetingtime = 1
var seetingtimer = 0


func _physics_process(delta):
	coolingspeed = stockcoolingspeed + 0.5 * radiatorCount
	if heat > maxheat:
		heat = maxheat
	if heat >0:
		heat -= coolingspeed * delta
	if heat <0:
		heat = 0
		
	TotalHeat = heat
	TotalHeat =TotalHeat/(PartsCount+1)
	
	$core/Polygon2D.color.a= (heat * colmult)/maxheat
	if ((targetposition - position).length_squared()<10000):
		seetingtimer+=delta
		if (targetposition - position).length_squared()<64:
			position = targetposition
		if(seetingtimer>=seetingtime or targetposition == Vector2(0,0)):
			seetingtimer = 0
			targetposition =  (Vector2(rand_range(-450,450),rand_range(-220,220)) -Global.Player.position).normalized() * 100
	
	rotation =0
	rotation = get_angle_to(targetposition)
	move_and_collide((targetposition - position).normalized()*speed)
	
	t+=delta
	if t >= frate:
		t=0
		for i in range(0,get_child_count(),1):
			if get_child(i).is_in_group("guns"):
				get_child(i).shoot(dmg,bvel,expl,bscale,explscale)
	
func damage(dmg):
	hp-=dmg * (1+heat / maxheat)
	if hp<=0:
		var dpi = dethparticles.instance()
		dpi.position = position
		Global.main.spawninst(dpi)
		
		get_tree().queue_delete(self)
