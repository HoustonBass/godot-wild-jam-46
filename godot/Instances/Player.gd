extends KinematicBody2D

var speed = 60.0

func _process(delta):
	var movementDir = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		movementDir += Vector2.RIGHT
	if Input.is_action_pressed("ui_left"):
		movementDir += Vector2.LEFT
	if Input.is_action_pressed("ui_up"):
		movementDir += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		movementDir += Vector2.DOWN
	
	var vel = movementDir.normalized() * speed * delta
	var collision = self.move_and_collide(vel)
	print('nothing happened') if collision == null else print('Collided!')
	
	
