extends Control

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
func _on_restart_pressed():
	get_tree().reload_current_scene()
