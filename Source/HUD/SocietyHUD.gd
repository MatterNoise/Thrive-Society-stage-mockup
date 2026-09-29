extends Control

signal OpenBuildSelectMenu

func _on_build_button_button_up() -> void:
	OpenBuildSelectMenu.emit()
