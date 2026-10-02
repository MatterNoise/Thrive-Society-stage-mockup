extends HBoxContainer
class_name BuildingSelectItem

signal ForwardBuildingItemSelected(SelectedStructureDefsKey : String)

@export var ResourceAmountBarScene : PackedScene

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
	
	if CivilizationsInfo.civilization_can_afford_building(AssignedStructureDefsKey, GeneralGameData.PlayerCivilizationName) == true:
		BuildButtonNode.disabled = false
	else:
		BuildButtonNode.disabled = true

func update_building_description() -> void:
	if StructureNameLabelNode == null or StructureRequirements == null:
		return
	
	if AssignedStructureDefsKey == "":
		return
	
	StructureNameLabelNode.text = StructuresDefinitions.StructureDefinitionsDictionary[AssignedStructureDefsKey].StructureName
	
	if ResourceAmountBarScene == null:
			return
	
	var BuildingRequirements := StructuresDefinitions.get_structure_building_requirements(AssignedStructureDefsKey)
	for IBuildingRequirement in BuildingRequirements:
		var ResourceAmountBarInstance : ResourceAmountBar = ResourceAmountBarScene.instantiate()
		
		ResourceAmountBarInstance.AssignedResourceKey = IBuildingRequirement
		ResourceAmountBarInstance.ResourceIcon = ResourcesDefinitions.get_resource_icon(IBuildingRequirement)
		ResourceAmountBarInstance.ShowResourcesRequired = true
		
		var BuildingResourceRequired : int = StructuresDefinitions.get_structure_building_requirements(AssignedStructureDefsKey)[IBuildingRequirement]
		ResourceAmountBarInstance.ResourceRequiredLabelNode.text = str(BuildingResourceRequired)
		
		ResourceAmountBarInstance.update_descriptions()
		
		StructureRequirements.add_child(ResourceAmountBarInstance)

func _on_build_button_button_up() -> void:
	ForwardBuildingItemSelected.emit(AssignedStructureDefsKey)
