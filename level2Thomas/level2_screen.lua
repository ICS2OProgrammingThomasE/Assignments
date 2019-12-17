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

local lives = 3
local points = 0

local heart1
local heart2
local heart3

local syringe

local question
local correctAnswer
local alternateAnswer1
local alternateAnswer2

local X1 = 500
local X2 = 700
local X3 = 900
local Y1 = 600

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
local correctAnswerPreviousY = Y1
local alternateAnswer1PreviousY = Y1
local alternateAnswer2PreviousY = Y1 

local correctAnswerPreviousX
local alternateAnswer1PreviousX
local alternateAnswer2PreviousX

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

-- The function that will go to the main menu 
local function gotoMainMenu()
    composer.gotoScene( "main_menu",transitionOptions )
end

-- The function that will go to the main menu 
local function gotoYouLose()
    composer.gotoScene( "you_lose")
end


local function DisplayQuestion()
    local randomNumber

    -- determines the question
    randomNumber = math.random(1,5)
    
    if (randomNumber == 1) then
        question.text = "Which is the healthiest meal for breakfast?"
        correctAnswer.text = "Eggs"
        alternateAnswer1.text = "Fruit loops"
        alternateAnswer2.text = "Pancakes"
    elseif (randomNumber == 2) then
        question.text = "Which is the healthiest meal for dinner?"
        correctAnswer.text = "Fish"
        alternateAnswer1.text = "Pizza"
        alternateAnswer2.text = "Cake"
    elseif (randomNumber == 3) then
        question.text = "Which is the healthiest meal for lunch?"
        correctAnswer.text = "Sandwich"
        alternateAnswer1.text = "Ice cream"
        alternateAnswer2.text = "Hamburger"
    elseif (randomNumber == 4) then
        question.text = "Which is the healthiest snack?"
        correctAnswer.text = "Apple"
        alternateAnswer1.text = "Chocolat"
        alternateAnswer2.text = "Potato chips"
    elseif (randomNumber == 5) then
        question.text = "Which is the healthiest beverage?"
        correctAnswer.text = "Water"
        alternateAnswer1.text = "Pop"
        alternateAnswer2.text = "Juice"
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
        --alternateAnswerBox2
        alternateAnswer2.x = X2
        alternateAnswer2.y = Y1
        --alternateAnswerBox1
        alternateAnswer1.x = X3
        alternateAnswer1.y = Y1
        ---------------------------------------------------------
        --remembering their positions to return the answer in case it's wrong
        alternateAnswer1PreviousX = alternateAnswer1.x
        alternateAnswer2PreviousX = alternateAnswer2.x
        correctAnswerPreviousX = correctAnswer.x


    -- random position 2
    elseif (randomPosition == 2) then

        correctAnswer.x = X2
        correctAnswer.y = Y1
        --alternateAnswerBox2
        alternateAnswer2.x = X3
        alternateAnswer2.y = Y1
        --alternateAnswerBox1
        alternateAnswer1.x = X1
        alternateAnswer1.y = Y1
        --remembering their positions to return the answer in case it's wrong
        alternateAnswer1PreviousX = alternateAnswer1.x
        alternateAnswer2PreviousX = alternateAnswer2.x
        correctAnswerPreviousX = correctAnswer.x

    -- random position 3
     elseif (randomPosition == 3) then
        correctAnswer.x = X3
        correctAnswer.y = Y1
        --alternateAnswerBox2
        alternateAnswer2.x = X1
        alternateAnswer2.y = Y1
        --alternateAnswerBox1
        alternateAnswer1.x = X2
        alternateAnswer1.y = Y1
        --remembering their positions to return the answer in case it's wrong
        alternateAnswer1PreviousX = alternateAnswer1.x
        alternateAnswer2PreviousX = alternateAnswer2.x
        correctAnswerPreviousX = correctAnswer.x
    end
end

-- Function to Restart Level 1
local function RestartLevel1()
    DisplayQuestion()
    PositionAnswers()    
end

-- Function to Check User Input
local function CheckUserAnswerInput()
          
    timer.performWithDelay(1600, RestartLevel1) 
end

