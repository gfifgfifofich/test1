extends Node2D

var en1 = preload("res://bullet/bullet.tscn")

var enemiesArray = [[en1,1]] # [[enemy.tscn, cost]]

var enemiesCount = 5
var enemiesPoints = 5
var wave = 1



var t = 0
func spawninst(inst):
	add_child(inst)

func SpawnEnemy(en):
	var eninst = en.instance()
	var rx = rand_range(-300,300) 
	var ry = rand_range(-150,150)
	if randf()>0.5:
		if randf()>0.5:
			eninst.position = Vector2(rx,-35)
		else:
			eninst.position = Vector2(rx,35)
	else:
		if randf()>0.5:
			eninst.position = Vector2(-50,ry)
		else:
			eninst.position = Vector2(50,ry)
	eninst.velocity = -eninst.position.normalized() * 50
	spawninst(eninst)

func nextWave():
	wave+=1
	enemiesCount += 5
	enemiesPoints = enemiesCount+((enemiesCount/10)*wave) 

func _physics_process(delta):
	t+=delta
	
	
	if t>1.0/(enemiesCount+((enemiesCount/10)*wave))  and enemiesPoints >=1:
		var i =rand_range(0,enemiesArray.size())
		var spawntrys = 0
		while enemiesArray[i][1] >enemiesPoints && spawntrys<10:# Randoming untill cost of choosed enemy< points 
			i =rand_range(0,enemiesArray.size())
			spawntrys+=1
		if spawntrys>=10: # if we havent finded in 10 tries - spawn red blob wich cost is 1
			i=0
		enemiesPoints -= enemiesArray[i][1]
		SpawnEnemy(en1)
		t=0
	if enemiesPoints <= 1 and get_tree().get_nodes_in_group("enemies").empty():
		nextWave()


func _on_Button_button_up(): # KILL ALL ENEMIES
	for en in get_tree().get_nodes_in_group("enemies"):
		en.queue_free()
