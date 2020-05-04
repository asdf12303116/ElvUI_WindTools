local W, F, E, L = unpack(select(2, ...))
local S = W:GetModule('Skins')

local _G = _G
local hooksecurefunc = hooksecurefunc
local UIDROPDOWNMENU_MAXLEVELS = UIDROPDOWNMENU_MAXLEVELS

function S:Blizzard_DeathRecap()
    S:CreateShadow(_G.DeathRecapFrame)
end

function S:BlizzardMiscFrames()
    if not (E.private.skins.blizzard.enable and E.private.skins.blizzard.misc) then return end
    if not (E.private.WT.skins.blizzard.enable and E.private.WT.skins.blizzard.misc) then return end

    -- 一些菜单框体
    local miscFrames = {
        "GameMenuFrame",
        "InterfaceOptionsFrame",
        "VideoOptionsFrame",
        "AudioOptionsFrame",
        "AutoCompleteBox"
    }

    for _, frame in pairs(miscFrames) do S:CreateShadow(_G[frame]) end

    -- 跳过剧情
    hooksecurefunc('CinematicFrame_OnDisplaySizeChanged',
                   function(f) if f and f.CloseDialog then S:CreateShadow(f.CloseDialog) end end)

    hooksecurefunc('MovieFrame_PlayMovie', function(f) if f and f.CloseDialog then S:CreateShadow(f.CloseDialog) end end)

    -- 聊天菜单
    local chatMenus = {"ChatMenu", "EmoteMenu", "LanguageMenu", "VoiceMacroMenu"}

    for _, menu in pairs(chatMenus) do _G[menu]:HookScript("OnShow", function(f) if f then S:CreateShadow(f) end end) end

    -- 下拉菜单
    for i = 1, UIDROPDOWNMENU_MAXLEVELS, 1 do
        if _G["DropDownList" .. i] then S:CreateShadow(_G["DropDownList" .. i]) end
    end

    -- 错误提示
    F.SetFontOutline(_G.UIErrorsFrame)
    F.SetFontOutline(_G.ActionStatusText)

    -- 灵魂医者传送按钮
    S:CreateShadow(_G.GhostFrameContentsFrame)
    
    -- 跳过剧情
    S:CreateShadow(_G.CinematicFrameCloseDialog)

    -- 聊天设定
    S:CreateShadow(_G.ChatConfigFrame)
end

S:AddCallback('BlizzardMiscFrames')
S:AddCallbackForAddon('Blizzard_DeathRecap')