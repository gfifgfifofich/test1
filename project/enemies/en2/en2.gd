extends KinematicBody2D

#shooter component
var dmg = 1 # bullet damage
var bvel = 250 # bullet velocity
var expl = false # exploding?
var bscale = Vector2(1,1)# bullet scale
var explscale = Vector2(0,0) # explosion scale
var frate = float (1.0/4) # 1.0/(shots per sec) ((((1.0/4 == 4 shots / sec))))
# part component
var hp = 25
var coldmg = 0 # collision damage
var speed = 1
func _physics_process(delta):
	rotation = 0
	rotation = get_angle_to(Global.PlayerPosition)
	move_and_collide((Global.PlayerPosition - position).normalized()*speed)

func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
