extends Particles2D
func _physics_process(delta):
	if !emitting:
		get_tree().queue_delete(self)
