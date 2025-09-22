extends Area2D

signal entered_water
signal exited_water

func _on_area_entered(area: Area2D) -> void:
	exited_water.emit()
	
func _on_area_exited(area: Area2D) -> void:
	entered_water.emit()
