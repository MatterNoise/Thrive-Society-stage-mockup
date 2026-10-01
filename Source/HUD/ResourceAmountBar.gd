extends HBoxContainer
class_name ResourceAmountBar

@export var ResourceTextureNode : TextureRect
@export var ResourceRequiredLabelNode : Label
@export var ResourceTotalStoredLabelNode : Label

var AssignedResourceKey : String = "Wood"

var ResourceIcon : CompressedTexture2D = preload("res://Assets/Textures/GUI/Luciferase.svg")

func _process(_Delta : float) -> void:
	if AssignedResourceKey == "":
		return
	
	if ResourceTotalStoredLabelNode == null:
		return
	
	var TotalResourceStored : int = CivilizationsInfo.CivilizationsInfoDictionary[GeneralGameData.PlayerCivilizationName].get_civilization_resource(AssignedResourceKey)
	ResourceTotalStoredLabelNode.text = str(TotalResourceStored)

func update_descriptions() -> void:
	if ResourceTextureNode == null or ResourceRequiredLabelNode == null:
		return
	
	ResourceTextureNode.texture = ResourceIcon
	ResourceTextureNode.tooltip_text = AssignedResourceKey
