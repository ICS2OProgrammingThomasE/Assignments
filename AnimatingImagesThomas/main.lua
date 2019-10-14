-- Title: Animating images
-- Name: Thomas
-- Course: ICS2O/3C




-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------------------------

local millenniumFalcon
local tieFighter1
local tieFighter2
local DeathStar
local explosion
local starWarsObject
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- CODE
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- background image with width and height 
local backgroundImage = display.newImageRect("Images/background.png", 2048, 1536)

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- displays tieFighter1 with height and width
local tieFighter1 = display.newImageRect("Images/tieFighter.png", 200, 200)

-- sets the initial x and y of tieFighter1
tieFighter1.x = 0
tieFighter1.y = 550

-- displays DeathStar with height and width
local deathStar = display.newImageRect("Images/DeathStar.png", 200, 200)

-- sets the initial x and y of deathStar
deathStar.x = 650
deathStar.y = 350

deathStar.alpha = 1 

-- displays explosion with height and width
local explosion = display.newImageRect("Images/explosion.png", 300, 300)

-- sets the initial x and y of explosion
explosion.x = 650
explosion.y = 350

explosion.alpha = 0

-- displays tieFighter2 with height and width
local tieFighter2 = display.newImageRect("Images/tieFighter.png", 200, 200)

-- sets the initial x and y of tieFighter1
tieFighter2.x = display.contentWidth/3
tieFighter2.y = 0

-- displays millenniumFalcon with height and width
local millenniumFalcon = display.newImageRect("Images/millenniumFalcon.png", 200, 200)

-- sets the initial x and y of tieFighter1
millenniumFalcon.x = 0
millenniumFalcon.y = 700
millenniumFalcon.alpha = 1

-- displays "star Wars" and sets the colour 
starWarsObject = display.newText( "Star Wars", display.contentWidth/2, 700, nil, 150 )
starWarsObject:setTextColor(255/255, 255/255, 0/255)
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- GlOBAL VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------------------------

scrollSpeed = 3

-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
------------------------------------------------------------------------------------------------------------------------------------------------------
-- moves tieFighter1 across the screen
local function movetieFighter1 (event)
	tieFighter1.x = tieFighter1.x + scrollSpeed
end

-- MoveTieFighter1 will be called over and over again
Runtime:addEventListener("enterFrame", movetieFighter1)

-- moves tieFighter2 across the screen
local function movetieFighter2 (event)
	tieFighter2.y = tieFighter2.y + scrollSpeed
end

-- MoveTieFighter2 will be called over and over again
Runtime:addEventListener("enterFrame", movetieFighter2)

-- moves millenniumFalcon diagonally across the screen and fades out
local function movemillenniumFalcon (event)
	-- changes the x of millenium falcon
	millenniumFalcon.x = millenniumFalcon.x + 3
	-- changes the y of millennium falcon
	millenniumFalcon.y = millenniumFalcon.y - 3
	if (millenniumFalcon.y < 150) then
		millenniumFalcon.alpha = millenniumFalcon.alpha - 0.04
	end
end

Runtime:addEventListener("enterFrame", movemillenniumFalcon)

local function hideDeathStar ()
	deathStar.alpha = 0
	explosion.alpha = 1
end


local function shrinkDeathStar (event)
	-- shrinks DeathStar until its height and width = 50 then disapears
	if (deathStar.height > 100) then
		deathStar.height = deathStar.height - 1
		deathStar.width = deathStar.width - 1 
	else 
		timer.performWithDelay(2000, hideDeathStar())
	end
end

Runtime:addEventListener("enterFrame", shrinkDeathStar)


