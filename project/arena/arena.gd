extends Node2D

var en1 = preload("res://enemies/en1/en1.tscn")
var en2 = preload("res://enemies/en2/en2.tscn")

var enemiesArray = [[en1,1]] # [[enemy.tscn, cost]] ,[en2,2.5]

var enemiesCount = 5
var enemiesPoints = 5
var wave = 1



var t = 0

func _ready():
	Global.main = self
	$UI.scale=Vector2(1.3,1.3)

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
	#eninst.velocity = -eninst.position.normalized() * 50
	spawninst(eninst)

func nextWave():
	wave+=1
	enemiesCount = 5 * wave
	enemiesPoints = enemiesCount

func _physics_process(delta):
	t+=delta
	
	# UI stuff-------------------------
	$UI/health.scale.x = Global.Player.hp/Global.Player.maxhp
	
	$UI/heat1/heat.scale.y =  min(Global.Player.heatlevel[0],1.0)
	$UI/heat1/heat.color.r =  1.0 +Global.Player.heatlevel[0]/4
	$UI/heat2/heat.scale.y =  min(Global.Player.heatlevel[1],1.0)
	$UI/heat2/heat.color.r =  1.0 +Global.Player.heatlevel[1]/4
	
	$UI/heat3/heat.scale.y =  min(Global.Player.heatlevel[2],1.0)
	$UI/heat3/heat.color.r =  1.0 +Global.Player.heatlevel[2]*0.3
	
	# UI stuff-------------------------
	
	if t>1.0/(enemiesCount+((enemiesCount/10)*wave))  and enemiesPoints >=1:
		var i =rand_range(0,enemiesArray.size())
		var spawntrys = 0
		while enemiesArray[i][1] >enemiesPoints && spawntrys<10:# Randoming untill cost of choosed enemy< points 
			i =rand_range(0,enemiesArray.size())
			spawntrys+=1
			
		if spawntrys>=10: # if we havent finded in 10 tries - spawn red blob wich cost is 1
			i=0
			
		enemiesPoints -= enemiesArray[i][1]
		SpawnEnemy(enemiesArray[i][0])
		t=0
	if enemiesPoints <= 1 and get_tree().get_nodes_in_group("enemies").empty():
		nextWave()


func _on_Button_button_up(): # KILL ALL ENEMIES
	for en in get_tree().get_nodes_in_group("enemies"):
		en.queue_free()

