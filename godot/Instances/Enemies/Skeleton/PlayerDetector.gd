extends RayCast2D

var player
var max_distance = 50

func use_attack_distance():
	max_distance = 30

func _process(_delta):
	var cast_vect = global_position.direction_to(player.global_position) * max_distance
	set_cast_to(cast_vect)
