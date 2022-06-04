extends KinematicBody2D



func _on_Area2D_body_entered(body):
	if body.name == "player":
		body.coins+=1
		get_tree().queue_delete(self)
