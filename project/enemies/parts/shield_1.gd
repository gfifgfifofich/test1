extends KinematicBody2D
var hp = 5
var coldmg = 1
func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
