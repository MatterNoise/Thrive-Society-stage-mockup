extends PanelContainer

@export var ResourceAmountBarScene : PackedScene
@export var ResourceAmountBarGrid : GridContainer

func _ready() -> void:
	if ResourceAmountBarGrid == null:
		return
	
	if ResourceAmountBarScene == null:
		return
	
	var ExistentResources := ResourcesDefinitions.ResourceDefinitionsDictionary
	for IResource in ExistentResources:
		var ResourceAmountBarInstance : ResourceAmountBar = ResourceAmountBarScene.instantiate()
		
		ResourceAmountBarInstance.AssignedResourceKey = IResource
		ResourceAmountBarInstance.ResourceIcon = ResourcesDefinitions.get_resource_icon(IResource)
		ResourceAmountBarInstance.ShowResourcesRequired = false
		
		ResourceAmountBarInstance.update_descriptions()
		
		ResourceAmountBarGrid.add_child(ResourceAmountBarInstance)
