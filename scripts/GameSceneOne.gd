extends Spatial

onready var player = $Player
onready var enemy = $Enemy

var is_event_triggered = false


var hideouts = []


func _ready():
	get_all_hideouts()
	player.typewriter_dialog.start_dialog(["Oh great, fence doors closed on their own behind me. But I am sure someone will help me to open them. \n ~~~ Press 'E' to display the whole dialog or skip to the next line. ~~~", "Seems that they are taking their security extra seriously here. Good for them. \n \n ~~~ If you don't use 'E', dialog will skip to the next line on its own too ~~~", "I have some stuff to deliver, thankfully buildings have numbers on them, so I can find out which building do I need.", "I need to deliver letters and magazines for all letter boxes in building 10. Hm... where is it?"], get_process_delta_time())
	
func _process(delta):
	if player.is_debug_triggered:
		if !is_event_triggered:
			is_event_triggered = true
			enemy.is_attacking_player = true
 

func get_all_hideouts():
	for node in get_tree().get_nodes_in_group("group_hideout"):
		hideouts.append(node)
		enemy.hideouts.append(node)
	
	enemy.find_closest_hideout(enemy.global_transform.origin)
