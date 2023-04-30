extends KinematicBody


onready var player = $"../Player"
onready var enemy_ray_cast = $EnemyRayCast

var hideouts = []
var closest_hideout = null

var roof_y = 25
var ground_y = 0

var enemy_health = 100

var speed = 6
var jump = 6
var gravity = 16

var is_stalking_player = false
var is_at_edge = false

var is_attacking_player = true
var player_attacked = false

var is_going_to_hideout = false
var hideout_found = false
var is_in_hideout = false

var damage_taken = false

var is_climbing = false

var is_on_ground = true

var is_alive = true

# Name of the observed object for debugging purposes
var observed_object = "" 

func _ready():
	pass


func _process(delta):
	if is_attacking_player:
		look_at_player()
		move_forward(delta)
	
	if is_going_to_hideout:
		look_at_hideout()
		move_forward(delta)
		
	if is_in_hideout:
		stalk_player(delta)
	
	if enemy_ray_cast.is_colliding():
		var collision_object = enemy_ray_cast.get_collider().name
		var watched_object = enemy_ray_cast.get_collider()
		
		if collision_object != observed_object:
			observed_object = collision_object
			print("Enemy is looking at: " + observed_object + ".")
			process_enemy_action_on_object(observed_object, watched_object)
	else:
		var collision_object = "nothing"
		if collision_object != observed_object:
			observed_object = collision_object
			print("Enemy is looking at: nothing.")

func _physics_process(delta):
	pass


func stalk_player(delta):
	look_at_player()
	move_forward(delta)
	

func attack_player():
	pass


func run_aray():
	pass


func receive_damage(damage_amount):
	if !damage_taken:
		damage_taken = true
		enemy_health -= damage_amount
	
	if enemy_health <= 0:
		is_alive = false
		
	is_going_to_hideout = true
	player_attacked = true
	is_attacking_player = false
		
	print("Enemy was attacked. Health left: " + str(enemy_health))


# Rotate towards the player, useful for attacking, since it moves raycast too
func look_at_player():
	var target_pos = player.global_transform.origin
	look_at(target_pos, Vector3(0, 1, 0))
	rotation.x = 0
	rotation.z = 0


func look_at_hideout():
	var target_pos = closest_hideout.global_transform.origin
	look_at(target_pos, Vector3(0, 1, 0))
	rotation.x = 0
	rotation.z = 0


func move_forward(delta):
	if !is_climbing && !is_at_edge:
		var new_position = transform.origin + transform.basis.z * speed * delta * (-1)
		transform.origin = new_position
		
	if is_climbing:
		if transform.origin.y < roof_y:
			var new_position = transform.origin + transform.basis.y * speed * delta * (1)
			transform.origin = new_position
		else:
			is_climbing = false


func find_closest_hideout(current_enemy_position):
	print("Enemy is looking for the closest hideout")
	var closest_distance = float(1000000)
	
	for hideout in hideouts:
		var hideout_position = hideout.global_transform.origin
		var distance = hideout_position.distance_to(current_enemy_position)
		if distance < closest_distance:
			closest_hideout = hideout
			closest_distance = distance
			print("Closest hideout so far is: " + str(closest_hideout))
			print("Closest distance so far is: " + str(closest_distance))


func process_enemy_action_on_object(observed_object, raycast_object):
	match(observed_object):
		"Player":
			if !player_attacked:
				raycast_object.receive_damage(20)
				player_attacked = true
				is_going_to_hideout = true
				is_attacking_player = false
		"Building":
			is_climbing = true
		"HideoutPlace":
			is_going_to_hideout = false
			is_in_hideout = true
		"BuildingEdge":
			is_at_edge = true
