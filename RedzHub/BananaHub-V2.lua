-- Criando a Interface Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WhatsAppPromptGui_BananaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Tenta colocar a interface na PlayerGui do jogador local
local player = game:GetService("Players").LocalPlayer
if player then
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
else
    ScreenGui.Parent = game:GetService("CoreGui") -- Fallback para ambientes de exploit
end

-- Painel Principal (Fundo Preto)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 240) -- Altura perfeita para o texto de destaque
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -120) -- Centralizado na tela
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Permite arrastar o painel pela tela
MainFrame.Parent = ScreenGui

-- ARREDONDAR BORDAS DO PAINEL PRINCIPAL
local MainFrameCorner = Instance.new("UICorner")
MainFrameCorner.CornerRadius = UDim.new(0, 16)
MainFrameCorner.Parent = MainFrame

-- Título: WhatsApp
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 200, 0, 40)
TitleLabel.Position = UDim2.new(0, 20, 0, 15)
TitleLabel.BackgroundTransparency = 1
TitleLabel.BorderSizePixel = 0
TitleLabel.Text = "WhatsApp"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 28
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

-----------------------------------------------------------
-- BOTÃO DE FECHAR (X) - TAMANHO GRANDE (32x32)
-----------------------------------------------------------
local CloseButton = Instance.new("ImageButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 32, 0, 32)
CloseButton.Position = UDim2.new(1, -52, 0, 18)
CloseButton.BackgroundTransparency = 1
CloseButton.BorderSizePixel = 0
CloseButton.ImageColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = MainFrame

-- Link da sua imagem branca e limpa hospedada no GitHub
local pngImageUrl = "https://raw.githubusercontent.com/th022/scripts/refs/heads/main/178395173881303177.png"

-- Função para baixar e aplicar a imagem usando o sistema de arquivos do executor
local function aplicarImagemGithub()
    local c_success, _ = pcall(function()
        if writefile and getcustomasset then
            local imagemDados = game:HttpGet(pngImageUrl)
            writefile("fechar_icon_custom.png", imagemDados)
            CloseButton.Image = getcustomasset("fechar_icon_custom.png")
        else
            -- Fallback para Studio ou executores sem filesystem
            local fallbackText = Instance.new("TextLabel")
            fallbackText.Size = UDim2.new(1, 0, 1, 0)
            fallbackText.BackgroundTransparency = 1
            fallbackText.Text = "✕"
            fallbackText.TextColor3 = Color3.fromRGB(255, 255, 255)
            fallbackText.TextSize = 26
            fallbackText.Font = Enum.Font.SourceSansBold
            fallbackText.Parent = CloseButton
        end
    end)
    if not c_success then
        CloseButton.BackgroundTransparency = 1
    end
end
aplicarImagemGithub()

-- Mantém o botão perfeitamente quadrado (1:1)
local CloseAspectRatio = Instance.new("UIAspectRatioConstraint")
CloseAspectRatio.AspectRatio = 1
CloseAspectRatio.Parent = CloseButton
-----------------------------------------------------------

-----------------------------------------------------------
-- TEXTO CHAMATIVO (CAPTAR LEADS)
-----------------------------------------------------------
local HookLabel = Instance.new("TextLabel")
HookLabel.Name = "HookLabel"
HookLabel.Size = UDim2.new(1, -40, 0, 30)
HookLabel.Position = UDim2.new(0, 20, 0, 70) -- Posicionado acima do link
HookLabel.BackgroundTransparency = 1
HookLabel.BorderSizePixel = 0
HookLabel.Text = "🔥 GRUPO VIP: SCRIPTS EXCLUSIVOS E NOVIDADES! 🔥"
HookLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Amarelo chamativo
HookLabel.TextSize = 14
HookLabel.Font = Enum.Font.SourceSansBold
HookLabel.TextWrapped = true
HookLabel.TextXAlignment = Enum.TextXAlignment.Center
HookLabel.Parent = MainFrame
-----------------------------------------------------------

-- Texto do Link do Canal
local LinkLabel = Instance.new("TextLabel")
LinkLabel.Name = "LinkLabel"
LinkLabel.Size = UDim2.new(1, -40, 0, 50)
LinkLabel.Position = UDim2.new(0, 20, 0, 105)
LinkLabel.BackgroundTransparency = 1
LinkLabel.BorderSizePixel = 0
LinkLabel.Text = "https://whatsapp.com/channel/\n0029VauF7UpHwXb5CWF8Hy0R"
LinkLabel.TextColor3 = Color3.fromRGB(180, 180, 180) -- Cinza sutil
LinkLabel.TextSize = 15
LinkLabel.Font = Enum.Font.SourceSans
LinkLabel.TextWrapped = true
LinkLabel.TextXAlignment = Enum.TextXAlignment.Center
LinkLabel.Parent = MainFrame

-- Botão "Entrar" (Azul)
local EnterButton = Instance.new("TextButton")
EnterButton.Name = "EnterButton"
EnterButton.Size = UDim2.new(0, 110, 0, 45)
EnterButton.Position = UDim2.new(1, -130, 1, -65)
EnterButton.BackgroundColor3 = Color3.fromRGB(44, 94, 253)
EnterButton.BorderSizePixel = 0
EnterButton.Text = "Entrar"
EnterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterButton.TextSize = 20
EnterButton.Font = Enum.Font.SourceSansBold
EnterButton.Parent = MainFrame

-- ARREDONDAR BORDAS DO BOTÃO "ENTRAR"
local EnterButtonCorner = Instance.new("UICorner")
EnterButtonCorner.CornerRadius = UDim.new(0, 8)
EnterButtonCorner.Parent = EnterButton

---
-- FUNÇÕES E COMPORTAMENTOS (EXECUÇÃO DO BANANAHUB)
---

-- Função executada ao fechar (Carrega o script do BananaHub que você passou)
local function carregarProximoScript()
    local success, err = pcall(function()
        -- Executa o link do BananaHub via loadstring
        loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()
    end)
    if not success then
        warn("Erro ao carregar o BananaHub: " .. tostring(err))
    end
end

-- Ação ao clicar no 'X' (Fechar)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Remove a nossa interface de convite da tela
    carregarProximoScript() -- Carrega e abre o script do BananaHub
end)

-- Lógica de Clique "Entrar" (Apenas Copiar o Link do WhatsApp)
EnterButton.MouseButton1Click:Connect(function()
    local whatsappLink = "https://whatsapp.com/channel/0029VauF7UpHwXb5CWF8Hy0R"
    
    if setclipboard then
        local success, _ = pcall(function()
            setclipboard(whatsappLink)
        end)
        
        if success then
            EnterButton.Text = "Copiado!"
        else
            EnterButton.Text = "Erro ao Copiar"
        end
    else
        print("Link do canal copiado: " .. whatsappLink)
        EnterButton.Text = "Copiado!"
    end
    
    task.wait(2)
    EnterButton.Text = "Entrar"
end)
