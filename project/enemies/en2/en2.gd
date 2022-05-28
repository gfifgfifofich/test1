extends RigidBody2D

#shooter component
export var dmg = 1 # bullet damage
var bvel = 250 # bullet velocity
export var expl = false # exploding?
var bscale = Vector2(1,1)# bullet scale
var explscale = Vector2(0,0) # explosion scale
export var frate = float (1.0/4) # 1.0/(shots per sec) ((((1.0/4 == 4 shots / sec))))
# part component
export var hp = 100
var coldmg = 0 # collision damage
export var speed = 10
var acceleration
var velocity = Vector2(0,0)

var heat = 0
var maxheat = 2.0
var coolingspeed = 0.1
var stockcoolingspeed = coolingspeed
var minr
var ming
var colmult = 1


func _ready():
	minr = $Polygon2D.color.r
	ming = $Polygon2D.color.g
	colmult = minr
	linear_velocity = (Global.PlayerPosition - position).normalized()*speed * 10
	
func _physics_process(delta):
	if heat > maxheat/7:
		heat = maxheat/7
	if heat >0:
		heat -= coolingspeed * delta
	$Polygon2D.color.r= minr + heat/maxheat * colmult * 1.8
	$Polygon2D.color.g= ming + heat/maxheat / 2 * colmult * 1.8
	
	acceleration = (Global.PlayerPosition - position).normalized()*speed
	applied_torque = get_angle_to(linear_velocity+global_position) * 20
	applied_force = acceleration

func damage(dmg):
	hp-=dmg * (1+heat / (maxheat/7))
	if hp<=0:
		get_tree().queue_delete(self)
