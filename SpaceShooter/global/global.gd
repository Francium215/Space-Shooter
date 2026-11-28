extends Node

var score := 0
var can_collide := true
var can_powerup: bool = false
var broken_meteors: int = 0

#can be shield or shoot_speed
var what_powerup: String
