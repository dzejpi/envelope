extends KinematicBody


onready var player_head = $PlayerHead
onready var ray = $PlayerHead/RayCast

onready var pause_scene = $UI/Pause/PauseScene
onready var game_over_scene = $UI/GameEnd/GameOverScene
onready var animation_player = $PlayerHead/PlayerCamera/AnimationPlayer
onready var player_camera = $PlayerHead/PlayerCamera

# UI
onready var player_ui = $UI/PlayerUI
onready var typewriter_dialog = $UI/PlayerUI/TypewriterDialog

var is_game_over = false

var speed = 6
var jump = 6
var gravity = 16

var basic_fov = 90
var increased_fov = 91
var current_fov = basic_fov

var ground_acceleration = 8
var air_acceleration = 2
var acceleration = ground_acceleration

var slide_prevention = 10
var mouse_sensitivity = 0.75

var direction = Vector3()
var velocity = Vector3()
var movement = Vector3()
var gravity_vector = Vector3()

var is_on_ground = true
var is_paused = false

# Name of the observed object for debugging purposes
var observed_object = "" 


func _ready():
	is_paused = false
	player_camera.fov = basic_fov
	current_fov = basic_fov
	pause_scene.is_game_paused = false
	pause_scene.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	check_game_end()


func _input(event):
	if !pause_scene.is_game_paused && !is_game_over:
		if event is InputEventMouseMotion:
			rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
			player_head.rotation_degrees.x = clamp(player_head.rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90)

		direction = Vector3()
		direction.z = -Input.get_action_strength("move_up") + Input.get_action_strength("move_down")
		direction.x = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
		direction = direction.normalized().rotated(Vector3.UP, rotation.y)
	
	# Handling the options menu
	if Input.is_action_just_pressed("game_pause"):
		if !is_game_over:
			handle_pause_change()


func _process(_delta):
	check_game_end()
	check_pause_update()
	
	# If player is looking at something
	if ray.is_colliding():
		var collision_object = ray.get_collider().name
		
		if collision_object != observed_object:
			observed_object = collision_object
			print("Player is looking at: " + observed_object + ".")
	else:
		var collision_object = "nothing"
		if collision_object != observed_object:
			observed_object = collision_object
			print("Player is looking at: nothing.")
	

func _physics_process(delta):
	if is_on_floor():
		gravity_vector = -get_floor_normal() * slide_prevention
		acceleration = ground_acceleration
		if !is_on_ground:
			animation_player.play("Jump Land")
		
		is_on_ground = true
	else:
		if is_on_ground:
			gravity_vector = Vector3.ZERO
			is_on_ground = false
		else:
			gravity_vector += Vector3.DOWN * gravity * delta
			acceleration = air_acceleration
	
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		is_on_ground = false
		gravity_vector = Vector3.UP * jump

	if Input.is_action_pressed("move_sprint"):
		increase_fov()
		velocity = velocity.linear_interpolate(direction * speed * 2, acceleration * delta)
	else:
		decrease_fov()
		velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	
	movement.z = velocity.z + gravity_vector.z
	movement.x = velocity.x + gravity_vector.x
	movement.y = gravity_vector.y
	
	var _player_movement = move_and_slide(movement, Vector3.UP)
	
	if !is_game_over && !is_paused:
		if direction != Vector3():
			animation_player.play("Head Bob")
	

func check_pause_update():
	if is_paused != pause_scene.is_game_paused:
		handle_on_click_pause_change()


func handle_on_click_pause_change():
	if pause_scene.is_game_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		is_paused = pause_scene.is_game_paused
			
		pause_scene.show()
		player_ui.hide()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_paused = pause_scene.is_game_paused
	
		pause_scene.hide()
		player_ui.show()


func handle_pause_change():
	if pause_scene.is_game_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_scene.is_game_paused = false
		is_paused = pause_scene.is_game_paused
			
		pause_scene.hide()
		player_ui.show()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_scene.is_game_paused = true
		is_paused = pause_scene.is_game_paused
	
		pause_scene.show()
		player_ui.hide()


func check_game_end():
	if is_game_over:
		game_over_scene.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_scene.is_game_paused = false
		pause_scene.hide()
		player_ui.hide()
	else:
		game_over_scene.hide()


func increase_fov():
	current_fov = player_camera.fov
	
	if current_fov < increased_fov:
		current_fov += 0.1
		change_fov(current_fov)
	

func decrease_fov():
	current_fov = player_camera.fov
	
	if current_fov > basic_fov:
		current_fov -= 0.2
		change_fov(current_fov)


func change_fov(player_current_fov):
	player_camera.fov = player_current_fov
