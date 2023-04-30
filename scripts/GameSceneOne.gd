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

var has_creature_howled = false
var howling_timeout = 15

var initial_attack_timeout = 20
var has_creature_started_attacking = false

var attack_player_continuously = false
var continuous_attack_countdown = 5

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
	
	if attack_player_continuously:
		attack_player_continuously()
	
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

	if !is_third_task_complete:
		if is_second_task_complete && !has_creature_howled:
			if howling_timeout > 0:
				howling_timeout -= (1 * get_process_delta_time())
			else:
				has_creature_howled = true
				global_var.play_sound("enemy_scream")
				player.typewriter_dialog.start_dialog(["What the hell was that?!", "I need to finish my work as quickly as possible and get the hell out."], get_process_delta_time())

	if !is_fourth_task_complete:
		if building_6.is_first_row_full or building_6.is_second_row_full or building_6.is_third_row_full or building_6.is_fourth_row_full:
			is_fourth_task_complete = true
			player.typewriter_dialog.start_dialog(["That's good enough, really. I bet there was nothing important for them anyway.", "Now, the next building is 20."], get_process_delta_time())
			player.update_current_task("Deliver stuff for the building 20.")

	if !is_fifth_task_complete:
		if is_fourth_task_complete:
			if initial_attack_timeout > 0:
				initial_attack_timeout -= (1 * get_process_delta_time())
			else:
				if !has_creature_started_attacking:
					has_creature_started_attacking = true
					enemy.is_attacking_player = true
					
			if player.player_health < 90:
				is_fifth_task_complete = true
				player.is_able_to_pick_weapons = true
				player.typewriter_dialog.start_dialog(["WHAT THE HELL WAS THAT?", "I am bleeding. WHAT THE HELL!", "I am bleeding for real!", "Alright, calm down. Maybe it was just some hallucitation.", "Yes... probably. I need to get some weapon to be extra sure though."], get_process_delta_time())
				player.update_current_task("Find some weapon. It's watching.")

	if !is_sixth_task_complete:
		if is_fifth_task_complete:
			if player.current_weapon != 0:
				player.typewriter_dialog.start_dialog(["Thank god, this will do.", "It seems that the bleeding stopped.", "I only have two buildings to deliver the mail to, this one is building number 20.", "If that wasn't just a dream... I will need to find someone to open the gate for me. Why is nobody outside?"], get_process_delta_time())
				player.update_current_task("Deliver stuff for the building 20.")
				is_sixth_task_complete = true

	if !is_seventh_task_complete:
		if is_sixth_task_complete:
			if building_15.is_first_row_full or building_15.is_second_row_full or building_15.is_third_row_full or building_15.is_fourth_row_full:
				player.typewriter_dialog.start_dialog(["This will do, I bet the management will understand.", "Now, I just need a building 53. And next time, I will prepare my mails in the order... if I ever get back here."], get_process_delta_time())
				global_var.play_sound("enemy_scream")
				attack_player_continuously = true
				player.update_current_task("Defend yourself.")
				is_seventh_task_complete = true
				
	if !is_eighth_task_complete:
		if is_seventh_task_complete:
			if enemy.is_going_to_hideout:
				player.typewriter_dialog.start_dialog(["Goddamit, that was close.", "So, this is real. I have to get the hell out of here as quickly as possible, screw letters and screw this thing."], get_process_delta_time())
				global_var.play_sound("")
				player.update_current_task("Get the hell out.")
				is_eighth_task_complete = true
				
	if !is_ninth_task_complete:
		if is_eighth_task_complete:
			player.player_health < 50
			player.update_current_task("Survive.")
	

func get_all_hideouts():
	for node in get_tree().get_nodes_in_group("group_hideout"):
		hideouts.append(node)
		enemy.hideouts.append(node)
	
	enemy.find_closest_hideout(enemy.global_transform.origin)


func attack_player_continuously():
	if enemy.is_in_hideout:
		if continuous_attack_countdown > 0:
			continuous_attack_countdown -= (1 * get_process_delta_time())
		else:
			continuous_attack_countdown = 10
			enemy.is_attacking_player = true
