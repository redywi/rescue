extends Label

var time_s = 175

func _ready():
	set_text(time_format(time_s))
	set_process(true)
	
func _process(delta):
	if time_s > 0:
		time_s -= delta
		set_text(time_format(time_s))
	else:
		global.you_won = true
		
func time_format(time_s):
	var minutes = int(time_s) / 60
	var sec = int(time_s) % 60
	
	return str(minutes).pad_zeros(2) + ":" + str(sec).pad_zeros(2)
