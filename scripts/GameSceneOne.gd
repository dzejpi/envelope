extends Spatial

onready var player = $Player
onready var enemy = $Enemy


var hideouts = []


func _ready():
	get_all_hideouts()
	
	
func get_all_hideouts():
	for node in get_tree().get_nodes_in_group("group_hideout"):
		hideouts.append(node)
		enemy.hideouts.append(node)
	
	enemy.find_closest_hideout(enemy.global_transform.origin)
