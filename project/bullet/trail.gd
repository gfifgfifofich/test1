extends Line2D
export var limited_lifetime = false
export var wildness = 3.0
export var min_spawn_distance = 5.0
export var max_points = 10

var lifetime=[0.2,0.2]
var tick_speed  = 0.00
var tick = 0.0
var wild_speed = 1.0
var privpos = Vector2()
var point_age=[0.0]
var stopped = false

onready var tween = $decay

func _ready():
	set_as_toplevel(true)
	if limited_lifetime:
		stop()
func stop():
	stopped = true
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, rand_range(lifetime[0], lifetime[1]), Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()

func add_point(point_pos:Vector2,at_pos:=-1):
	if get_point_count()>0 and point_pos.distance_to(points[get_point_count()-1])<min_spawn_distance:
		return
	if get_point_count()>max_points:
		remove_point(0)
		point_age.pop_front()
	point_age.append(0.0)
	.add_point(point_pos,at_pos)
func _on_decay_tween_all_completed():
	queue_free()
