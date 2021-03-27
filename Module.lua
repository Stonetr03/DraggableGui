-- Stonetr03 Studios

-- Original Module made by Spynaz https://devforum.roblox.com/t/simple-module-for-creating-draggable-gui-elements/230678

local Module = {}

local Events = {}

function Module:SetDrag(gui,Value)
	if Value == true then
		-- Enable Drag
		local UserInputService = game:GetService("UserInputService")

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function update(input)
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			
			-- Updates Gui Position - Connect Update Event Here --
			
		end

		local IBconnection

		IBconnection = gui.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
						
						-- Stop Drag - Connect Stop Event Here - Sometimes calls more than once --
						
					end
				end)
				
				-- Start Drag - Connect Start Event Here -- 
				
			end
		end)

		local ICconnection 
		ICconnection = gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		local UISconnection
		UISconnection = UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)

		Events[gui] = {
			UISconnection = UISconnection,
			ICconnection = ICconnection,
			IBconnection = IBconnection,
		}

	elseif Value == false then
		-- Disable Drag
		if Events[gui] ~= nil then
			Events[gui].UISconnection:Disconnect()
			Events[gui].ICconnection:Disconnect()
			Events[gui].IBconnection:Disconnect()
		end
	end
end

return Module
