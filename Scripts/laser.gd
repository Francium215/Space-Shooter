extends Area2D

@export var speed = 500
var direction


func _ready():
	var tween = create_tween()
	# tween the thing (sprite) by using the scale attribute, aiming for the scale of 1,1, starting at 0,0, over however long (in seconds)
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), 0.2).from(Vector2(0,0))

func _process(delta):
	global_position += direction * speed * delta
	
func move_to(pos):
	direction = (pos - global_position).normalized()
	
