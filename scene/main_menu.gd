extends CenterContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()


func grab_focus():
	get_node("container/play").grab_focus()


func restart_button_active(state):
	get_node("container/reset").disabled = not state


func _on_exit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	visible = false
	get_node("../credits").visible = true
	get_node("../credits").grab_focus()


func _on_options_pressed():
	visible = false
	get_node("../options").visible = true
	get_node("../options").grab_focus()


func _on_play_pressed():
	get_node("/root/root").play()
	get_node("container/reset").visible = true
	get_node("container/play").text = "RESUME"
	get_node("../title").visible = false


func _on_reset_pressed():
	get_node("/root/root").restart()
