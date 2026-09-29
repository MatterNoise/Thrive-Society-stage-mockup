extends Node

var CivilizationsInfoDictionary : Dictionary[String, ICivilizationInfo]

func declare_new_civilization_info(CivilizationName : String) -> void:
	if CivilizationsInfoDictionary.has(CivilizationName) == true:
		print("Mencioned civilization info was declared!.")
		
		return
	
	CivilizationsInfoDictionary[CivilizationName] = ICivilizationInfo.new()

func add_building_to_civilization_info(CivilizationName : String, CivilizationBuilding : IBuildingClass) -> void:
	if CivilizationName == "":
		return
	
	if CivilizationsInfoDictionary.has(CivilizationName) == false:
		print("Adding building to a non-existent civilization info!.")
		
		return
	
	CivilizationsInfoDictionary[CivilizationName].CivilizationBuildings.append(CivilizationBuilding)

func civilization_can_afford_building(StructureName : String, BuildingOwner : String) -> bool:
	var BuildingRequirements := StructuresDefinitions.get_structure_building_requirements(StructureName)
	
	for IBuildingRequirement in BuildingRequirements:
		var CivilizationResourceCuantity := CivilizationsInfoDictionary[BuildingOwner].get_civilization_resource(IBuildingRequirement)
		
		if CivilizationResourceCuantity < BuildingRequirements[IBuildingRequirement]:
			return false
	
	return true

func delete_building_to_civilization_info(CivilizationName : String, CivilizationBuilding : IBuildingClass) -> void:
	if CivilizationName == "":
		return
	
	if CivilizationsInfoDictionary.has(CivilizationName) == false:
		printerr("Deleting building to a non-existent civilization info!, Aborting.")
		
		return
	
	var BuildingArrayID := CivilizationsInfoDictionary[CivilizationName].CivilizationBuildings.find(CivilizationBuilding)
	CivilizationsInfoDictionary[CivilizationName].CivilizationBuildings.remove_at(BuildingArrayID)

func get_buildings_from_civilization_info(CivilizationName : String) -> Array[IBuildingClass]:
	if CivilizationName == "" or CivilizationsInfoDictionary.has(CivilizationName) == false:
		return []
	
	return CivilizationsInfoDictionary[CivilizationName].CivilizationBuildings
