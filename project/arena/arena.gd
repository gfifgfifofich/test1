extends Node2D

var en1 = preload("res://enemies/en1/en1.tscn")

var t = 0
func spawninst(inst):
	add_child(inst)

func SpawnEnemy(en):
	var eninst = en.instance()
	var rx = rand_range(-300,300) 
	var ry = rand_range(-150,150)
	if randf()>0.5:
		if randf()>0.5:
			eninst.position = Vector2(rx,-350)
		else:
			eninst.position = Vector2(rx,350)
	else:
		if randf()>0.5:
			eninst.position = Vector2(-500,ry)
		else:
			eninst.position = Vector2(500,ry)
	spawninst(eninst)


func _physics_process(delta):
	t+=delta
	if t>0.1:
		SpawnEnemy(en1)
		t=0
	pass
