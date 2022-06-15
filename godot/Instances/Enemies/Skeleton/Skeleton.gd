extends Node2D

var speed = 1

func _on_HitBox_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Players"):
		body.take_damage()


func _on_DetectPlayer_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Players"):
		
