extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var currentEnemies = 0
var numEnemies = 0

var enemyJet = preload("res://live/enemies/EnemyJet.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	get_node("assaultTime").connect("timeout",self,"commenceAssault")
	get_node("assaultTime").start()
	
func _process(delta):
	pass
	
func commenceAssault():
	print("assault")
	numEnemies = floor(rand_range(3,10))
	var t = Timer.new()
	t.set_wait_time(1)
	t.connect("timeout",self,"spawnJet",[t])
	add_child(t)
	t.start()
	
func spawnJet(timer):
	print("spawned:"+str(currentEnemies)+" toSpawn:"+str(numEnemies))
	var jet = enemyJet.instance()
	jet.set_pos(Vector2(-30,rand_range(10,50)))
	get_node("Zone").add_child(jet)
	currentEnemies += 1
	if (numEnemies == currentEnemies):
		timer.stop()
		timer.queue_free()