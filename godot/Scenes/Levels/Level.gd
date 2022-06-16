extends Navigation2D

func _ready():
	LevelManager.register_level(self)
	LevelManager.register_nav2d(self)
