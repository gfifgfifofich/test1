extends KinematicBody2D

func _ready():
	var i = rand_range(0,2)
	if (i==0):
		$Sprite.visible = true
	elif(i==1):
		$Sprite2.visible = true
	else:
		$Sprite3.visible = true

func _on_Area2D_body_entered(body):
	if body.name == "player":
		Global.money+=1
		get_tree().queue_delete(self)
