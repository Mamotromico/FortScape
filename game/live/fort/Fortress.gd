extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal updateDurability

var durability = 200
var speed = 100
var energy = 50

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	
func _input(event):
	if(event.is_action_pressed("Defense_Overlay")):
		get_tree().call_group(0,"TurretCtrl","toggleVisible")
		
func explodes():
	durability -= 8
	emit_signal("updateDurability",durability)
	if(durability <= 0):
		get_tree().change_scene("res://GameOver")
	