extends Node

export var Orb: PackedScene

var orb_count = 0

func add_orb(ground_orb):
	orb_count += 1
	var orb = Orb.instance()
	if ground_orb:
		orb.color = ground_orb.color
	orb.initial_angle = find_hole()
	reposition_orbs()
	add_child(orb)
	
func remove_orb():
	if orb_count > 0:
		var orb = get_children()[0]
		orb.die()
		orb_count -= 1
		if orb_count > 0:
			reposition_orbs()

func find_hole() -> float:
	var pos = []
	pos.resize(orb_count)
	var spacing = PI*2.0 / orb_count
	for orb in get_children():
		var offset = orb.get_offset_distance(spacing)
		var index = abs(fmod(offset + orb.rotation, 2*PI) / spacing)
		pos[index] = true
	#todo: bug here at around 16 orbs, it starts double placing
	for i in pos.size():
		if pos[i] == null:
			return spacing * i
	return 0.0

func reposition_orbs():
	var spacing = PI*2.0 / orb_count
	for orb in get_children():
		orb.reset_position(spacing)
