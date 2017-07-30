extends Node2D

export var cycleOffset = 0.0

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("1/SpriteAnim").seek(0.0+cycleOffset);
	get_node("2/SpriteAnim").seek(0.2+cycleOffset);
	get_node("3/SpriteAnim").seek(0.4+cycleOffset);
	get_node("4/SpriteAnim").seek(0.6+cycleOffset);
	get_node("5/SpriteAnim").seek(0.8+cycleOffset);
	get_node("6/SpriteAnim").seek(1+cycleOffset);
	get_node("7/SpriteAnim").seek(1.2+cycleOffset);
	
