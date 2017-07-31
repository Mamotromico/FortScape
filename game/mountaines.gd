extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var montaines = preload("res://montaines.tscn")
var putNew = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_fixed_process(true)
	
func _fixed_process(delta):
	var relativePos = get_pos().x + get_viewport().get_canvas_transform()[2].x*0.4
#	print(get_viewport().get_canvas_transform()[2].x)
#	print("ground: "+str(relativePos))
	if (relativePos < -1000 && !putNew):
		var s = montaines.instance()
		s.set_pos(Vector2(get_pos().x + 2560, get_pos().y))
		get_parent().add_child(s)
		putNew = true
	if(relativePos < -2600):
		queue_free()
