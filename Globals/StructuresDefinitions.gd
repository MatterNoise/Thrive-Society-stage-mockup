extends Node

var StructureDefinitionsDictionary : Dictionary[String, IStructureDefinitions]

func _enter_tree() -> void:
	var JSONManager := JSON.new()
	
	var StructuresJSONFile := FileAccess.open("res://SimulationParameters/Structures.json", FileAccess.READ)
	var StructuresJSONContent := StructuresJSONFile.get_as_text()
	
	if JSONManager.parse(StructuresJSONContent):
		print("Error loading the Structures definitions")
		
		return
	
	var StructuresDictionary : Dictionary = JSONManager.data
	for IDictionaryItem in StructuresDictionary:
		var StructuresDictionaryItem : Dictionary = StructuresDictionary[IDictionaryItem]
		
		var NewStructureDefinition := IStructureDefinitions.new()
		
		NewStructureDefinition.StructureName = StructuresDictionaryItem["Name"]
		
		# Fetch the Building_Requirements elements of the JSON
		for IBuildingRequirement in StructuresDictionaryItem["Building_Requirements"]:
			if ResourcesDefinitions.is_resource_existent(IBuildingRequirement) == false:
				printerr("Non-existent resource '%s' was found in the requirements, skipping it." % str(IBuildingRequirement))
				
				continue
			
			NewStructureDefinition.StructureBuildingRequirements[IBuildingRequirement] = StructuresDictionaryItem["Building_Requirements"][IBuildingRequirement]
		
		NewStructureDefinition.StructureStandartModel = load(StructuresDictionaryItem["StandartModelPath"])
		NewStructureDefinition.StructureGhostModel = load(StructuresDictionaryItem["GhostModelPath"])
		
		var DefinitionsDictionaryKey : String = StructuresDictionaryItem["Name"]
		StructureDefinitionsDictionary[DefinitionsDictionaryKey] = NewStructureDefinition

func is_structure_existent(ResourceName : String) -> bool:
	if StructureDefinitionsDictionary.has(ResourceName) == true:
		return true
	
	return false

func get_structure_definition_key(DefinitionKeyNumber : int) -> String:
	var StructureDefinitionsKeys := StructureDefinitionsDictionary.keys()
	
	return StructureDefinitionsKeys[DefinitionKeyNumber]

func get_structure_building_requirements(StructureName : String) -> Dictionary[String, int]:
	return StructureDefinitionsDictionary[StructureName].StructureBuildingRequirements

func get_structure_standart_model(StructureName : String) -> PackedScene:
	return StructureDefinitionsDictionary[StructureName].StructureStandartModel

func get_structure_ghost_model(StructureName : String) -> PackedScene:
	return StructureDefinitionsDictionary[StructureName].StructureGhostModel
