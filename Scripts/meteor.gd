extends Area2D

var speed: int
var rotation_speed: int
var direction_x: float
signal collision
var colors: Array[Color] = [Color.RED, Color.BLUE, Color.DARK_GREEN, Color.ORANGE]

func _ready():
	var meteor_color = randi_range(0,3)
	$Sprite2D.material.set_shader_parameter('outline_color', colors[meteor_color])
	
	# randomizing the texture
	var path: String = "res://graphics/meteors/Meteor" + str(randi_range(1,6)) + ".png"
	$Sprite2D.texture = load(path)
	
	# gets width of screen, then uses a random number generator to make a random location
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = randi_range(0,width)
	var random_y = randi_range(-150,-50)
	position = Vector2(random_x, random_y)

	# speed, rotation, and direction
	speed = randi_range(200, 500)
	direction_x = randf_range(-1, 1)
	rotation_speed = randi_range(40, 100)

func _process(delta):
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta

#when body is entered, send the signal "collision" to level
func _on_body_entered(_body) -> void:
	if Global.can_collide:
		collision.emit()
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if !area.is_in_group("laser"):
		return
	
	if area.color == Laser.Colors.Red and $Sprite2D.material.get_shader_parameter("outline_color") == Color.RED:
		_kill(area)
	elif area.color == Laser.Colors.Blue and $Sprite2D.material.get_shader_parameter("outline_color") == Color.BLUE:
		_kill(area)
	elif area.color == Laser.Colors.Orange and $Sprite2D.material.get_shader_parameter("outline_color") == Color.ORANGE:
		_kill(area)
	elif area.color == Laser.Colors.Green and $Sprite2D.material.get_shader_parameter("outline_color") == Color.DARK_GREEN:
		_kill(area)

func _kill(area):
	Global.broken_meteors += 1
	area.queue_free()
	$ExplosionSound.play()
	$ExplosionSound.reparent(get_tree().current_scene)
	queue_free()
