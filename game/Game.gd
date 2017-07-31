extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var currentEnemies = 0
var numEnemies = 0
var bgSpeed = 400
var minE = 3
var maxE = 10


var enemyJet = preload("res://live/enemies/EnemyJet.tscn")

func _ready():
	
	
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true)
	get_node("Gaem/Live/Fortress").connect("updateDurability",self,"updateDurBar")
	updateDurBar(get_node("Gaem/Live/Fortress").durability)
	get_node("assaultTime").connect("timeout",self,"commenceAssault")
	get_node("assaultTime").start()
	
	
func _process(delta):
	get_node("Camera2D").move_local_x(bgSpeed*delta)
	
func commenceAssault():
	get_node("assaultTime").set_wait_time(30)
	get_node("assaultTime").start()
	print("assault")
	numEnemies = floor(rand_range(minE,maxE))
	var t = Timer.new()
	t.set_wait_time(1)
	t.connect("timeout",self,"spawnJet",[t])
	add_child(t)
	t.start()
	minE += 2
	maxE += 2
	
func spawnJet(timer):
	print("spawned:"+str(currentEnemies)+" toSpawn:"+str(numEnemies))
	var jet = enemyJet.instance()
	jet.set_pos(Vector2(-30,rand_range(10,50)))
	get_node("Gaem/Zone").add_child(jet)
	currentEnemies += 1
	if (numEnemies == currentEnemies):
		timer.stop()
		timer.queue_free()
		
func updateDurBar(value):
	get_node("Gaem/Hud/Stats/Container/TextureProgress").set_value(value)