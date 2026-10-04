extends PanelContainer

@export var CurrentStrategicCamera : StrategicCamera

@export var BuildingNameLabel : Label

func _process(_Delta: float) -> void:
	var MousePosition : Vector2 = get_global_mouse_position()
	position = MousePosition
	
	if CurrentStrategicCamera == null or BuildingNameLabel == null:
		return
	
	var DetectionRayResult := CurrentStrategicCamera.get_colliders_from_mouse_raycast(0b00000100)
	if DetectionRayResult.is_empty():
		hide()
		
		return
	
	var DetectionRayCollider : Node3D = DetectionRayResult["collider"]
	if DetectionRayCollider is IBuildingClass:
		BuildingNameLabel.text = DetectionRayCollider.BuildingType
		
		show()
	else:
		hide()
