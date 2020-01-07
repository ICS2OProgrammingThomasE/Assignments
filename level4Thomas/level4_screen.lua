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
sceneName = "level4_screen"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAl VARIABLES -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local bkg

local backButton

local lives
local points

local heart1
local heart2
local heart3

local syringe

local question
local correctAnswer
local alternateAnswer1
local alternateAnswer2
local correctText
local incorrectText
local displayAnswerText

local X1 = display.contentWidth/2
local Y1 = 500
local Y2 = 550
local Y3 = 600

-- Variables containing the user answer and the actual answer
local userAnswer

-- boolean variables telling me which answer box was touched
local correctAnswerAlreadyTouched = false
local alternateAnswer1AlreadyTouched = false
local alternateAnswer2AlreadyTouched = false

--create textboxes holding answer and alternate answers 
local answerbox
local alternateAnswerBox1
local alternateAnswerBox2

-- create variables that will hold the previous x- and y-positions so that 
-- each answer will return back to its previous position after it is moved
local correctAnswerPreviousY 
local alternateAnswer1PreviousY
local alternateAnswer2PreviousY

local correctAnswerPreviousX = X1
local alternateAnswer1PreviousX = X1
local alternateAnswer2PreviousX = X1

-- the black box where the user will drag the answer
local userAnswerBoxPlaceholder

-- sound effects
local correctSound


-- Boolean variable that states if user clicked the answer or not
local alreadyClickedAnswer = false

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAl SOUNDS -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Functions-------------------------------
----------------------------------------------------------------

-- The function that will reset the score
local function resetScore()
    points = 0
    lives = 3
end

-- The function that will go to the main menu 
local function gotoYouLose()
    composer.gotoScene( "you_lose")
end

local function gotoYouWin()
    composer.gotoScene( "you_win")
end

local function DisplayQuestion()
    local randomNumber

    -- determines the question
    randomNumber = math.random(1,5)
    
    if (randomNumber == 1) then
        question.text = "What should you wear before ride a bicycle?"
        correctAnswer.text = "Helmet"
        alternateAnswer1.text = "Hat"
        alternateAnswer2.text = "sunglasses"
    elseif (randomNumber == 2) then
        question.text = "What should you do before you slide down a hill on a sled?"
        correctAnswer.text = "Check if anyone is in the way"
        alternateAnswer1.text = "Go without looking"
        alternateAnswer2.text = "Go down an icy part"
    elseif (randomNumber == 3) then
        question.text = "What should you do before you go to the beach?"
        correctAnswer.text = "Put on Sunscreen"
        alternateAnswer1.text = "Take a selfie"
        alternateAnswer2.text = "Eat some chips"
    elseif (randomNumber == 4) then
        question.text = "What should you do when you are playing outside?"
        correctAnswer.text = "Watch out for cars"
        alternateAnswer1.text = "Play rough games"
        alternateAnswer2.text = "Don't pay attention"
    elseif (randomNumber == 5) then
        question.text = "What should you do if you are dehydrated?"
        correctAnswer.text = "Drink a lot of water"
        alternateAnswer1.text = "Go swimming "
        alternateAnswer2.text = "Drink some soda"
    end    

    -- make it possible to click on the answers again
    correctAnswerAlreadyTouched = false
    alternateAnswer1AlreadyTouched = false
    alternateAnswer2AlreadyTouched = false
end

