--!Type(UI)
--!Bind
local imageProgressBar : UIImage = nil
--!Bind
local progressBar : UIProgressBar = nil
--!Bind
local textProgressBar : UILabel = nil

local cam : GameObject

function self:ClientStart()
    cam = GameObject.Find("MainCamera")
    progressBar.value = 1
end

function self:ClientUpdate()
    self.gameObject.transform:LookAt(cam.gameObject.transform.position)
end

function SetHP(hp, hpMax)
    print(hp)
    print(hpMax)
    textProgressBar:SetPrelocalizedText("<b>" .. hp .. "</b>")
    progressBar.value = hp / hpMax
end