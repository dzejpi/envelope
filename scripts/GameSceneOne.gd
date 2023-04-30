extends Spatial

onready var player = $Player
onready var enemy = $Enemy

onready var building = $Buildings/Building
onready var building_2 = $Buildings/Building2
onready var building_3 = $Buildings/Building3
onready var building_4 = $Buildings/Building4
onready var building_5 = $Buildings/Building5
onready var building_6 = $Buildings/Building6
onready var building_7 = $Buildings/Building7
onready var building_8 = $Buildings/Building8
onready var building_9 = $Buildings/Building9
onready var building_10 = $Buildings/Building10
onready var building_11 = $Buildings/Building11
onready var building_12 = $Buildings/Building12
onready var building_13 = $Buildings/Building13
onready var building_14 = $Buildings/Building14
onready var building_15 = $Buildings/Building15
onready var building_16 = $Buildings/Building16
onready var building_17 = $Buildings/Building17
onready var building_18 = $Buildings/Building18


var is_event_triggered = false

var is_first_task_complete = false
var is_second_task_complete = false
var is_third_task_complete = false
var is_fourth_task_complete = false
var is_fifth_task_complete = false
var is_sixth_task_complete = false
var is_seventh_task_complete = false
var is_eighth_task_complete = false
var is_ninth_task_complete = false
var is_tenth_task_complete = false

var hideouts = []


func _ready():
	get_all_hideouts()
	player.typewriter_dialog.start_dialog(["Oh great, fence doors closed on their own behind me. But I am sure someone will help me to open them. \n ~~~ Press 'E' to display the whole dialog or skip to the next line. ~~~", "Seems that they are taking their security extra seriously here. Good for them. \n \n ~~~ If you don't use 'E', dialog will skip to the next line on its own too ~~~", "I have some stuff to deliver, thankfully buildings have numbers on them, so I can find out which building do I need.", "I need to deliver letters and magazines for all letter boxes in building 10. Hm... where is it?"], get_process_delta_time())
	player.update_current_task("Deliver mail in the building 10.")


func _process(delta):
	if player.is_debug_triggered:
		if !is_event_triggered:
			is_event_triggered = true
			enemy.is_attacking_player = true
			
	process_current_tasks()
	
	
func process_current_tasks():
	# Start, player needs to complete the full building 10
	if !is_first_task_complete:
		if building.is_whole_building_complete:
			is_first_task_complete = true
			player.typewriter_dialog.start_dialog(["Nice. That was a lot of boxes.", "The next building is 30... for some reason.", "God, these old Soviet apartment complexes are creepy."], get_process_delta_time())
			player.update_current_task("Deliver stuff for the building 30.")
			
	if !is_second_task_complete:
		if building_9.is_whole_building_complete:
			is_second_task_complete = true
			player.typewriter_dialog.start_dialog(["Next building... 41. Where is it?", "This shift will never end."], get_process_delta_time())
			player.update_current_task("Deliver stuff for the building 41.")

func get_all_hideouts():
	for node in get_tree().get_nodes_in_group("group_hideout"):
		hideouts.append(node)
		enemy.hideouts.append(node)
	
	enemy.find_closest_hideout(enemy.global_transform.origin)
