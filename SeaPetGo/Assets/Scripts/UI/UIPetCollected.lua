--!Type(UI)
--!SerializeField
local uiMesh : MeshRenderer = nil
--!Bind
local image : UIImage = nil
--!Bind
local imageShellsCollected : UIImage = nil
--!Bind
local textShellsCollected : UILabel = nil
--!Bind
local imagePearlsCollected : UIImage = nil
--!Bind
local textPearlsCollected : UILabel = nil

local cam : GameObject

function self:ClientStart()
    textShellsCollected:SetPrelocalizedText("+00")
    textPearlsCollected:SetPrelocalizedText("+00")
    cam = GameObject.Find("MainCamera")
    uiMesh.enabled = false
end

function SetCollected(shells, pearls)
    uiMesh.enabled = true
    textShellsCollected:SetPrelocalizedText("+" .. shells)
    textPearlsCollected:SetPrelocalizedText("+" .. pearls)
    -- Create a new Timer object. Interval: , Callback:function()..end, Repeating: false
    local newTimer = Timer.new(2, function() uiMesh.enabled = false end, false)
end

function self:ClientUpdate()
    self.gameObject.transform:LookAt(cam.gameObject.transform.position)
end

