extends KinematicBody2D
export var dethparticles = preload("res://enemies/particles/destroy.tscn")

export var hp = 15
export var shooter = true
var coldmg = 0
var t= 0
var found= false
var parent

var heat = 0
var maxheat = 2.0 # "max" heat for color
var cooling = 1.0
var coolingmult = cooling
var minr
var ming
var colmult
var colormult = 1.0 # crude multiplier


func _ready():
	minr = $Polygon2D.color.r
	ming = $Polygon2D.color.g
	colmult = minr
	parent =get_parent()
	while !found:
		if parent.is_in_group("enemies"):
			found = true
		else:
			parent = parent.get_parent()
func _physics_process(delta):
	cooling = parent.coolingspeed * coolingmult
	if heat > maxheat/2.5:
		heat = maxheat/2.5
	if heat > 0:
		heat -= cooling * delta
	$Polygon2D.color.r= minr + (heat/maxheat * colmult * 1.8) * colormult
	$Polygon2D.color.g= ming + (heat/maxheat / 2 * colmult * 1.8) * colormult
	t+=delta
	if shooter:
		if t >= parent.frate:
			t=0
			for i in range(0,get_child_count(),1):
				if get_child(i).name !="CollisionShape2D" and get_child(i).name !="Polygon2D" and get_child(i).name !="shield":
					get_child(i).shoot(parent.dmg,parent.bvel,parent.expl,parent.bscale,parent.explscale)
	rotation = 0
	rotation = get_angle_to(Global.Player.position)

func damage(dmg):
	hp-=dmg * (1+heat / (maxheat/2.5))
	if hp<=0:
		die()
func die():
	var dpi = dethparticles.instance()
	dpi.position = global_position
	dpi.partamount = 5
	Global.main.spawninst(dpi)
	get_tree().queue_delete(self)
