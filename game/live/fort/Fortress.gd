extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var durability = 200

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	set_process_input(true)
	
func _process(delta):
	pass
	
func _input(event):
	if(event.is_action_pressed("Defense_Overlay")):
		get_tree().call_group(0,"TurretCtrl","toggleVisible")
		
func explodes():
	durability -= 8
	if(durability <= 0):
		print("gameover")
	