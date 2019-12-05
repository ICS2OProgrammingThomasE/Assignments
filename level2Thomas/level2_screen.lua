-- Title: lvl 2 screen 
-- Name: Thomas
-- this is the level 2 screen for the game for the corpus kids

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
sceneName = "level2_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAl VARIABLES -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local backButton
local timerObject

-- variables for the timer
local totalSeconds = 10 
local secondsLeft = 10
local clockText
local countDownTimer

local heart1
local heart2
local heart3
local syringe

-----------------------------
-- Functions
---------------

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu",transitionOptions )
end

local function UpdateTime()
    
    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1

    -- display the number of seconds left in the clock object
    clockText.text = secondsLeft .. ""

    if (secondsLeft == 0) then
        -- reset the number of seconds left
        secondsLeft = totalSeconds
        --lives = lives - 1

        -- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW LOSE IMAGE
        ---- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
        --if (lives == 3) then
        --    heart4.isVisible = false
        --elseif (lives == 2) then
        --    heart3.isVisible = false
        --elseif (lives == 1) then
        --    heart2.isVisible = false
        --elseif (lives == 0) then 
        --    heart1.isVisible = false
        --elseif (lives == 0) then
        --    CancelTimer()
        --end
    end
end


-- function that calls the timer 
local function StartTimer()
    -- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

-- function that ends the timer
local function CancelTimer()
    timer.cancel(countDownTimer)
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- sets the colour of the background
	display.setDefault("background", 51/255, 153/255, 255/255 )

    -- creating the timer object
    timerObject = display.newImageRect("Images/timer@2x.png", 400, 200)
    timerObject.x = 800
    timerObject.y = 100

    -- displays the clock count
    clockText = display.newText(secondsLeft, 790, 100, nil, 60)
    clockText:setTextColor(0/255, 0/255, 0/255)
    clockText.height = 100
    
    -- creating the syringe
    syringe = display.newImageRect("Images/syringe@2x.png", 125, 250)
    syringe.x = 125
    syringe.y = 125

    -- Associating button widgets with this scene
    sceneGroup:insert( timerObject)
    sceneGroup:insert( clockText )
    sceneGroup:insert( syringe )

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
        audio.pause(bkgMusicChannel)
        StartTimer()
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
        --
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