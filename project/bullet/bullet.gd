extends KinematicBody2D
var velocity = Vector2()
var dmg = 1
func _ready():
	scale.x = velocity.length()/ 25
	rotation = get_angle_to(velocity)
func _physics_process(delta):
	move_and_collide(velocity)


func _on_Area2D_body_entered(body):
	if body.is_in_group("enemies"):
		body.damage(dmg)
	get_tree().queue_delete(self)
