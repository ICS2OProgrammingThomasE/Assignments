-- Title: 
-- Name: Thomas
-- this is the splash screen for the game for the corpus kids

----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- INITIALIZATIONS
-----------------------------------------------------------------------------------------

-- Use Composer Library
local composer = require( "composer" )

-----------------------------------------------------------------------------------------

-- Use Widget Library
local widget = require( "widget" )

-----------------------------------------------------------------------------------------

-- Naming Scene
sceneName = "splash_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAl VARIABLES -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local logo

-------------------
-- FUNCTIONS
-------------------

-- Desciption: This function fades out logo until it is invisible
local function FadeLogo(event)
    logo.alpha = logo.alpha - 0.1
end

-- Desciption: This function shrinks logo until it reaches 200 in size
function ShrinkLogo(event)
    if (logo.height > 200) then
        logo.height = logo.height - 1
        logo.width = logo.width - 1
        if (logo.height == 200 ) then 
            timer.performWithDelay( 1, GrowLogo, 50)
            timer.performWithDelay( 1000, FadeLogo, 10000)
        end
    end
end

-- Desciption: This function shrinks logo until it  reaches 200 in size
function GrowLogo(event)
    if (logo.height < 250) then
        logo.height = logo.height + 1
        logo.width = logo.width + 1
        if (logo.height == 250 ) then
            timer.performWithDelay( 1, ShrinkLogo, 50)
        end
    end
end

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu")
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- sets the colour of the background
    display.setDefault("background", 255/255, 255/255, 255/255 )
    
    -- creates logo and sets its position
    logo = display.newImageRect("Images/Logo@2x.png", 250, 250)
    logo.x = display.contentCenterX
    logo.y = display.contentCenterY
    logo.alpha = 1

    -- Insert objects into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( logo )
end -- function scene:create( event )

--------------------------------------------------------------------------------------------

-- The function called when the scene is issued to appear on screen
function scene:show( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------

    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is still off screen (but is about to come on screen).
    if ( phase == "will" ) then
       
    -----------------------------------------------------------------------------------------

    elseif ( phase == "did" ) then

        -- shrink will be called over and over again
        Runtime:addEventListener("enterFrame", ShrinkLogo)
        timer.performWithDelay(3000, gotoMainMenu)
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------

    -- Called when the scene is on screen (but is about to go off screen).
    -- Insert code here to "pause" the scene.
    -- Example: stop timers, stop animation, stop audio, etc.
    if ( phase == "will" ) then  

    -----------------------------------------------------------------------------------------

    -- Called immediately after scene goes off screen.
    elseif ( phase == "did" ) then
        -- shrink will be called over and over again
        Runtime:removeEventListener("enterFrame", ShrinkLogo)


    end

end --function scene:hide( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to be destroyed
function scene:destroy( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -----------------------------------------------------------------------------------------


    -- Called prior to the removal of scene's view ("sceneGroup").
    -- Insert code here to clean up the scene.
    -- Example: remove display objects, save state, etc.
end -- function scene:destroy( event )

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- Adding Event Listeners
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene