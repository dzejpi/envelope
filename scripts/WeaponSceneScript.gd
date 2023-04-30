extends StaticBody


export var weapon_type = 1
onready var weapon_sprite = $WeaponSprite

var baseball_bat = preload("res://assets/visual/ui/weapons/ase_weapons_baseball_bat.png")
var crowbar = preload("res://assets/visual/ui/weapons/ase_weapons_crowbar.png") 
var wooden_plank = preload("res://assets/visual/ui/weapons/ase_weapons_wooden_plank.png")

var is_picked_up = false


func _ready():
	set_weapon_sprite()


func set_weapon_sprite():
	match(weapon_type):
		1:
			weapon_sprite.texture = baseball_bat
		2:
			weapon_sprite.texture = crowbar
		3:
			weapon_sprite.texture = wooden_plank

func pick_up():
	is_picked_up = true
	hide()
