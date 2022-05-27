extends Area2D


var count = 0
var t = 0;
func _physics_process(delta):
	if count <0:
		count = 0
	if count == 0:
		$Polygon2D.visible = false
		t=0
	else:
		t+=delta*10
		$Polygon2D.visible = true
		$Polygon2D.color.r  = 1.0 + abs(sin(t)*0.1)

func _on_enwarning_body_entered(body):
	if body.is_in_group("enemies"):
		count+=1

func _on_enwarning_body_exited(body):
	if body.is_in_group("enemies"):
		count-=1
