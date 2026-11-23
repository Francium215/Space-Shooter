class_name ObjectSpawner
extends Marker2D

@export var object_to_spawn: PackedScene
@export var spawn_time: float = 1.14

var shield_powerup: PackedScene = load("res://Scenes/shield_powerup.tscn")
var shoot_speed_powerup: PackedScene = load("res://Scenes/shoot_speed_powerup.tscn")

var spawned_object: Node2D = null
var current_time: float = 0

var amount_of_powerups = 2

func _ready() -> void:
	
	_spawn_object()

func _process(delta: float) -> void:
	if spawned_object != null:
		return
	current_time += delta
	if current_time >= spawn_time:
		_spawn_object()
		current_time = 0


func _spawn_object():
	
	var wanted_powerup = randi_range(1,amount_of_powerups)
	if wanted_powerup == 1:
		object_to_spawn = shield_powerup
	if wanted_powerup == 2:
		object_to_spawn = shoot_speed_powerup
	
	# if there is no scene assigned yet
	if object_to_spawn == null:
		return
	# if you already spawned one, dont do two
	if spawned_object != null:
		return
	spawned_object = object_to_spawn.instantiate()
	add_child(spawned_object)
