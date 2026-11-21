extends Control

var level_scene: PackedScene = load("res://Scenes/level.tscn")

func _ready():
	$CenterText/VBoxContainer/Score.text = $CenterText/VBoxContainer/Score.text + str(Global.score)

func _input(event):
	if event.is_action_pressed('shoot'):
		get_tree().change_scene_to_packed(level_scene)
