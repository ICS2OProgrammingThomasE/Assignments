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
-----------------------------
-- Functions
---------------


-- Functions that checks if the buttons have been clicked.
local function TouchListenerAnswer(event)
    -- get the object name that was clicked
    local object = event.target

    -- get the user answer from the text object that was clicked on    

    if (event.phase == "ended") then
        print("ended")
        correct.isVisible = true
        timer.performWithDelay(1000, HideCorrect)
        --increment points
        points = points + 1
       -- print("****points = "..points)
        correct.isVisible = true
        correctSoundChannel = audio.play(correctSound)

        secondsLeft = 10
        incorrect.isVisible = false
        print("***object.name = " .. object.name)

        RemoveAllTouchListeners()
        HideImages()

 
        

        if (points == 5) then
            composer.gotoScene( "YouWin_screen" )
            --increase the number correct by 1
            numberCorrect = numberCorrect + 1

            -- play correct sound 
            --correctSoundChannel = audio.play(correctSound)

            -- call RestartScene after 1 second
            timer.performWithDelay( 1000, RestartScene )
        else
            timer.performWithDelay( 1000, AskQuestionLevel1 )
            --AskQuestionLevel1()
        end        

    end
end

local function TouchListenerWrongAnswer1(event)
    local object = event.target
    -- get the user answer from the text object that was clicked on
    if (event.phase == "ended") then

        lives = lives - 1
        print("***object.name = " .. object.name)
        --object:removeEventListener("touch", TouchListenerWrongAnswer1)
        --RemoveTouchListenersQ1()
        RemoveAllTouchListeners()
        HideImages()

        incorrect.isVisible = true
        correct.isVisible = false

        wrongSoundChannel = audio.play(wrongSound)

        print("wronganswer1")

        if (lives == 3) then
            drop1.isVisible = false
            secondsLeft = 10
        elseif (lives == 2) then
            drop2.isVisible = false
            secondsLeft = 10
        elseif (lives == 1) then
            drop3.isVisible = false
            secondsLeft = 10
        end
        
        if (lives == 0) then
            composer.gotoScene( "YouLose_screen" )
            -- increase the number correct by 1
            --numberCorrect = numberCorrect + 1

            -- play correct sound 
            --correctSoundChannel = audio.play(correctSound)

            -- call RestartScene after 1 second
            --timer.performWithDelay( 1000, RestartScene )
        else
            timer.performWithDelay( 1000, AskQuestionLevel1 )
            --AskQuestionLevel1()
        end        

    end
end

local function TouchListenerWrongAnswer2(event)
    local object = event.target
    -- get the user answer from the text object that was clicked on
    if (event.phase == "ended") then

        lives = lives - 1
        print("***object.name = " .. object.name)
        --object:removeEventListener("touch", TouchListenerWrongAnswer2)
        --RemoveTouchListenersQ1()
        RemoveAllTouchListeners()
        HideImages()
        
        incorrect.isVisible = true
        correct.isVisible = false

        wrongSoundChannel = audio.play(wrongSound)
        
        print("wronganswer2")

        if (lives == 3) then
            drop1.isVisible = false
            secondsLeft = 10
        elseif (lives == 2) then
            drop2.isVisible = false
            secondsLeft = 10
        elseif (lives == 1) then
            drop3.isVisible = false
            secondsLeft = 10
        end
        
        if (lives == 0) then
            composer.gotoScene( "YouLose_screen" )
            -- increase the number correct by 1
            --numberCorrect = numberCorrect + 1
            incorrect.isVisible = false
            -- play correct sound 
            --correctSoundChannel = audio.play(correctSound)

            -- call RestartScene after 1 second
            --timer.performWithDelay( 1000, RestartScene )
        else
            --AskQuestionLevel1()
            timer.performWithDelay( 1000, AskQuestionLevel1 )
            --incorrect.isVisible = false
        end        

    end
end

function RemoveTouchListenersQ1()
    ice:removeEventListener("touch", TouchListenerAnswer)
    bandaid:removeEventListener("touch", TouchListenerWrongAnswer1)       
    tweezers:removeEventListener("touch", TouchListenerWrongAnswer2)
end

function RemoveTouchListenersQ2()
    polysporin:removeEventListener("touch", TouchListenerAnswer)
    bandaid:removeEventListener("touch", TouchListenerWrongAnswer1)       
    tweezers:removeEventListener("touch", TouchListenerWrongAnswer2)
end

function RemoveTouchListenersQ3()
    tweezers:removeEventListener("touch", TouchListenerAnswer)
    ice:removeEventListener("touch", TouchListenerWrongAnswer1)       
    bandaid:removeEventListener("touch", TouchListenerWrongAnswer2)   
end

function RemoveTouchListenersQ4()
    bandaid:removeEventListener("touch", TouchListenerAnswer)
    polysporin:removeEventListener("touch", TouchListenerWrongAnswer1)       
    tweezers:removeEventListener("touch", TouchListenerWrongAnswer2)
end

function RemoveAllTouchListeners()
    if (randomOperator == 1) then
        RemoveTouchListenersQ1()
    elseif (randomOperator == 2) then
        RemoveTouchListenersQ2()
    elseif (randomOperator == 3) then
        RemoveTouchListenersQ3()
    elseif (randomOperator == 4) then
        RemoveTouchListenersQ4()
    end
