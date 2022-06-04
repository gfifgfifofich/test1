extends Particles2D
export var partamount = 32
func _ready():
	amount = partamount
	$Particles2D.amount = partamount /2
	$Particles2D2.amount = partamount
	emitting = true
	$Particles2D.emitting = true
	$Particles2D2.emitting = true
func _physics_process(delta):
	if !emitting and !$Particles2D.emitting:
		queue_free()
