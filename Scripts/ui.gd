extends CanvasLayer

static var health_image = load('res://graphics/lives/playerLife1_red.png')
static var shield_image = load("res://graphics/powerupBlue_shield.png")
static var shoot_speed_image = load("res://graphics/powerupYellow_bolt.png")


var time_elapsed := 0

func set_health(health):
	# remove all children
	for child in $"Health Icons/HBoxContainer".get_children():
		child.queue_free()
	
	# create new children set by health
	for i in health:
		create_ui_elements(health_image, $"Health Icons/HBoxContainer")

func set_powerup(type):
	for child in $Powerup/HBoxContainer.get_children():
		child.queue_free()
	if type == "shield":
		create_ui_elements(shield_image, $Powerup/HBoxContainer)
	if type == "shoot_speed":
		create_ui_elements(shoot_speed_image, $Powerup/HBoxContainer)
	if type == "null":
		return

func create_ui_elements(type, parent):
	var text_rect = TextureRect.new()
	text_rect.texture = type
	parent.add_child(text_rect)
	text_rect.stretch_mode = TextureRect.STRETCH_KEEP

func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$Score/Label.text = str(time_elapsed)
	Global.score = time_elapsed
