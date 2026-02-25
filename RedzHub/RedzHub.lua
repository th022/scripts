-- ==================================================================
-- VM OBFUSCATOR v2.1 (RedzHub - Distribuição Oficial)
-- ==================================================================

local _img   = "111,123,123,119,122,65,54,54,121,104,126,53,110,112,123,111,124,105,124,122,108,121,106,118,117,123,108,117,123,53,106,118,116,54,123,111,55,57,57,54,87,121,118,113,108,106,123,54,121,108,109,122,54,111,108,104,107,122,54,116,104,112,117,54,109,121,108,108,45,114,108,128,45,112,106,118,117,45,56,50,48,45,116,104,117,110,105,53,112,117,110"
local _keys  = "111,123,123,119,122,65,54,54,121,104,126,53,110,112,123,111,124,105,124,122,108,121,106,118,117,123,108,117,123,53,106,118,116,54,123,111,55,57,57,54,114,108,128,122,54,121,108,109,122,54,111,108,104,107,122,54,116,104,112,117,54,89,108,107,129,79,124,105,54,114,108,128,53,123,127,123"
local _get   = "111,123,123,119,122,65,54,54,114,108,128,53,123,112,119,118,122,107,108,119,115,104,117,123,104,122,53,106,118,116,53,105,121,54,121,108,107,129,111,124,105,54"
local _main  = "111,123,123,119,122,65,54,54,121,104,126,53,110,112,123,111,124,105,124,122,108,121,106,118,117,123,108,117,123,53,106,118,116,54,111,124,128,58,63,59,54,121,108,107,129,79,124,105,54,121,108,109,122,54,111,108,104,107,122,54,116,104,112,117,54,121,108,107,129,79,124,105,53,115,124,104"
local _file  = "123,111,55,57,57,102,121,108,107,129,111,124,105,102,122,104,125,108,107,102,114,108,128,53,123,127,123"
local _iconN = "114,108,128,102,112,106,118,117,102,125,62,53,119,117,110"

local function _DECODE(d)
    local s = ""
    for c in string.gmatch(d, "([^,]+)") do s = s .. string.char(tonumber(c) - 7) end
    return s
end

local SETTINGS = {
    IMG = _DECODE(_img), KEYS = _DECODE(_keys), GET = _DECODE(_get),
    MAIN = _DECODE(_main), STRG = _DECODE(_file), ICN_NAME = _DECODE(_iconN)
}

local _RT = {
    [0xAA] = function(u) return game:HttpGet(u) end,
    [0xBB] = function(c) return loadstring(c)() end
}

local function _CLEAN(str)
    return str and str:gsub("%s+", ""):gsub("%c+", "") or ""
end

local function IsKeyValid(keyToValidate)
    local input = _CLEAN(keyToValidate)
    if input == "" then return false end
    local s, r = pcall(function() return _RT[0xAA](SETTINGS.KEYS) end)
    if s and r then
        for line in r:gmatch("[^\r\n]+") do
            if _CLEAN(line) == input then return true end
        end
    end
    return false
end

local function LoadPayload()
    pcall(function()
        local content = _RT[0xAA](SETTINGS.MAIN)
        if content then _RT[0xBB](content) end
    end)
end

-- ==================================================================
-- INTERFACE
-- ==================================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlueKeySystemPersistent"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not ScreenGui.Parent then ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 260)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(51, 95, 254)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(0, 200, 0, 60); Title.Position = UDim2.new(0, 30, 0, 20)
Title.BackgroundTransparency = 1; Title.Text = "Key System"; Title.TextColor3 = Color3.fromRGB(15, 35, 100)
Title.TextSize = 32; Title.Font = Enum.Font.GothamBold; Title.TextXAlignment = Enum.TextXAlignment.Left

local KeyIcon = Instance.new("ImageLabel", MainFrame)
KeyIcon.Size = UDim2.new(0, 55, 0, 55); KeyIcon.Position = UDim2.new(1, -85, 0, 22)
KeyIcon.BackgroundTransparency = 1; KeyIcon.ImageColor3 = Color3.fromRGB(15, 35, 100)
task.spawn(function()
    pcall(function()
        if not isfile(SETTINGS.ICN_NAME) then writefile(SETTINGS.ICN_NAME, _RT[0xAA](SETTINGS.IMG)) end
        KeyIcon.Image = getcustomasset(SETTINGS.ICN_NAME)
    end)
end)

local InputBox = Instance.new("TextBox", MainFrame)
InputBox.Size = UDim2.new(0, 320, 0, 50); InputBox.Position = UDim2.new(0.5, -160, 0.5, -20)
InputBox.BackgroundTransparency = 1; InputBox.Text = ""; InputBox.PlaceholderText = "Enter Key..."
InputBox.TextColor3 = Color3.fromRGB(15, 35, 100); InputBox.PlaceholderColor3 = Color3.fromRGB(60, 85, 180)
InputBox.TextSize = 24; InputBox.Font = Enum.Font.Code; InputBox.TextXAlignment = Enum.TextXAlignment.Left
InputBox.ClearTextOnFocus = true

local GetKeyBtn = Instance.new("TextButton", MainFrame)
GetKeyBtn.Size = UDim2.new(0, 130, 0, 50); GetKeyBtn.Position = UDim2.new(0, 30, 1, -70)
GetKeyBtn.BackgroundTransparency = 1; GetKeyBtn.Text = "Get Key"; GetKeyBtn.TextColor3 = Color3.fromRGB(15, 35, 100)
GetKeyBtn.TextSize = 24; GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(SETTINGS.GET)
    GetKeyBtn.Text = "Copied!"; task.wait(1.5); GetKeyBtn.Text = "Get Key"
end)

local VerifyBtn = Instance.new("TextButton", MainFrame)
VerifyBtn.Size = UDim2.new(0, 130, 0, 50); VerifyBtn.Position = UDim2.new(1, -160, 1, -70)
VerifyBtn.BackgroundTransparency = 1; VerifyBtn.Text = "Verify Key"; VerifyBtn.TextColor3 = Color3.fromRGB(15, 35, 100)
VerifyBtn.TextSize = 24; VerifyBtn.Font = Enum.Font.GothamBold

VerifyBtn.MouseButton1Click:Connect(function()
    VerifyBtn.Text = "Checking..."
    local val = InputBox.Text
    if IsKeyValid(val) then
        VerifyBtn.Text = "Success!"
        writefile(SETTINGS.STRG, _CLEAN(val))
        task.wait(0.5); ScreenGui:Destroy(); LoadPayload()
    else
        VerifyBtn.Text = "Verify Key"; InputBox.Text = ""; InputBox.PlaceholderText = "Invalid Key!"
        task.wait(1.5); InputBox.PlaceholderText = "Enter Key..."
    end
end)

-- Auto-Login
task.spawn(function()
    if isfile(SETTINGS.STRG) then
        local saved = readfile(SETTINGS.STRG)
        if IsKeyValid(saved) then
            ScreenGui.Enabled = false
            LoadPayload()
            ScreenGui:Destroy()
        end
    end
end)
