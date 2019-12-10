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

local lives = 3
local heart1
local heart2
local heart3
local syringe
local points = 0
local questionText
local answer1
local answer2
local answer3
local correctAnswer
local alternateAnswer1
local alternateAnswer2

-- Boolean variable that states if user clicked the answer or not
local alreadyClickedAnswer = false


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAl SOUNDS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions-------------------------------
----------------------------------------------------------------





-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu",transitionOptions )
end

-- The function that will go to the main menu 
local function gotoYouLose()
    composer.gotoScene( "you_lose")
end

local function UpdateTime()
    
    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1

    -- display the number of seconds left in the clock object
    clockText.text = secondsLeft .. ""

    if (secondsLeft == 0) then
        -- reset the number of seconds left
        secondsLeft = totalSeconds
        lives = lives - 1

        -- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW LOSE IMAGE
        -- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
        if (lives == 2) then
            heart3.isVisible = false
        elseif (lives == 1) then
            heart2.isVisible = false
        elseif (lives == 0) then 
            heart1.isVisible = false
            CancelTimer()
            gotoYouLose()
        end
    end
end



-- function that calls the timer 
local function StartTimer()
    -- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

-- function that ends the timer
function CancelTimer()
    timer.cancel(countDownTimer)
end

-- Function that changes the answers for a new question and places them randomly in one of the positions
local function DisplayAnswers( )

    local answerPosition = math.random(1,3)
    answerTextObject.text = tostring( answer )
    wrongAnswer1TextObject.text = tostring( wrongAnswer1 )
    wrongAnswer2TextObject.text = tostring( wrongAnswer2 )

    if (answerPosition == 1) then                
        
        answerTextObject.x = display.contentWidth*.3        
        wrongAnswer1TextObject.x = display.contentWidth*.2
        wrongAnswer2TextObject.x = display.contentWidth*.1 

    elseif (answerPosition == 2) then
       
        answerTextObject.x = display.contentWidth*.2        
        wrongAnswer1TextObject.x = display.contentWidth*.1
        wrongAnswer2TextObject.x = display.contentWidth*.3 

    else
       
        answerTextObject.x = display.contentWidth*.1        
        wrongAnswer1TextObject.x = display.contentWidth*.2
        wrongAnswer2TextObject.x = display.contentWidth*.3
    end

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

    -- displays the clock co
    clockText = display.newText(secondsLeft, 790, 100, nil, 60)
    clockText:setTextColor(0/255, 0/255, 0/255)
    clockText.height = 100
    
    -- creating the syringe
    syringe = display.newImageRect("Images/syringe@2x.png", 100, 200)
    syringe.x = 125
    syringe.y = 100

    heart3 = display.newImageRect("Images/heart@2x.png", 50, 50)
    heart3.x = 165
    heart3.y = 225

    heart2 = display.newImageRect("Images/heart@2x.png", 50, 50)
    heart2.x = 85
    heart2.y = 225

    heart1 = display.newImageRect("Images/heart@2x.png", 50, 50)
    heart1.x = 125
    heart1.y = 225

    questionText = display.newText(" What tool do you use to help your patient? ", 600, 250, nil, 35)
    questionText:setTextColor(230/255, 0/255, 200/255) 

    -- Associating button widgets with this scene
    sceneGroup:insert( timerObject)
    sceneGroup:insert( clockText )
    sceneGroup:insert( syringe )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( questionText )
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