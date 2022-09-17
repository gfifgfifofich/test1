extends RigidBody2D
export var dethparticles = preload("res://enemies/particles/destroy.tscn")
#shooter component
export var dmg = 1 # bullet damage
var bvel = 250 # bullet velocity
export var expl = false # exploding?
var bscale = Vector2(1,1)# bullet scale
var explscale = Vector2(0,0) # explosion scale
export var frate = float (1.0/40) # 1.0/(shots per sec) ((((1.0/4 == 4 shots / sec))))
# part component
export var hp = 100
var coldmg = 0 # collision damage
export var speed = 10
var acceleration
var velocity = Vector2(0,0)

var heat = 0
var maxheat = 2.0
export var stockcoolingspeed = 0.1
var coolingspeed = 0.05
var colmult = 1

var PartsCount=0
var TotalHeat = 0

func _ready():
	linear_velocity = (Global.Player.position - position).normalized()*speed * 10
	
func _physics_process(delta):
	
	
	
	if heat > maxheat:
		heat = maxheat
	if heat >0:
		heat -= coolingspeed * delta
	if heat <0:
		heat = 0
	
	TotalHeat = heat
	TotalHeat =TotalHeat/(PartsCount+1)
	
	$core/Polygon2D.color.a= (heat * colmult)/maxheat
	
	acceleration = (Global.Player.position - position).normalized()*speed
	applied_torque = get_angle_to(linear_velocity+global_position) * 20
	applied_force = acceleration

func damage(dmg):
	hp-=dmg * (1+heat / (maxheat/7))
	if hp<=0:
		var dpi = dethparticles.instance()
		dpi.position = position
		Global.main.spawninst(dpi)
		
		get_tree().queue_delete(self)
