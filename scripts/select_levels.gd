extends Control



func _ready():
	for i in range($Levels.get_child_count()):
		global.levels.append(i + 1)
	
	for level in $Levels.get_children():
		if level.name in range(global.unlocked_level + 1):
			pass
	print(range(global.unlocked_level + 1))
