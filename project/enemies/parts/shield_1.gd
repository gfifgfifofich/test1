extends KinematicBody2D
var hp = 5

func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
