extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var bullet = preload("res://live/fort/defenses/Shot.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization hee
	set_process(true)
	set_process_input(true)
	
func _process(delta):
	update()
	if(get_node("Flak/Btn").is_pressed()):
		#print(get_node("Base/AxisCannon").get_rot())
		get_node("Base/AxisCannon").look_at(get_global_mouse_pos())
	
func _draw():
	if(get_node("Flak").is_visible()):
		draw_line(get_node("Base").get_pos(), get_node("Flak").get_pos()+get_node("Flak").get_size()/2, Color("f2a828"), 2)
		
func _input(event):
	if(get_node("Flak/Btn").is_pressed() and event.is_action_pressed("Shoot") and !event.is_echo()):
		justShootIt()
		
func justShootIt():
	var b = bullet.instance()
	b.set_rot(get_node("Base/AxisCannon").get_rot())
	b.set_pos(get_node("Base/AxisCannon/Cannon").get_global_pos())
	get_tree().get_root().add_child(b)