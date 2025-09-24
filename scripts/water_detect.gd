extends Area2D

signal entered_water
signal exited_water
var inwater = 0

func _on_area_entered(_area: Area2D) -> void:
	WaterDetect.inwater = 0
	exited_water.emit()
	
func _on_area_exited(_area: Area2D) -> void:
	WaterDetect.inwater = 1
	entered_water.emit()
