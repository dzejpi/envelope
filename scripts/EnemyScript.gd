extends KinematicBody


onready var player = $"../Player"
onready var enemy_ray_cast = $EnemyRayCast

var health = 100

var speed = 6
var jump = 6
var gravity = 16

var is_stalking_player = false
var is_attacking_player = false
var player_attacked = false
var is_runnig_away_from_player = false
var is_climbing = false

var is_on_ground = true

var is_alive = true

# Name of the observed object for debugging purposes
var observed_object = "" 

#func _ready():
#	pass


func _process(delta):
	look_at_player()
	
	if enemy_ray_cast.is_colliding():
		var collision_object = enemy_ray_cast.get_collider().name
		var watched_object = enemy_ray_cast.get_collider()
		
		if collision_object != observed_object:
			observed_object = collision_object
			print("Enemy is looking at: " + observed_object + ".")
	else:
		var collision_object = "nothing"
		if collision_object != observed_object:
			observed_object = collision_object
			print("Enemy is looking at: nothing.")

func _physics_process(delta):
	pass


func stalk_player():
	pass
	

func attack_player():
	pass


func run_aray():
	pass


func receive_damage(damage_amount):
	health -= damage_amount
	
	if health <= 0:
		is_alive = false


# Necessary to always look towards the player, useful for attacking
func look_at_player():
	var target_pos = player.global_transform.origin
	look_at(target_pos, Vector3(0, 1, 0))
	rotation.x = 0
	rotation.z = 0


func move_forward(delta):
	var new_position = transform.origin + transform.basis.z * speed * delta * (-1)
	transform.origin = new_position
