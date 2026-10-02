extends Node
class_name PlayerController

@export var CurrentStrategicCamera : StrategicCamera
@export var SocietyStageWorld : SocietyStageGame
@export var PlaceStructureNode : Node3D

@export var DebugRayInterset : MeshInstance3D

var InBuildStructureName : String

func _ready() -> void:
	if SocietyStageWorld == null:
		return
	
	CivilizationsInfo.declare_new_civilization_info(GeneralGameData.PlayerCivilizationName)
	
	CivilizationsInfo.CivilizationsInfoDictionary[GeneralGameData.PlayerCivilizationName].set_resource_amount_to_civ("Wood", 100)
	CivilizationsInfo.CivilizationsInfoDictionary[GeneralGameData.PlayerCivilizationName].set_resource_amount_to_civ("Stone", 100)
	#CivilizationsInfo.CivilizationsInfoDictionary[GeneralGameData.PlayerCivilizationName].set_resource_amount_to_civ("Iron", 0)
	
	SocietyStageWorld.create_new_building("SOCIETY_CENTER", Vector3.ZERO, GeneralGameData.PlayerCivilizationName, true)

func _process(_Delta : float) -> void:
	if CurrentStrategicCamera == null or SocietyStageWorld == null:
		return
	
	process_structure_ghost()
	process_structure_placement()

func process_structure_ghost() -> void:
	if PlaceStructureNode == null:
		return
	
	PlaceStructureNode.position = CurrentStrategicCamera.WorldMousePosition

func process_structure_placement() -> void:
	if InBuildStructureName == "":
		return
	
	if Input.is_action_just_pressed("Mouse_Left_Click"):
		SocietyStageWorld.create_new_building(InBuildStructureName, CurrentStrategicCamera.WorldMousePosition, GeneralGameData.PlayerCivilizationName)
		
		cancel_building_construction()
	elif Input.is_action_just_pressed("Mouse_Right_Click"):
		cancel_building_construction()

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
