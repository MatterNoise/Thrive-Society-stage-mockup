extends Node

@export var PlayerCivilization : String = "PlayerCiv"

@export var CurrentStrategicCamera : StrategicCamera
@export var PlaceStructureNode : Node3D

@export var DebugRayInterset : MeshInstance3D

var InBuildStructureName : String

func _ready() -> void:
	CivilizationsInfo.declare_new_civilization_info(PlayerCivilization)
	
	CivilizationsInfo.CivilizationsInfoDictionary[PlayerCivilization].set_resource_amount_to_civ("Wood", 100)
	CivilizationsInfo.CivilizationsInfoDictionary[PlayerCivilization].set_resource_amount_to_civ("Stone", 100)
	
	create_new_building("SOCIETY_CENTER", Vector3.ZERO, PlayerCivilization)

func _process(_Delta : float) -> void:
	if CurrentStrategicCamera == null:
		return
	
	process_structure_ghost()
	process_structure_placement()
	
	
	
	#var CollidersFromMouseRay := CurrentStrategicCamera.get_colliders_from_mouse_raycast()
	#if CollidersFromMouseRay.is_empty() == true:
	#	return

func process_structure_ghost() -> void:
	if PlaceStructureNode == null:
		return
	
	PlaceStructureNode.position = CurrentStrategicCamera.WorldMousePosition

func process_structure_placement() -> void:
	if InBuildStructureName == "":
		return
	
	if Input.is_action_just_pressed("Mouse_Left_Click"):
		create_new_building(InBuildStructureName, CurrentStrategicCamera.WorldMousePosition, PlayerCivilization)
		
		cancel_building_construction()
	elif Input.is_action_just_pressed("Mouse_Right_Click"):
		cancel_building_construction()

func create_new_building(StructureName : String, AtPosition : Vector3, BuildingOwner : String, ResourceCostFree : bool = false) -> IBuildingClass:
	var StructureScene : PackedScene = StructuresDefinitions.get_structure_standart_model(StructureName)
	var StructureInstance : IBuildingClass = StructureScene.instantiate()
	
	StructureInstance.BuildingOwner = BuildingOwner
	StructureInstance.BuildingType = StructureName
	
	add_child(StructureInstance)
	
	StructureInstance.position = AtPosition
	
	CivilizationsInfo.add_building_to_civilization_info(BuildingOwner, StructureInstance)
	if ResourceCostFree == false:
		var BuildinRequirements := StructuresDefinitions.get_structure_building_requirements(StructureName)
		for ISpentResource in BuildinRequirements:
			CivilizationsInfo.CivilizationsInfoDictionary[BuildingOwner].add_resource_amount_to_civ(ISpentResource, -BuildinRequirements[ISpentResource])
	
	return StructureInstance

func cancel_building_construction() -> void:
	if PlaceStructureNode.get_child_count() < 1:
		return
	
	PlaceStructureNode.get_child(0).queue_free()
	InBuildStructureName = ""

func _on_building_selected(SelectedStructureDefsKey : String) -> void:
	if SelectedStructureDefsKey == "":
		return
	
	cancel_building_construction()
	
	var PlaceStructureModelScene : PackedScene = StructuresDefinitions.get_structure_ghost_model(SelectedStructureDefsKey)
	var PlaceStructureModelInstance : Node3D = PlaceStructureModelScene.instantiate()
	
	PlaceStructureNode.add_child(PlaceStructureModelInstance)
	
	InBuildStructureName = SelectedStructureDefsKey

func _enter_tree() -> void:
	if CurrentStrategicCamera == null:
		printerr("No StrategicCamera present!, skipping Mouse-to-World processing.")
