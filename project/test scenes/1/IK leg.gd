extends Node2D
var speed =0.5
var cucles = 7
onready var np= $Polygon2D/Skeleton2D/Bone2D/Bone2D2/end.global_position # Vec2
onready var b1 = $Polygon2D/Skeleton2D/Bone2D#Obj
onready var b2 = $Polygon2D/Skeleton2D/Bone2D/Bone2D2#Obj


var currentlegposition = Vector2(0,0)
var Animlegposition = Vector2(0,0)

export var LegTarget = Vector2(70,-20)
export var ReversTarget = Vector2(-70,-20)
export var MaxDistCut = 0
export var LegPositionRandomness = 5
export var AnimationTime = 0.0
export var AnimationEndTime = 0.1
export var mirored = false
func _ready():
	currentlegposition=$legpos.global_position
	LegPositionRandomness*=global_scale.x
	MaxDistCut*=global_scale.x
	$targetnode/Target.position = LegTarget
	$targetnode/ReversTarget.position=ReversTarget
func _physics_process(delta):
	
	var Bone1L = b1.default_length*global_scale.x;
	var Bone2L = b2.default_length*global_scale.x;
	var leglength = Bone1L+Bone2L;
	
	
	var distance = (global_position - currentlegposition).length();
	
	
	
	
	$targetnode.rotation = get_parent().global_rotation;
	if distance>=leglength-MaxDistCut:
		if ($legpos.global_position-$targetnode/Target.global_position).length_squared()>($legpos.global_position-$targetnode/ReversTarget.global_position).length_squared():
			currentlegposition = $targetnode/Target.global_position +Vector2(rand_range(-LegPositionRandomness,LegPositionRandomness),rand_range(-LegPositionRandomness,LegPositionRandomness))
		else:
			currentlegposition = $targetnode/ReversTarget.global_position +Vector2(rand_range(-LegPositionRandomness,LegPositionRandomness),rand_range(-LegPositionRandomness,LegPositionRandomness))
		Animlegposition = $legpos.global_position 
		AnimationTime=0
	
	if AnimationTime<AnimationEndTime:
		AnimationTime+=delta;
		var stage = AnimationTime/AnimationEndTime;
		
		Animlegposition =Animlegposition*(1.0-stage) + currentlegposition*stage
		
	else:
		Animlegposition =currentlegposition
	
	
	$legpos.global_position = Animlegposition
	
	distance = (global_position - $legpos.global_position).length();
	
	b1.global_rotation=0;
	b2.global_rotation=0;
	global_rotation = 0;
	if distance<=Bone1L+Bone2L:
		if !mirored:
			b1.global_rotation = acos(distance/(2*Bone1L)) +get_angle_to($legpos.global_position);# WORKSSSS 
			b2.global_rotation =   asin(distance/(2*Bone2L)) +deg2rad(270)+ get_angle_to($legpos.global_position);# WORKSSSS
		else:
			b1.global_rotation = -acos(distance/(2*Bone1L)) +get_angle_to($legpos.global_position);# WORKSSSS 
			b2.global_rotation =   acos(distance/(2*Bone2L)) + get_angle_to($legpos.global_position);# WORKSSSS
	else:
		b1.global_rotation =get_angle_to($legpos.global_position) ;
	
	
	
	
	
	
	
	
	#$Polygon2D/Skeleton2D/Bone2D/Bone2D2.rotation +=0.1
	#$Polygon2D/Skeleton2D/Bone2D.rotation +=0.1
	#$Polygon2D/Skeleton2D/Bone2D/Bone2D2/Bone2D3.rotation =-$Polygon2D/Skeleton2D/Bone2D/Bone2D2.rotation - $Polygon2D/Skeleton2D/Bone2D.rotation + deg2rad(90)
