extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bullet = preload("res://live/fort/defenses/Shot.tscn")
var shotReady = true
var reloadTime = Timer.new()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization hee
	set_process(true)
	set_process_input(true)
	reloadTime.set_wait_time(5)
	reloadTime.set_one_shot(true)
	reloadTime.connect("timeout",self,"reloadShot")
	add_child(reloadTime)
	get_node("Flak/Reload").set_max(5)
	
func _process(delta):
	update()
	get_node("Flak/Reload").set_value(reloadTime.get_wait_time() - reloadTime.get_time_left())
	if(get_node("Flak/Btn").is_pressed()):
		#print(get_node("Base/AxisCannon").get_rot())
		get_node("Base/AxisCannon").look_at(get_global_mouse_pos())
		
	#DEBUG
		
	
func _draw():
	if(get_node("Flak").is_visible()):
		draw_line(get_node("Base").get_pos(), get_node("Flak").get_pos()+get_node("Flak").get_size()/2, Color("f2a828"), 2)
		
func _input(event):
	if(get_node("Flak/Btn").is_pressed() and event.is_action_pressed("Shoot") and !event.is_echo() and shotReady):
		justShootIt()
		
func justShootIt():
	var b = bullet.instance()
	b.set_rot(get_node("Base/AxisCannon").get_rot())
	b.set_pos(get_node("Base/AxisCannon/Cannon").get_global_pos())
	get_tree().get_root().get_node("Game/Gaem").add_child(b)
	shotReady = false;
	reloadTime.start()
	
func reloadShot():
	shotReady = true;