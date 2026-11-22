extends CharacterBody2D

@export var speed := 500
var can_shoot: bool = true
var blue: String = "res://graphics/ship/playerShip1_blue.png"
var red: String = "res://graphics/ship/playerShip1_red.png"
var green: String = "res://graphics/ship/playerShip1_green.png"
var orange: String = "res://graphics/ship/playerShip1_orange.png"

var color: String = "red"
signal laser(pos, color)
var can_powerup: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(500,500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if Input.is_action_just_pressed("change_color"):
		if Input.is_key_pressed(KEY_LEFT):
			$PlayerImage.texture = load(blue)
			color = "blue"
		if Input.is_key_pressed(KEY_DOWN):
			$PlayerImage.texture = load(red)
			color = "red"
		if Input.is_key_pressed(KEY_RIGHT):
			$PlayerImage.texture = load(green)
			color = "green"
		if Input.is_key_pressed(KEY_UP):
			$PlayerImage.texture = load(orange)
			color = "orange"
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPos.global_position, color)
		can_shoot = false
		$LaserTimer.start()
		$LaserSound.play()
	
	if Input.is_action_just_pressed("powerup") and can_powerup == true:
		print("powerup")
		powerup("invincibility")
		can_powerup = false

func play_collision_sound():
	$DamageSound.play()

func _on_laser_timer_timeout() -> void:
	can_shoot = true

func _on_powerup_timer_timeout() -> void:
	can_powerup = true

func powerup(type):
	if type == "shoot_speed":
		$LaserTimer.wait_time = .25
		$PowerupUptime.start()
	if type == "invincibility":
		Global.can_collide = false
		$PowerupUptime.start()
		pass

func _on_powerup_uptime_timeout() -> void:
	$LaserTimer.wait_time = .5
	Global.can_collide = true
