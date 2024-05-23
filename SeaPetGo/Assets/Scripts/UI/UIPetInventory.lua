--!Type(UI)
--!Bind
local contPetObtained : UIImage = nil
--!Bind
local containerPetInventory : UIImage = nil
--!Bind
local textPetSlots : UILabel = nil
--!Bind
local containerPetSlot : UIButton = nil
--!Bind
local imagePetSlot : UIImage = nil
--!Bind
local textPetSlotName : UILabel = nil
--!Bind
local textPetSlotRarity : UILabel = nil
--!Bind
local textPetSlotPower : UILabel = nil
--!Bind
local textButtonPetEquip : UILabel = nil
--!Bind
local textButtonPetRelease : UILabel = nil
--!Bind
local textPetEquipped : UILabel = nil
--!Bind
local buttonPetEquip : UIButton = nil
--!Bind
local buttonPetRelease : UIButton = nil
--!Bind
local buttonCloseInventory : UIButton = nil
--!Bind
local buttonPlayerPets : UILabel = nil
--!Bind
local containerPetInfo : UIButton = nil
--!Bind
local imagePetInfo : UIImage = nil
--!Bind
local textPetInfoRarity : UILabel = nil
--!Bind
local textPetInfoPower : UILabel = nil

local petManagerScript : module = require("PetManager")
local uiCheer : UICheer = nil

local petAmount : number = 0
local selectedPetIndex : number = 0
petsOwned = {}

--!SerializeField
local sfx_uiOpen : AudioShader = nil
--!SerializeField
local sfx_uiClose : AudioShader = nil
--!SerializeField
local sfx_equipPet : AudioShader = nil
--!SerializeField
local sfx_removePet : AudioShader = nil
--!SerializeField
local sfx_selectPet : AudioShader = nil

textPetEquipped:SetPrelocalizedText("Pet")

textPetSlotName:SetPrelocalizedText("Name")
textPetSlotRarity:SetPrelocalizedText("Rarity")
textPetSlotPower:SetPrelocalizedText("Power")

textPetInfoRarity:SetPrelocalizedText("")
textPetInfoPower:SetPrelocalizedText("")

textButtonPetEquip:SetPrelocalizedText("Equip")
textButtonPetRelease:SetPrelocalizedText("Release")

function self:ClientStart()
    uiCheer = GameObject.Find("UIManager"):GetComponent(UICheer)
    textPetSlots:SetPrelocalizedText("Storage: " .. petAmount .. "/9")
    buttonPlayerPets:RegisterPressCallback(function () OpenInventory() end)
    buttonCloseInventory:RegisterPressCallback(function () CloseInventory() end)
    buttonPetEquip:RegisterPressCallback(function () EquipPet() end)
    buttonPetRelease:RegisterPressCallback(function () ReleasePet() end)
    containerPetInventory:AddToClassList("hide")
    CreatePetSlots()
end

function CloseInventory()
    containerPetInventory:AddToClassList("hide")
    buttonPlayerPets:RemoveFromClassList("hide")
    textPetEquipped:SetPrelocalizedText("")
    textPetInfoPower:SetPrelocalizedText("")
    textPetInfoRarity:SetPrelocalizedText("")
    Audio:PlayShader(sfx_uiClose)
end

function OpenInventory()
    containerPetInventory:RemoveFromClassList("hide")
    buttonPlayerPets:AddToClassList("hide")
    Audio:PlayShader(sfx_uiOpen)
end

function AddNewPet(pet)
    print("Adding new Pet to Inventory")
    print("Check AddPet #3 - " .. pet)
    FillPetSlot(pet)
end

function EquipPet()
    if(textPetEquipped.text ~= "") then
        print("Equipping Pet")
        
        if(client.localPlayer.character.gameObject.transform:GetChild(2) ~= nil) then
            Object.Destroy(client.localPlayer.character.gameObject.transform:GetChild(2).gameObject)
        end

        local petObtained = petManagerScript.GetPet(textPetEquipped.text)
        newPet = Object.Instantiate(petObtained.go)
        uiCheer.ShowButton()
        Audio:PlayShader(sfx_equipPet)
    end
end