local function PositionAnswers()
    local randomPosition

    -------------------------------------------------------------------------------------------
    --ROMDOMLY SELECT ANSWER BOX POSITIONS
    -----------------------------------------------------------------------------------------
    randomPosition = math.random(1,3)

    -- random position 1
    if (randomPosition == 1) then
        -- set the new y-positions of each of the answers
        correctAnswer.x = X1
        correctAnswer.y = Y1
        correctAnswerPreviousY = Y1
        displayAnswerText.y = Y1
        --alternateAnswerBox2
        alternateAnswer2.x = X1
        alternateAnswer2.y = Y2
        alternateAnswer2PreviousY = Y2
        --alternateAnswerBox1
        alternateAnswer1.x = X1
        alternateAnswer1.y = Y3
        alternateAnswer1PreviousY = Y3
        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        alternateAnswer1PreviousX = alternateAnswer1.x
        alternateAnswer2PreviousX = alternateAnswer2.x
        correctAnswerPreviousX = correctAnswer.x


    -- random position 2
    elseif (randomPosition == 2) then

        correctAnswer.x = X1
        correctAnswer.y = Y2
        correctAnswerPreviousY = Y2
        displayAnswerText.y = Y2
        --alternateAnswerBox2
        alternateAnswer2.x = X1
        alternateAnswer2.y = Y3
        alternateAnswer2PreviousY = Y3
        --alternateAnswerBox1
        alternateAnswer1.x = X1
        alternateAnswer1.y = Y1
        alternateAnswer1PreviousY = Y1
        --remembering their positions to return the answer in case it's wrong
        alternateAnswer1PreviousX = alternateAnswer1.x
        alternateAnswer2PreviousX = alternateAnswer2.x
        correctAnswerPreviousX = correctAnswer.x
    -- random position 3
     elseif (randomPosition == 3) then
        correctAnswer.x = X1
        correctAnswer.y = Y3
        correctAnswerPreviousY = Y3
        displayAnswerText.y = Y3
        --alternateAnswerBox2
        alternateAnswer2.x = X1
        alternateAnswer2.y = Y1
        alternateAnswer2PreviousY = Y1
        --alternateAnswerBox1
        alternateAnswer1.x = X1
        alternateAnswer1.y = Y2
        alternateAnswer1PreviousY = Y2
        --remembering their positions to return the answer in case it's wrong
        alternateAnswer1PreviousX = alternateAnswer1.x
        alternateAnswer2PreviousX = alternateAnswer2.x
        correctAnswerPreviousX = correctAnswer.x
    end
end

local function heart1Transition()
    heart1.y = heart1.y + 1 
end

local function heart2Transition()
    heart2.y = heart2.y + 1 
end

local function heart3Transition()
    heart3.y = heart3.y + 1 
end
-- Function to Restart Level 1
local function RestartLevel4()
    DisplayQuestion()
    PositionAnswers()
    correctText.isVisible = false    
    incorrectText.isVisible = false
    displayAnswerText.isVisible = false
end

local function CorrectUserInput()
    points = points + 1
    correctText.isVisible = true
    if (points == 3) then
        gotoYouWin()
        resetScore()
    else 
        timer.performWithDelay(1500, RestartLevel4) 
    end
end

local function IncorrectUserInput()
    lives = lives - 1 
    incorrectText.isVisible = true
    displayAnswerText.isVisible = true
    if (lives == 2) then 
        heart1.isVisible = false
        timer.performWithDelay(1500, RestartLevel4) 
    elseif (lives == 1 ) then 
        heart2.isVisible = false
        timer.performWithDelay(1500, RestartLevel4) 
    elseif(lives == 0) then
        heart3.isVisible = false
        gotoYouLose()
        resetScore()
    end
end

local function TouchListenerCorrectAnswer(touch)
    --only work if none of the other boxes have been touched
    if (alternateAnswer1AlreadyTouched == false) and 
        (alternateAnswer2AlreadyTouched == false) then

        if (touch.phase == "began") then

            --let other boxes know it has been clicked
            correctAnswerAlreadyTouched = true

        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            
            correctAnswer.x = touch.x
            correctAnswer.y = touch.y

        -- this occurs when they release the mouse
        elseif (touch.phase == "ended") then

            correctAnswerAlreadyTouched = false

              -- if the number is dragged into the userAnswerBox, place it in the center of it
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < correctAnswer.x ) and
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > correctAnswer.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < correctAnswer.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > correctAnswer.y ) ) then

                -- setting the position of the number to be in the center of the box
                correctAnswer.x = userAnswerBoxPlaceholder.x
                correctAnswer.y = userAnswerBoxPlaceholder.y

                -- call the function to check if the user's input is correct or not
                CorrectUserInput()

            --else make box go back to where it was
            else
                correctAnswer.x = correctAnswerPreviousX
                correctAnswer.y = correctAnswerPreviousY
            end
        end
    end                
end 

local function TouchListenerAlternateAnswer1(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (alternateAnswer2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswer1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswer1.x = touch.x
            alternateAnswer1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswer1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox1.y ) ) then

                alternateAnswer1.x = userAnswerBoxPlaceholder.x
                alternateAnswer1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                CorrectUserInput()

            --else make box go back to where it was
            else
                alternateAnswer1.x = alternateAnswer1PreviousX
                alternateAnswer1.y = alternateAnswer1PreviousY
            end
        end
    end
end 

local function TouchListenerAlternateAnswer1(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (alternateAnswer2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswer1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswer1.x = touch.x
            alternateAnswer1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswer1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswer1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswer1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswer1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswer1.y ) ) then

                alternateAnswer1.x = userAnswerBoxPlaceholder.x
                alternateAnswer1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                IncorrectUserInput()

            --else make box go back to where it was
            else
                alternateAnswer1.x = alternateAnswer1PreviousX
                alternateAnswer1.y = alternateAnswer1PreviousY
            end
        end
    end
