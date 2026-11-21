extends CanvasLayer

static var image = load('res://graphics/lives/playerLife1_red.png')
var time_elapsed := 0

func set_health(health):
	# remove all children
	for child in $"Health Icons/HBoxContainer".get_children():
		child.queue_free()
	
	# create new children set by health
	for i in health:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$"Health Icons/HBoxContainer".add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP


func _on_score_timer_timeout() -> void:
	time_elapsed += 1
	$Score/Label.text = str(time_elapsed)
	Global.score = time_elapsed
