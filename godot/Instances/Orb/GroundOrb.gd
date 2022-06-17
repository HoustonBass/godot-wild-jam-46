extends KinematicBody2D

onready var sprite = $Sprite
onready var hit_box: CollisionShape2D = $HitBox

var color: int = -1
var rng = RandomNumberGenerator.new()

var speed = 3.0
var velocity = Vector2.ZERO

var follow_player = false
var player = null

func _ready():
	rng.randomize()
	color = rng.randi_range(0, 7)
	sprite.frame = color

func _process(_delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)

func _on_MagnetizeArea_body_entered(body):
	if body.is_in_group("Player"):
		player = body

func _on_MagnetizeArea_body_exited(body):
	if body and body.is_in_group("Player"):
		player = null

func _on_CollectArea_body_entered(body):
	if body and body.is_in_group('Player'):
		body.gain_health(self)
		hit_box.call_deferred('set_disabled', true)
		call_deferred('queue_free')
