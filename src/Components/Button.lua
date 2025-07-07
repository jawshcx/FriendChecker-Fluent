local Root = script.Parent.Parent
local Flipper = require(Root.Packages.Flipper)
local Creator = require(Root.Creator)
local New = Creator.New

local Spring = Flipper.Spring.new

return function(Theme, Parent, DialogCheck)
    DialogCheck = DialogCheck or false
    local Button = {}

    -- Add IsHeadshot option at the start
    Button.IsHeadshot = Button.IsHeadshot or false

    -- Modified Title with headshot spacing
    Button.Title = New("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, -- Changed from Center
        TextYAlignment = Enum.TextYAlignment.Center,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = Button.IsHeadshot and UDim2.new(1, -60, 1, 0) or UDim2.fromScale(1, 1),
        Position = Button.IsHeadshot and UDim2.new(0, 60, 0, 0) or UDim2.new(0, 0, 0, 0),
        ThemeTag = {
            TextColor3 = "Text",
        },
    })

    -- New Icon ImageLabel
    Button.Icon = New("ImageLabel", {
        Size = Button.IsHeadshot and UDim2.fromOffset(50, 50) or UDim2.fromOffset(20, 20),
        Position = Button.IsHeadshot and UDim2.new(0, 10, 0.5, -25) or UDim2.new(0, 5, 0.5, -10),
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Stretch,
        Visible = false, -- Will be set by :SetIcon()
        ThemeTag = {
            ImageColor3 = "Text",
        },
    })

    Button.HoverFrame = New("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        ThemeTag = {
            BackgroundColor3 = "Hover",
        },
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
    })

    Button.Frame = New("TextButton", {
        Size = UDim2.new(0, 0, 0, 32),
        Parent = Parent,
        ThemeTag = {
            BackgroundColor3 = "DialogButton",
        },
    }, {
        New("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),
        New("UIStroke", {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Transparency = 0.65,
            ThemeTag = {
                Color = "DialogButtonBorder",
            },
        }),
        Button.HoverFrame,
        Button.Icon, -- Added icon to the frame
        Button.Title,
    })

    -- Add SetIcon function
    function Button:SetIcon(icon)
        if icon then
            self.Icon.Image = icon
            self.Icon.Visible = true
            if self.IsHeadshot then
                self.Title.Position = UDim2.new(0, 60, 0, 0)
                self.Title.Size = UDim2.new(1, -60, 1, 0)
            end
        else
            self.Icon.Visible = false
            self.Title.Position = UDim2.new(0, 0, 0, 0)
            self.Title.Size = UDim2.fromScale(1, 1)
        end
    end

    local Motor, SetTransparency = Creator.SpringMotor(1, Button.HoverFrame, "BackgroundTransparency", DialogCheck)
    Creator.AddSignal(Button.Frame.MouseEnter, function()
        SetTransparency(0.97)
    end)
    Creator.AddSignal(Button.Frame.MouseLeave, function()
        SetTransparency(1)
    end)
    Creator.AddSignal(Button.Frame.MouseButton1Down, function()
        SetTransparency(1)
    end)
    Creator.AddSignal(Button.Frame.MouseButton1Up, function()
        SetTransparency(0.97)
    end)

    return Button
end