end

function NewQuestionTimer()
    if (lives == 3) then
        bruises.isVisible = false
        cuts.isVisible = false
        ice.isVisible = false
        splinters.isVisible = false
        beeSting.isVisible = false
        bandaid.isVisible = false
        tweezers.isVisible = false
        polysporin.isVisible = false
        RemoveAllTouchListeners()
        AskQuestionLevel1()
    elseif (lives == 2) then
        bruises.isVisible = false
        cuts.isVisible = false
        ice.isVisible = false
        splinters.isVisible = false
        beeSting.isVisible = false
        bandaid.isVisible = false
        tweezers.isVisible = false
        polysporin.isVisible = false
        RemoveAllTouchListeners()
        AskQuestionLevel1()
    elseif (lives == 1) then
        bruises.isVisible = false
        cuts.isVisible = false
        ice.isVisible = false
        splinters.isVisible = false
        beeSting.isVisible = false
        bandaid.isVisible = false
        tweezers.isVisible = false
        polysporin.isVisible = false
        RemoveAllTouchListeners()
        AskQuestionLevel1()
    elseif (lives == 0) then
        bruises.isVisible = false
        cuts.isVisible = false
        ice.isVisible = false
        splinters.isVisible = false
        beeSting.isVisible = false
        bandaid.isVisible = false
        tweezers.isVisible = false
        polysporin.isVisible = false
        RemoveAllTouchListeners()
        clockText.isVisible = false
        composer.gotoScene( "YouLose_screen" )
    end
end


function AskQuestionLevel1()
    randomOperator = math.random (1, 4)

    incorrect.isVisible = false
    correct.isVisible = false
    HideImages()

    if (randomOperator == 1) then
        -- question
        bruises.isVisible = true

        -- correct answer
        ice.isVisible = true
        ice:addEventListener("touch", TouchListenerAnswer)

        -- wrong answers
       -- cuts.isVisible = true
        --cuts:addEventListener("touch", TouchListenerWrongAnswer1)
        bandaid.isVisible = true
        bandaid:addEventListener("touch", TouchListenerWrongAnswer1)

        --splinters.isVisible = true
       -- splinters:addEventListener("touch", TouchListenerWrongAnswer2)
        tweezers.isVisible = true
        tweezers:addEventListener("touch", TouchListenerWrongAnswer2)

    elseif (randomOperator == 2) then
        --dave
        incorrect.isVisible = false
        correct.isVisible = false
        HideImages()
        
        -- question
        beeSting.isVisible = true

        -- correct answer
        --cuts.isVisible = true
        --cuts:addEventListener("touch", TouchListenerAnswer)
        polysporin.isVisible = true
        polysporin:addEventListener("touch", TouchListenerAnswer)

        -- wrong answers
        bandaid.isVisible = true
        bandaid:addEventListener("touch", TouchListenerWrongAnswer1)

        tweezers.isVisible = true
        tweezers:addEventListener("touch", TouchListenerWrongAnswer2)


    elseif (randomOperator == 3) then
        incorrect.isVisible = false
        correct.isVisible = false

        HideImages()
        --question
        splinters.isVisible = true

        -- correct answer
        tweezers.isVisible = true
        tweezers:addEventListener("touch", TouchListenerAnswer)

        -- wrong answers
        ice.isVisible = true
        ice:addEventListener("touch", TouchListenerWrongAnswer1)

        bandaid.isVisible = true
        bandaid:addEventListener("touch", TouchListenerWrongAnswer2)
    
    
    elseif (randomOperator == 4) then
        incorrect.isVisible = false
        correct.isVisible = false

        HideImages()

        -- question
        cuts.isVisible = true

        -- correct answer
        bandaid.isVisible = true
        bandaid:addEventListener("touch", TouchListenerAnswer)
        
        -- wrong answers
        polysporin.isVisible = true
        polysporin:addEventListener("touch", TouchListenerWrongAnswer1)

        tweezers.isVisible = true
        tweezers:addEventListener("touch", TouchListenerWrongAnswer2)
    end
end

--local function RestartScene()

    --correct.isVisible = false

    --livesText.text = "Number of lives = " .. tostring(lives)
    --numberCorrectText.text = "Number correct = " .. tostring(numberCorrect)

    -- if they have 0 lives, go to the You Lose screen
    ---if (lives == 0) then
        --composer.gotoScene("YouLose_screen")
    --else 

        --DisplayAddEquation()
        --DetermineAnswers()
        --DisplayAnswers()
        --AskQuestion()
    --end
--end



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
        lives = lives - 1

        -- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW LOSE IMAGE
        -- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
        if (lives == 2) then
            heart3.isVisible = false
        elseif (lives == 1) then
            heart2.isVisible = false
        elseif (lives == 0) then 
            heart1.isVisible = false
        elseif (lives == 0) then
            CancelTimer()
        end
    end
end

local function askQuestion()
    -- asks question

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

    -- Associating button widgets with this scene
    sceneGroup:insert( timerObject)
    sceneGroup:insert( clockText )
    sceneGroup:insert( syringe )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart1 )

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