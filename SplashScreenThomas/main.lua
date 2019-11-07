-- Title: Splash screen
-- Name: Thomas
-- this is the splash screen for the game for the corpus kids

----------------------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAl VARIABLES -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local logo = display.newImageRect("Images/Logo.png", 250, 250)

logo.x = display.contentCenterX
logo.y = display.contentCenterY
logo.alpha = 1
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GLOBAL VARIABLES -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-----------------------------
-- Functions
---------------

-- Desciption: This function shrinks logo until it reaches 200 in size
function ShrinkLogo(event)
	if (logo.height > 200) then
		logo.height = logo.height - 1
		logo.width = logo.width - 1
		if (logo.height == 200 ) then 
			Runtime:addEventListener("enterFrame", GrowLogo)
		end
	end
end

-- Desciption: This function shrinks logo until it reaches 200 in size
function GrowLogo(event)
	if (logo.height < 250) then
		logo.height = logo.height + 1
		logo.width = logo.width + 1
		if (logo.height == 250 ) then
			Runtime:addEventListener("enterFrame", ShrinkLogo)
		end
	end
end

-- MoveRocketShip will be called over and over again
Runtime:addEventListener("enterFrame", ShrinkLogo)