extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var gravity = 98
var speed = Vector2(-100,0)

var expl = preload("res://live/enemies/Explosion2.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	get_node("area").connect("body_enter",self,"killIt");
	
func _fixed_process(delta):
	speed.y += gravity*delta;
	set_pos(Vector2(get_pos().x + speed.x*delta, get_pos().y + speed.y*delta))
	if(get_global_pos().x < 0 or 
	   get_global_pos().x > get_viewport().get_rect().size.width or 
	   get_global_pos().y < 0 ):
		queue_free()

func killIt(body):
	if(body.get_name() == "fortBody"):
		body.get_parent().explodes()
		explodes()

func explodes():
	get_node("Sprite").set_hidden(true)
	var dies = expl.instance()
	dies.set_pos(get_global_pos())
	get_tree().get_root().add_child(dies)
	queue_free()