extends Navigation2D

func _ready():
	LevelManager.register_level(self)
	LevelManager.register_nav2d(self)
	MusicPlayer.swap_to_track(MusicPlayer.Songs.Dungeon)
