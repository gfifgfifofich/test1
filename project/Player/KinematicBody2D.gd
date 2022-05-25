extends KinematicBody2D
var velocity=Vector2()
var shtp = preload("res://bullet/shotparticles.tscn")
var bullet = preload ("res://bullet/bullet.tscn")
var pp = Vector2()
var cp = Vector2()
var t =10
var hp=500
var maxhp=500
var speed = 1
var frate = float(6.0/7.0)
var dmgup =-1
var explscale = Vector2(4,4)
var bulvel = 500
var p =0
var coins =0
var dir = Vector2()
var shtdir = Vector2()
var bfire = false
var walking = false
var sm = [0,147,255]
var pist = true
var b = 1
var bpos =Vector2(0,0)
var cr=0
var pr=0
var colentimer = 30
var colcount = 0
var colbodarr = []
var vel = velocity
func _physics_process(delta):
	Global.PlayerPosition = position
	vel = velocity
	if hp>0:
		if colcount>0:
			colentimer-=1
			if colentimer<=0:
				for a in colbodarr:
					a.damage(2)
				colentimer=30
				damage(1)
		
		$wepbase.rotation = get_angle_to(get_global_mouse_position())+deg2rad(180)
		$Polygon2D.color.r8 = sm[0]
		$Polygon2D.color.g8= sm[1]
		$Polygon2D.color.b8 = sm[2]
		if !walking:
			if Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"):
				velocity.x=200*speed
				velocity.y=200*speed
			elif Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left"):
				velocity.x=-200*speed
				velocity.y=200*speed
			elif Input.is_action_pressed("ui_left")and Input.is_action_pressed("ui_up"):
				velocity.x=-200*speed
				velocity.y=-200*speed
			elif Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
				velocity.x=200*speed
				velocity.y=-200*speed
			elif Input.is_action_pressed("ui_right"):
				velocity.x=250*speed
			elif Input.is_action_pressed("ui_down"):
				velocity.y=250*speed
			elif Input.is_action_pressed("ui_left"):
				velocity.x=-250*speed
			elif Input.is_action_pressed("ui_up"):
				velocity.y=-250*speed
			
			if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
				velocity.x=0
			if not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
				velocity.y=0
		$wepbase/pistol.visible=pist
		$wepbase/grnl.visible=!pist
		t-=1
		if $wepbase/pistol/b1.position.x>2:
			$wepbase/pistol/b1.position.x-=0.4
		if $wepbase/pistol/b2.position.x>2:
			$wepbase/pistol/b2.position.x-=0.4
		if $wepbase/grnl/b1.position.x>4:
			$wepbase/grnl/b1.position.x-=0.2
		if Input.is_action_pressed("lmb")and t<=0 :
			var c = 1
			if frate>60:
				c=frate/60
			for i in range (0,c,1):
				if pist:
					var bvel = (get_global_mouse_position()-global_position).normalized()*bulvel+velocity/2
					t=10*frate
					if b==1:b=2;else:b=1
					if b==1:
						bpos = $wepbase/pistol/b1/bn.global_position
						$wepbase/pistol/b1.position.x=8
					elif b==2:
						bpos = $wepbase/pistol/b2/bn.global_position
						$wepbase/pistol/b2.position.x=8
					var shtpi = shtp.instance()
					shtpi.global_position = bpos
					shtpi.emitting=true
					shtpi.rotation = $wepbase.rotation+rotation
					Global.main.spawninst(shtpi)
					shoot(bpos,shtp,false,Vector2(0,0),bvel,Vector2(3,1.5))
				else:
					var bvel = (get_global_mouse_position()-global_position).normalized()*bulvel/2+velocity/2
					t=(10*frate)*10
					bpos = $wepbase/grnl/b1/bn.global_position
					$wepbase/grnl/b1.position.x=12
					shoot(bpos,shtp,true,explscale,bvel,Vector2(4,4))
		
		
		if !velocity==Vector2(0,0) and scale.y>0.4:
			scale.y-=0.02
		if velocity == Vector2(0,0) and scale.y<0.5:
			scale.y+=0.02
		pr= rotation
		rotation=0
		rotation = get_angle_to(position+velocity)
		cr=rotation
		$wepbase.rotation -= cr-pr
		move_and_slide(velocity,Vector2(0,1))
func shoot(pos,particles,expl,explsc,vel,sc):
	var shtpi = particles.instance()
	shtpi.position = pos
	shtpi.emitting=true
	shtpi.rotation = $wepbase.rotation+rotation
	Global.main.spawninst(shtpi)
	var spr = Vector2(rand_range(10,-10),rand_range(10,-10))
	if frate > 60:
		spr = Vector2(rand_range(100,-100),rand_range(100,-100))
	var bi = bullet.instance()
	var mult = 1
	bi.scale=scale
	bi.vel=vel
	bi.explsc = explsc
	if expl:
		mult = 1.25
		bi.boom=true
	bi.dmg=(dmgup+2)*mult
	bi.position=pos
	
	Global.main.spawninst(bi)


func damage(dmg):
	hp-=dmg
	#Main.updatehp()
	if hp<=0:
		#Main.updatehp()
		float(6.0/5.0)
		speed=1
		dmgup=0

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemies"):
		colcount+=1
		colbodarr.append(body)
		damage(body.coldmg)
		body.damage(dmgup)


func _on_Area2D_body_exited(body):
	if body.is_in_group("enemies"):
		colcount-=1
		colbodarr.remove(colbodarr.find(body))
