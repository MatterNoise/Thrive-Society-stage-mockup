extends Camera3D
class_name StrategicCamera

var PivotPosition : Vector3
var ZoomLevel : float = 4.0

func _ready() -> void:
	pass

func _process(_Delta : float) -> void:
	calculate_camera_position()
	process_camera_inputs()

func calculate_camera_position() -> void:
	global_position = PivotPosition
	
	global_position = PivotPosition + (Vector3(0, 8.0, 4.0) * ZoomLevel)
	
	look_at(PivotPosition)

func process_camera_inputs() -> void:
	if Input.is_action_pressed("Move_Left"):
		PivotPosition.x -= 1.0
	if Input.is_action_pressed("Move_Right"):
		PivotPosition.x += 1.0
	if Input.is_action_pressed("Move_Up"):
		PivotPosition.z -= 1.0
	if Input.is_action_pressed("Move_Down"):
		PivotPosition.z += 1.0
	
	if Input.is_action_pressed("Zoom_Out"):
		ZoomLevel -= 0.1
	if Input.is_action_pressed("Zoom_In"):
		ZoomLevel += 0.1
	
	ZoomLevel = clamp(ZoomLevel, 1.0, 10.0)

func get_colliders_from_mouse_raycast(RayCollisionMask : int = 0b00000001) -> Dictionary:
	var CameraWorld3D : World3D = get_world_3d()
	
	var ViewportMousePosition : Vector2 = get_viewport().get_mouse_position()
	
	var DetectionRayQueries := PhysicsRayQueryParameters3D.create(
		project_ray_origin(ViewportMousePosition),
		project_ray_normal(ViewportMousePosition) * 1000000,
		RayCollisionMask
	)
	
	var DetectionRayResult : Dictionary = CameraWorld3D.direct_space_state.intersect_ray(DetectionRayQueries)
	
	return DetectionRayResult