end

local function TouchListenerAlternateAnswer2(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (alternateAnswer1AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswer2AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswer2.x = touch.x
            alternateAnswer2.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswer2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswer2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswer2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswer2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswer2.y ) ) then

                alternateAnswer2.x = userAnswerBoxPlaceholder.x
                alternateAnswer2.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer2

                -- call the function to check if the user's input is correct or not
                IncorrectUserInput()

            --else make box go back to where it was
            else
                alternateAnswer2.x = alternateAnswer2PreviousX
                alternateAnswer2.y = alternateAnswer2PreviousY
            end
        end
    end
end

-- Function that Adds Listeners to each answer box
local function AddTouchEventListeners()
    correctAnswer:addEventListener("touch", TouchListenerCorrectAnswer)
    alternateAnswer1:addEventListener("touch", TouchListenerAlternateAnswer1)
    alternateAnswer2:addEventListener("touch", TouchListenerAlternateAnswer2)
end 

-- Function that Removes Listeners to each answer box
local function RemoveTouchEventListeners()
    correctAnswer:addEventListener("touch", TouchListenerCorrectAnswer)
    alternateAnswer1:addEventListener("touch", TouchListenerAlternateAnswer1)
    alternateAnswer2:addEventListener("touch", TouchListenerAlternateAnswer2)
end 
-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view
	
    -- Display background
    bkg = display.newImage("Images/lvl4Screen@2x.png")
    bkg.x = display.contentCenterX
    bkg.y = display.contentCenterY
    bkg.width = display.contentWidth
    bkg.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg:toBack()
    
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

    --the text that displays the question
    question = display.newText("" , 0, 0, nil, 30)
    question:setTextColor(255/255, 0/255, 0/255)
    question.x = 550
    question.y = 200

    -- boolean variables stating whether or not the answer was touched
    correctAnswerAlreadyTouched = false
    alternateAnswer1AlreadyTouched = false
    alternateAnswer2AlreadyTouched = false

    --the text that displays correctAnswer
    correctAnswer = display.newText("1", X1, Y1, nil, 27)
    correctAnswer:setTextColor(255/255, 86/255, 1/255) -- sets text to orange
    --the text that displays alternateAnswer1
    alternateAnswer1 = display.newText("2", X1, Y1, nil, 27)
    alternateAnswer1:setTextColor(255/255, 86/255, 1/255) -- sets text to orange
    --the text that displays alternateAnswer2
    alternateAnswer2 = display.newText("3", X1, Y1, nil, 27)
    alternateAnswer2:setTextColor(255/255, 86/255, 1/255) -- sets text to orange
    -- set the x positions of each of the answer boxes
    answerboxPreviousX = display.contentWidth * 0.9
    alternateAnswerBox1PreviousX = display.contentWidth * 0.9
    alternateAnswerBox2PreviousX = display.contentWidth * 0.9


    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/answerBox@2x.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = 512
    userAnswerBoxPlaceholder.y = 350

    correctText = display.newText( "Correct!", 700, 350, nil, 30 )
    correctText:setTextColor(0/255,240/255,0/255) -- sets text to green
    correctText.isVisible = false

    incorrectText = display.newText( "Wrong!", 700, 350, nil, 30 )
    incorrectText:setTextColor(255/255,0/255,0/255) -- sets text to red
    incorrectText.isVisible = false

    -- X4 = the x of displayAnswerText
    displayAnswerText = display.newText( "correct answer:", 300, Y1, nil, 30 )
    displayAnswerText:setTextColor(9/255,200/255,0/255) -- sets text to green
    displayAnswerText.isVisible = false

    -- Associating button widgets with this scene
    sceneGroup:insert( bkg )
    sceneGroup:insert( syringe )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( question )
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( correctAnswer )
    sceneGroup:insert( alternateAnswer1 )
    sceneGroup:insert( alternateAnswer2 )
    sceneGroup:insert( correctText )
    sceneGroup:insert( incorrectText )
    sceneGroup:insert( displayAnswerText )
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
        lives = 3
        points = 0
        audio.pause(bkgMusicChannel) 
        RestartLevel4()
        resetScore()
        AddTouchEventListeners()

        if (heart1.isVisible == false ) then
            heart1.isVisible = true
            heart2.isVisible = true
            heart3.isVisible = true
        end
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
        RemoveTouchEventListeners()
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