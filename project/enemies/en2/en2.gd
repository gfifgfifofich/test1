extends KinematicBody2D

#shooter component
var dmg = 1 # bullet damage
var bvel = 250 # bullet velocity
var expl = false # exploding?
var bscale = Vector2(1,1)# bullet scale
var explscale = Vector2(0,0) # explosion scale
var frate = float (1.0/4) # 1.0/(shots per sec) ((((1.0/4 == 4 shots / sec))))
# part component
var hp = 25
var coldmg = 0 # collision damage
var speed = 1
var acceleration
var velocity = Vector2(0,0)
func _physics_process(delta):
	if  is_on_ceiling() or is_on_floor():
		position += (Global.center - position).normalized() * 10
		print("ceilfloor")
		velocity.y *=-0.1  
	elif  is_on_wall():
		position += (Global.center - position).normalized() * 10
		print("WALL")
		velocity.x *=-0.1  
	
		
		
	rotation = 0
	rotation = get_angle_to(global_position+velocity)
	acceleration = (Global.PlayerPosition - position).normalized()*speed
	velocity += acceleration
	move_and_slide_with_snap(velocity,Vector2(0,1),Vector2(0,-1))

func damage(dmg):
	hp-=dmg
	if hp<=0:
		get_tree().queue_delete(self)
