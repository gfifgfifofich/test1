extends KinematicBody2D
var hp = 15
var coldmg = 0
var t= 0 
func _physics_process(delta):
	t+=delta
	if t >= get_parent().frate:
		t=0
		for i in range(0,get_child_count(),1):
			if get_child(i).name !="CollisionShape2D" and get_child(i).name !="Polygon2D":
				get_child(i).shoot(get_parent().dmg,get_parent().bvel,get_parent().expl,get_parent().bscale,get_parent().explscale)
	rotation = 0
	rotation = get_angle_to(Global.PlayerPosition)

func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
