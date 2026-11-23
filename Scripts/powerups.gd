extends Node2D
enum Power_Type{
	Shield = 0,
	Shoot_Speed = 1
}
@export var power: Power_Type


func _on_area_2d_body_entered(_body: Node2D) -> void:
	Global.can_powerup = true
	if power == Power_Type.Shield:
		Global.what_powerup = "shield"
	if power == Power_Type.Shoot_Speed:
		Global.what_powerup = "shoot_speed"
	get_tree().call_group('ui', 'set_powerup', Global.what_powerup)
	queue_free()
