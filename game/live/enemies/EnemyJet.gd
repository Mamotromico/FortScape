extends KinematicBody2D

var shotReady = false
var targeting = RayCast2D.new()

var target = Vector2(0,0)
var movement = Vector2(0,0)
var speed = 300
var xMin = 140
var xMax = 1000
var yMin = 0
var yMax = 300
var path = Vector2Array()

var bomb = preload("res://live/enemies/Bomb.tscn")
var expl = preload("res://live/enemies/Explosion.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	get_node("reloadTime").connect("timeout",self,"reloadDone")
	get_node("reloadTime").start()
	targeting.set_enabled(true)
	add_child(targeting)
	targeting.set_cast_to(Vector2(-720, 720))
func _fixed_process(delta):
	if(path.size() > 1):
		var angle = get_angle_to(path[path.size()-2])
		movement.x = speed*sin(angle)           
		movement.y = speed*cos(angle)
		move(movement*delta)
		
		#shooting
		if(targeting.is_colliding()):
			if(targeting.get_collider().get_name() == "fortBody" && shotReady):
				bombsAway()
		
		if (get_pos().distance_to(path[path.size()-2]) < 20):
			path.remove(path.size() - 2)
	else:
		target.x = rand_range(xMin, xMax)       
		target.y = rand_range(yMin, yMax)
		var p = get_parent().get_simple_path(get_pos(),target)
		path = Array(p) #Vector2array too complex to use, convert to regular array
		path.invert()

func explodes():
	get_node("Sprite").set_hidden(true);
	var dies = expl.instance();
	dies.set_pos(get_global_pos())
	get_tree().get_root().add_child(dies)
	queue_free()
	
func reloadDone():
	print("TEMPO")
	get_node("reloadTime").set_wait_time(15)
	shotReady = true;
	get_node("reloadTime").start()
	
func bombsAway():
	shotReady = false
	get_node("reloadTime").start()
	var b = bomb.instance()
	b.set_pos(get_global_pos())
	get_tree().get_root().add_child(b)