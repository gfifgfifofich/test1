extends KinematicBody2D
var hp = 15
var coldmg = 0
var t= 0
var found= false
var parent
func _ready():
	parent =get_parent()
	while !found:
		if parent.is_in_group("enemies"):
			found = true
		else:
			parent = parent.get_parent()
func _physics_process(delta):
	t+=delta
	if t >= parent.frate:
		t=0
		for i in range(0,get_child_count(),1):
			if get_child(i).name !="CollisionShape2D" and get_child(i).name !="Polygon2D":
				get_child(i).shoot(parent.dmg,parent.bvel,parent.expl,parent.bscale,parent.explscale)
	rotation = 0
	rotation = get_angle_to(Global.PlayerPosition)

func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
