extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.connect("toggled",self,"disableBtns")

func disableBtns(event):
	var btnNodes = get_tree().get_nodes_in_group("TurretCtrl")
	for nd in btnNodes:
		if (nd.get_node("Btn") != self):
			nd.get_node("Btn").set_pressed(false)