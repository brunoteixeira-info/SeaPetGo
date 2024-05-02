--!Type(UI)

--!Bind
local textStageBarrier : UILabel = nil

textStageBarrier:SetPrelocalizedText("000000")

function SetStageBarrierText(text)
    textStageBarrier:SetPrelocalizedText(text)
end