local function IncorrectUserInput()
    lives = lives - 1 
    if (lives == 2) then 
        heart1.isVisible = false
        timer.performWithDelay(1500, RestartLevel1) 
    elseif (lives == 1 ) then 
        heart2.isVisible = false
        timer.performWithDelay(1500, RestartLevel1) 
    elseif(lives == 0) then
        heart3.isVisible = false
        gotoYouLose()

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
                CheckUserAnswerInput()

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
            alternateAnswerBox1.x = touch.x
            alternateAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswer1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox1.y ) ) then

                alternateAnswerBox1.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                alternateAnswerBox1.x = alternateAnswerBox1PreviousX
                alternateAnswerBox1.y = alternateAnswerBox1PreviousY
            end
        end
    end
end 

local function TouchListenerAlternateAnswer2(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (alternateAnswer2AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswer1AlreadyTouched = true
            
        --drag the answer to follow the mouse
        elseif (touch.phase == "moved") then
            alternateAnswerBox1.x = touch.x
            alternateAnswerBox1.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswer1AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox1.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox1.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox1.y ) ) then

                alternateAnswerBox1.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox1.y = userAnswerBoxPlaceholder.y

                userAnswer = alternateAnswer1

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                alternateAnswerBox1.x = alternateAnswerBox1PreviousX
                alternateAnswerBox1.y = alternateAnswerBox1PreviousY
            end
        end
    end
end 

local function TouchListenerAnswerBox2(touch)
    --only work if none of the other boxes have been touched
    if (correctAnswerAlreadyTouched == false) and 
        (alternateAnswer1AlreadyTouched == false) then

        if (touch.phase == "began") then
            --let other boxes know it has been clicked
            alternateAnswer2AlreadyTouched = true
            
        elseif (touch.phase == "moved") then
            --dragging function
            alternateAnswerBox2.x = touch.x
            alternateAnswerBox2.y = touch.y

        elseif (touch.phase == "ended") then
            alternateAnswer2AlreadyTouched = false

            -- if the box is in the userAnswerBox Placeholder  go to center of placeholder
            if (((userAnswerBoxPlaceholder.x - userAnswerBoxPlaceholder.width/2) < alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.x + userAnswerBoxPlaceholder.width/2) > alternateAnswerBox2.x ) and 
                ((userAnswerBoxPlaceholder.y - userAnswerBoxPlaceholder.height/2) < alternateAnswerBox2.y ) and 
                ((userAnswerBoxPlaceholder.y + userAnswerBoxPlaceholder.height/2) > alternateAnswerBox2.y ) ) then

                alternateAnswerBox2.x = userAnswerBoxPlaceholder.x
                alternateAnswerBox2.y = userAnswerBoxPlaceholder.y
                userAnswer = alternateAnswer2

                -- call the function to check if the user's input is correct or not
                CheckUserAnswerInput()

            --else make box go back to where it was
            else
                alternateAnswerBox2.x = alternateAnswerBox2PreviousX
                alternateAnswerBox2.y = alternateAnswerBox2PreviousY
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

    -- sets the colour of the background
	display.setDefault("background", 51/255, 153/255, 255/255 )

    
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
    question.x = 700
    question.y = 300

    -- boolean variables stating whether or not the answer was touched
    correctAnswerAlreadyTouched = false
    alternateAnswer1AlreadyTouched = false
    alternateAnswer2AlreadyTouched = false

    --the text that displays the question
    correctAnswer = display.newText("1", X1, Y1, nil, 30)
    
    --the text that displays the question
    alternateAnswer1 = display.newText("2", X2, Y1, nil, 30)
    
    --the text that displays the question
    alternateAnswer2 = display.newText("3", X3, Y1, nil, 30)
    
    -- set the x positions of each of the answer boxes
    answerboxPreviousX = display.contentWidth * 0.9
    alternateAnswerBox1PreviousX = display.contentWidth * 0.9
    alternateAnswerBox2PreviousX = display.contentWidth * 0.9


    -- the black box where the user will drag the answer
    userAnswerBoxPlaceholder = display.newImageRect("Images/answerBox@2x.png",  130, 130, 0, 0)
    userAnswerBoxPlaceholder.x = 700
    userAnswerBoxPlaceholder.y = 450

    -- Associating button widgets with this scene
    sceneGroup:insert( syringe )
    sceneGroup:insert( heart3 )
    sceneGroup:insert( heart2 )
    sceneGroup:insert( heart1 )
    sceneGroup:insert( question )
    sceneGroup:insert( userAnswerBoxPlaceholder )
    sceneGroup:insert( correctAnswer )
    sceneGroup:insert( alternateAnswer1 )
    sceneGroup:insert( alternateAnswer2 )
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
        RestartLevel1()
        AddTouchEventListeners()
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