extends Node


onready var sfx_node = $SfxPlayer
onready var music_node = $MusicPlayer

var is_game_over = false

# Necessary to replace null with a proper preload("res://...")
var music_game_music = preload("res://assets/music/ambinent_sound.mp3")

var sfx_enemy_breathing = preload("res://assets/sfx/enemy_breathing.mp3")
var sfx_enemy_scream = preload("res://assets/sfx/enemy_scream.mp3")
var sfx_envelope_fill = preload("res://assets/sfx/envelope_fill.mp3")
var sfx_player_hit = preload("res://assets/sfx/player_hit.mp3")
var sfx_player_walk = preload("res://assets/sfx/player_walk.mp3")
var sfx_weapon_hit = preload("res://assets/sfx/weapon_hit.mp3")
var sfx_weapon_pickup = preload("res://assets/sfx/weapon_pickup.mp3")
var sfx_weapon_swing = preload("res://assets/sfx/weapon_swing.mp3")


func play_music():
	music_node.stream = music_game_music
	music_node.play()
	

func stop_music():
	music_node.stop()


func play_sound(sfx_name):
	match(sfx_name):
		"enemy_breathing":
			sfx_node.stream = sfx_enemy_breathing
			sfx_node.play()
		"enemy_scream":
			sfx_node.stream = sfx_enemy_scream
			sfx_node.play()
		"envelope_fill":
			sfx_node.stream = sfx_envelope_fill
			sfx_node.play()
		"player_hit":
			sfx_node.stream = sfx_player_hit
			sfx_node.play()
		"player_walk":
			sfx_node.stream = sfx_player_walk
			sfx_node.play()
		"weapon_hit":
			sfx_node.stream = sfx_weapon_hit
			sfx_node.play()
		"weapon_pickup":
			sfx_node.stream = sfx_weapon_pickup
			sfx_node.play()
		"weapon_swing":
			sfx_node.stream = sfx_weapon_swing
			sfx_node.play()


func stop_sound(sfx_name):
	match(sfx_name):
		"player_walk":
			sfx_node.stream = sfx_player_walk
			sfx_node.stop()
