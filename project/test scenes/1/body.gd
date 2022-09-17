extends KinematicBody2D

var t = 0
var orbdist = 70
func _physics_process(delta):
	t+=delta
	position= Vector2(get_global_mouse_position())
	
