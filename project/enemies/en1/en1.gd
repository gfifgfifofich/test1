extends KinematicBody2D
export var dethparticles = preload("res://enemies/particles/destroy.tscn")

export var hp = 10
export var speed = 1
#shooter component
export var dmg = 1 # bullet damage
var bvel = 250 # bullet velocity
export var expl = false # exploding?
var bscale = Vector2(1,1)# bullet scale
var explscale = Vector2(0,0) # explosion scale
export var frate = float (1.0/4) # 1.0/(shots per sec) ((((1.0/4 == 4 shots / sec))))
var coldmg = 1

var heat = 0
var maxheat = 2.0
var coolingspeed = 0.1
export var stockcoolingspeed = 0.1
var minr
var ming
var colmult = 1
var radiatorCount = 0

func _ready():
	minr = $Polygon2D.color.r
	ming = $Polygon2D.color.g
	colmult = minr

func _physics_process(delta):
	coolingspeed = stockcoolingspeed + 0.5 * radiatorCount
	if heat > maxheat/7:
		heat = maxheat/7
	if heat >0:
		heat -= coolingspeed * delta
	$Polygon2D.color.r= minr + heat/maxheat * colmult * 1.8
	$Polygon2D.color.g= ming + heat/maxheat / 2 * colmult * 1.8
	
	rotation += 4*delta
	move_and_collide((Global.Player.position - position).normalized()*speed)
func damage(dmg):
	hp-=dmg * (1+heat / (maxheat/7))
	if hp<=0:
		var dpi = dethparticles.instance()
		dpi.position = position
		Global.main.spawninst(dpi)
		
		get_tree().queue_delete(self)
