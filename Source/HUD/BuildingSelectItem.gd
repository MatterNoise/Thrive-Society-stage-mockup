extends HBoxContainer
class_name BuildingSelectItem

signal ForwardBuildingItemSelected(SelectedStructureDefsKey : String)

@export var StructureNameLabelNode : Label
@export var StructureRequirements : GridContainer
@export var BuildButtonNode : Button

var AssignedStructureDefsKey : String

var AssignedBuildingName : String

func _ready() -> void:
	pass

func _process(_Delta : float) -> void:
	if BuildButtonNode == null:
		return
	
	if CivilizationsInfo.civilization_can_afford_building(AssignedStructureDefsKey, "PlayerCiv") == true:
		BuildButtonNode.disabled = false
	else:
		BuildButtonNode.disabled = true

func update_building_description() -> void:
	if StructureNameLabelNode == null or StructureRequirements == null:
		return
	
	if AssignedStructureDefsKey == "":
		return
	
	StructureNameLabelNode.text = StructuresDefinitions.StructureDefinitionsDictionary[AssignedStructureDefsKey].StructureName
	
	var BuildingRequirements := StructuresDefinitions.get_structure_building_requirements(AssignedStructureDefsKey)
	for IBuildingRequirement in BuildingRequirements:
		print(IBuildingRequirement)

func _on_build_button_button_up() -> void:
	ForwardBuildingItemSelected.emit(AssignedStructureDefsKey)
