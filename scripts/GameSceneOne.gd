extends Spatial

onready var player = $Player
onready var enemy = $Enemy


var hideouts = []


func _ready():
	get_all_hideouts()
	player.typewriter_dialog.start_dialog(["Fence closed on its own behind me. But I am sure someone will help me to open it.", "Seems that they are taking their security extra seriously here. Good for them."], get_process_delta_time())
	
	
func get_all_hideouts():
	for node in get_tree().get_nodes_in_group("group_hideout"):
		hideouts.append(node)
		enemy.hideouts.append(node)
	
	enemy.find_closest_hideout(enemy.global_transform.origin)


