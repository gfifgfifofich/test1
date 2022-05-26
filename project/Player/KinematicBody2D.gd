extends KinematicBody2D
var velocity=Vector2()
var pp = Vector2()
var cp = Vector2()
var t =10
var hp=500
var maxhp=500
var speed = 1
var frate = float(6.0/15.0)
var dmg =1
var explscale = Vector2(4,4)
var bulvel = 500
var coins =0
var dir = Vector2()
var shtdir = Vector2()
var bfire = false
var walking = false
var sm = [0,147,255] # color of body
var pist = true # first / second weapon
var b = 1 # barrel
var bpos =Vector2(0,0)
var cr=0 # current rotation of body
var pr=0# previous rotation of body
var colentimer = 30
var colcount = 0
var colbodarr = []
var railcharge = 0
var heatlevel = [0,0,0,0,0]
func _physics_process(delta):
	Global.PlayerPosition = position
	Global.PlayerVelocity = velocity
	if hp>0:
		if colcount>0:
			colentimer-=1
			if colentimer<=0:
				for a in colbodarr:
					a.damage(2)
				colentimer=30
				damage(1)
		if Input.is_action_just_pressed("1"):
			pist = true
		if Input.is_action_just_pressed("2"):
			pist = false
		$wepbase.rotation = get_angle_to(get_global_mouse_position())+deg2rad(180)
		Global.PlayerLookDir = get_angle_to(get_global_mouse_position())+deg2rad(180)
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
		$wepbase/railgun.visible=!pist
		t-=1
		heatlevel[0] =($wepbase/pistol/pistol2/b1/heat.color.a + $wepbase/pistol/pistol1/b1/heat.color.a)/5
		if Input.is_action_pressed("lmb")and t<=0 :
			var c = 1
			if frate>60:
				c=frate/60
			for i in range (0,c,1):
				if pist:
					if $wepbase/pistol/pistol1.ready:
						$wepbase/pistol/pistol1.cooling = 0.15
					else: 
						$wepbase/pistol/pistol1.cooling = 0.45
					if $wepbase/pistol/pistol2.ready:
						$wepbase/pistol/pistol2.cooling = 0.15
					else: 
						$wepbase/pistol/pistol2.cooling = 0.45
					var bvel = (get_global_mouse_position()-global_position).normalized()*bulvel#+velocity/2
					t=10*frate
					if b==1:b=2;else:b=1
					if b==1:
						$wepbase/pistol/pistol1.shoot(dmg,bulvel,false,Vector2(1.5,0.75),Vector2(0,0)) #(damage, bullet velocity, explosive?, bullet scale, explosion scale)
					elif b==2:
						$wepbase/pistol/pistol2.shoot(dmg,bulvel,false,Vector2(1.5,0.75),Vector2(0,0))
					
				else:
					if $wepbase/railgun.ready:
						$wepbase/railgun.charging = true
						railcharge+=delta *5
						railcharge = min (railcharge, 5)
						$wepbase/railgun/b1/heat.color.a=railcharge/5
		if railcharge>0 and !Input.is_action_pressed("lmb") and !pist:
			$wepbase/railgun/b1/heat.color.a=railcharge/5
			$wepbase/railgun.shoot(dmg * railcharge * 2,bulvel,false,Vector2(1.5,railcharge),Vector2(0,0))
			$wepbase/railgun.ready = false
			$wepbase/railgun.charging = false
			railcharge = 0
		if !Input.is_action_pressed("lmb"):
			$wepbase/pistol/pistol1.cooling = 0.5
			$wepbase/pistol/pistol2.cooling = 0.5
		
		if !velocity==Vector2(0,0) and $Polygon2D.scale.y>0.8:
			$Polygon2D.scale.y-=0.02
			$CollisionShape2D.scale.y-=0.02
			$Area2D.scale.y-=0.02
		if velocity == Vector2(0,0) and $Polygon2D.scale.y<1.0:
			$Polygon2D.scale.y+=0.02
			$CollisionShape2D.scale.y+=0.02
			$Area2D.scale.y+=0.02
		pr= rotation
		rotation=0
		rotation = get_angle_to(position+velocity)
		cr=rotation
		$wepbase.rotation -= cr-pr
		move_and_slide(velocity,Vector2(0,1))



func damage(dmg):
	hp-=dmg
	#Main.updatehp()
	if hp<=0:
		#Main.updatehp()
		float(6.0/5.0)
		speed=1
		dmg=1

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemies") or body.is_in_group("parts"):
		colcount+=1
		colbodarr.append(body)
		damage(body.coldmg)
		body.damage(dmg)


func _on_Area2D_body_exited(body):
	if body.is_in_group("enemies"):
		colcount-=1
		colbodarr.remove(colbodarr.find(body))
