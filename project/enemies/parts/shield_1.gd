extends KinematicBody2D
export var hp = 50
export var coldmg = 1

var heat = 0
var maxheat = 2.0
var cooling = 1.0
var coolingmult = cooling
var minr
var ming
var colmult # multiply to not get farther then 255
var colormult = 1.3 # crude multiplier

var parent
func _ready():
	minr = $Polygon2D.color.r
	ming = $Polygon2D.color.g
	colmult = minr
	parent =get_parent()
	var found = false
	while !found:
		if parent.is_in_group("enemies"):
			found = true
		else:
			parent = parent.get_parent()
func _physics_process(delta):
	cooling = parent.coolingspeed * coolingmult
	if heat > maxheat:
		heat = maxheat
	if heat >0:
		heat -= cooling * delta
	var heatcolor = (heat/maxheat) * colmult * colormult
	$Polygon2D.color.r= minr + heatcolor
	$Polygon2D.color.g= ming + heatcolor/2
	
func damage(dmg):
	hp-=dmg * (1+heat / maxheat)
	if hp<=0:
		get_tree().queue_delete(self)
