extends KinematicBody2D
var hp = 10
var speed = 1
var coldmg = 1
func _physics_process(delta):
	
	rotation += 2*delta
	move_and_collide((Global.center - position).normalized()*speed)
func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
