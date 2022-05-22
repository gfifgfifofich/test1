extends KinematicBody2D

var speed = 10
func _physics_process(delta):
	move_and_collide((Global.center - position).normalized()*speed)