function ReleasePet()
    print("Releasing Pet from Inventory")
    petsOwned[selectedPetIndex].petName = "Pet"
    petsOwned[selectedPetIndex].uiSlot.name = "Slot" .. selectedPetIndex
    petsOwned[selectedPetIndex].uiSlot:RegisterPressCallback(function () end)
    petsOwned[selectedPetIndex].uiSlotPetTextName:SetPrelocalizedText("")        
    petsOwned[selectedPetIndex].uiSlotPetTextPower:SetPrelocalizedText("")
    petsOwned[selectedPetIndex].uiSlotPetTextRarity:SetPrelocalizedText("")
    
    petAmount = petAmount - 1
    textPetSlots:SetPrelocalizedText("Storage: " .. petAmount .. "/9")
    Audio:PlayShader(sfx_removePet)
end

function CreatePetSlots()
    j = 1
    l = 1
    for i=1,10 do
        print("Creating Pet Slot " .. i .. " in Inventory")    
        local slotPet = UIButton.new()
        slotPet.name = "Slot" .. i        
        local containerColumn = "containerPetSlotCol" .. l
        print(containerColumn)
        slotPet:AddToClassList(containerColumn)
        containerPetInventory:Add(slotPet)
        
        local imageSlotPet = UIImage.new()
        imageSlotPet:AddToClassList("imagePetSlot")
        slotPet:Add(imageSlotPet)

        local textPetSlotName = UILabel.new()
        textPetSlotName:AddToClassList("textPetSlotName")
        imageSlotPet:Add(textPetSlotName)
    
        local textPetSlotPower = UILabel.new()
        textPetSlotPower:AddToClassList("textPetSlotPower")
        imageSlotPet:Add(textPetSlotPower)
    
        local textSlotPetRarity = UILabel.new()
        textSlotPetRarity:AddToClassList("textPetSlotRarity")
        textPetSlotRarity:SetPrelocalizedText("Rarity")
        imageSlotPet:Add(textSlotPetRarity)
    
        petInfo = { index = i, petName = "Pet", uiSlot = slotPet, uiSlotImagePet = imageSlotPet, uiSlotPetTextName = textPetSlotName, uiSlotPetTextPower = textPetSlotPower, uiSlotPetTextRarity = textSlotPetRarity} 
        petsOwned[i] = petInfo

        j = j + 1
        
        if(j > 3) then
            l = l + 1
            j = 1
        end
    end
end

function FillPetSlot(pet)
    print("Filling Pet Slot in Inventory with " .. pet)
    local petObtained = petManagerScript.GetPet(pet)

    for i=1,10 do
        if(petsOwned[i].petName == "Pet") then
            
            petsOwned[i].petName = pet
            petsOwned[i].uiSlot.name = pet
            petsOwned[i].uiSlot:RegisterPressCallback(function () SetPet(petsOwned[i].uiSlot.name, petsOwned[i].index) end)    
            petsOwned[i].uiSlotImagePet.image = petObtained.sprite
            petsOwned[i].uiSlotPetTextName:SetPrelocalizedText(pet) 
            petsOwned[i].uiSlotPetTextPower:SetPrelocalizedText(petObtained.cPower)
            petsOwned[i].uiSlotPetTextRarity:SetPrelocalizedText(petObtained.rarity)
            
            petAmount = petAmount + 1
            textPetSlots:SetPrelocalizedText("Storage: " .. petAmount .. "/25")

            break
        end
    end
end

function SetPet(pet, index)
    local petObtained = petManagerScript.GetPet(pet)
    imagePetInfo.image = petObtained.sprite
    textPetEquipped:SetPrelocalizedText(petObtained.name)
    textPetInfoPower:SetPrelocalizedText(petObtained.cPower)
    textPetInfoRarity:SetPrelocalizedText(petObtained.rarity)
    selectedPetIndex = index
    Audio:PlayShader(sfx_selectPet)
end

function GetPet(petName)
    print("Getting Pet: " .. petName)
    for i = 1, #arrayPets do
      print(arrayPets[i])
        if(arrayPets[i].name == petName) then
          return arrayPets[i]
        end
    end             
  end
