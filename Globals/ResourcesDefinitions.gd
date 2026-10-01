extends Node

var ResourceDefinitionsDictionary : Dictionary[String, IResourceDefinitions]

func _enter_tree() -> void:
	var JSONManager := JSON.new()
	
	var ResourcesJSONFile := FileAccess.open("res://SimulationParameters/Resources.json", FileAccess.READ)
	var ResourcesJSONContent := ResourcesJSONFile.get_as_text()
	
	if JSONManager.parse(ResourcesJSONContent):
		print("Error loading the Resources definitions")
		
		return
	
	var ResourcesDictionary : Dictionary = JSONManager.data
	for IDictionaryItem in ResourcesDictionary:
		var ResourcesDictionaryItem : Dictionary = ResourcesDictionary[IDictionaryItem]
		
		var NewResourceDefinition := IResourceDefinitions.new()
		
		NewResourceDefinition.ResourceName = ResourcesDictionaryItem["Name"]
		NewResourceDefinition.ResourceIcon = load(ResourcesDictionaryItem["Icon"])
		
		var DefinitionsDictionaryKey : String = ResourcesDictionaryItem["Name"]
		ResourceDefinitionsDictionary[DefinitionsDictionaryKey] = NewResourceDefinition

func is_resource_existent(ResourceName : String) -> bool:
	if ResourceDefinitionsDictionary.has(ResourceName) == true:
		return true
	
	return false

func get_resource_definition_key(DefinitionKeyNumber : int) -> String:
	var ResourceDefinitionsKeys := ResourceDefinitionsDictionary.keys()
	
	return ResourceDefinitionsKeys[DefinitionKeyNumber]

func get_resource_icon(ResourceName : String) -> CompressedTexture2D:
	return ResourceDefinitionsDictionary[ResourceName].ResourceIcon
