extends KinematicBody2D

onready var hit_box: CollisionShape2D = $HitBox

var speed = 3.0
var velocity = Vector2.ZERO

var follow_player = false
var player = null

func _process(_delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)

func _on_MagnetizeArea_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player"):
		player = body


func _on_MagnetizeArea_body_shape_exited(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player"):
		player = null


func _on_CollectArea_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body.is_in_group("Player"):
		body.collect(self)
		hit_box.set_disabled(true)
