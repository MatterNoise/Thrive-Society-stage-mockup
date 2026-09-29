extends HBoxContainer
class_name BuildingSelectItem

signal ForwardBuildingItemSelected(SelectedStructureDefsKey : String)

@export var StructureNameLabelNode : Label
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
	if AssignedStructureDefsKey == "":
		return
	
	if StructureNameLabelNode == null:
		return
	
	StructureNameLabelNode.text = StructuresDefinitions.StructureDefinitionsDictionary[AssignedStructureDefsKey].StructureName

func _on_build_button_button_up() -> void:
	ForwardBuildingItemSelected.emit(AssignedStructureDefsKey)
