extends CharacterBody2D

@export var speed: int = 40000
var can_shoot: bool = true
var blue: String = "res://SpaceShooter/graphics/ship/playerShip1_blue.png"
var red: String = "res://SpaceShooter/graphics/ship/playerShip1_red.png"
var green: String = "res://SpaceShooter/graphics/ship/playerShip1_green.png"
var orange: String = "res://SpaceShooter/graphics/ship/playerShip1_orange.png"

var how_much_damage: int = 1
var color: String = "red"
signal laser(pos, color)
var powerup_uptime: int = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(500,500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed * _delta
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
	
	if Input.is_action_just_pressed("powerup") and Global.can_powerup == true:
		powerup(Global.what_powerup)
		Global.can_powerup = false
		get_tree().call_group('ui', 'set_powerup', "null")

func play_collision_sound():
	how_much_damage += 1
	var damage_texture: String = "res://SpaceShooter/graphics/playerShip1_damage" + str(how_much_damage) + ".png"
	if how_much_damage >= 4:
		return
	$Damage.texture = load(damage_texture)
	$DamageSound.play()

func _on_laser_timer_timeout() -> void:
	can_shoot = true

func powerup(type):
	if type == "shoot_speed":
		$LaserTimer.wait_time = .25
		await get_tree().create_timer(powerup_uptime).timeout
		$LaserTimer.wait_time = .5
	if type == "shield":
		Global.can_collide = false
		await get_tree().create_timer(powerup_uptime).timeout
		Global.can_collide = true
