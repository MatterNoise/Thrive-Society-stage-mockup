extends Window

signal OnBuildingSelected(SelectedStructureDefsKey : String)

@export var BuildingSelectItemScene : PackedScene

@export var BuildingSelectList : VBoxContainer

func _ready() -> void:
	if BuildingSelectList == null or BuildingSelectItemScene == null:
		return
	
	var StructuresDefsDictionarySize : int = StructuresDefinitions.StructureDefinitionsDictionary.size()
	if StructuresDefsDictionarySize < 1:
		return
	
	for IBuildingSelectItem in range(0, StructuresDefsDictionarySize):
		var BuildingSelectItemInstance : BuildingSelectItem = BuildingSelectItemScene.instantiate()
		
		BuildingSelectList.add_child(BuildingSelectItemInstance)
		
		BuildingSelectItemInstance.AssignedStructureDefsKey = StructuresDefinitions.get_structure_definition_key(IBuildingSelectItem)
		BuildingSelectItemInstance.update_building_description()
		
		BuildingSelectItemInstance.ForwardBuildingItemSelected.connect(_on_building_item_selected)

func request_close_window() -> void:
	hide()

func _on_building_item_selected(SelectedStructureDefsKey : String) -> void:
	OnBuildingSelected.emit(SelectedStructureDefsKey)
	
	request_close_window()

func _on_close_requested() -> void:
	request_close_window()

func _on_open_build_select_menu() -> void:
	show()
