extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var speed = 10

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	get_node("area").connect("body_enter",self,"killIt");
	
func _fixed_process(delta):
	move_local_y(speed);
	if(get_global_pos().x < 0 or 
	   get_global_pos().x > get_viewport().get_rect().size.width or 
	   get_global_pos().y < 0 ):
		queue_free()

func killIt(body):
	body.explodes()
	queue_free()
