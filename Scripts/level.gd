extends Node2D

var meteor_scene: PackedScene = load("res://Scenes/meteor.tscn")
var red_laser: PackedScene = load("res://Scenes/red_laser.tscn")
var blue_laser: PackedScene = load("res://Scenes/blue_laser.tscn")
var green_laser: PackedScene = load("res://Scenes/green_laser.tscn")
var orange_laser: PackedScene = load("res://Scenes/orange_laser.tscn")



var health: int = 3

func _ready():
	#health ui
	get_tree().call_group('ui', 'set_health', health)
	# stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		
		# scale
		var random_scale = rng.randf_range(1, 2)
		star.scale = Vector2(random_scale, random_scale)
		# animation speed
		star.speed_scale = rng.randf_range(0.6, 1.4)

func _on_meteor_timer_timeout() -> void:
	# spawning meteor and adding it as a child
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
	#recieve the signal "collision" from meteor script, add a parameter that runs a function
	meteor.connect('collision', _on_meteor_collision)

# run the function sent by the signal
func _on_meteor_collision():
	health -= 1 
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		# it just doesnt like the "change_scene_to_file" action without call deferred idk what that really means though
		get_tree().call_deferred("change_scene_to_file", "res://Scenes/game_over.tscn")
	$Player.play_collision_sound()


func _on_player_laser(pos, color) -> void:
	var laser
	if color == "red":
		laser = red_laser.instantiate()
	elif color == "blue":
		laser = blue_laser.instantiate()
	elif color == "green":
		laser = green_laser.instantiate()
	elif color == "orange":
		laser = orange_laser.instantiate()
	else:
		return
	spawn_laser(laser, pos)

func spawn_laser(laser, pos):
	$Lasers.add_child(laser)
	laser.position = pos
	laser.move_to(get_viewport().get_mouse_position())
