-- Title: Math Quiz
-- Name: Thomas
-- Course: ICS2O/3C
-------------------------------------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background
local bkg = display.newImageRect("Images/background.jpg", display.contentWidth, display.contentHeight)
bkg.x = display.contentCenterX
bkg.y = display.contentCenterY
------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local randomNumber3
local ramdomNumber4
local divQuestion
local srQuestion
local tempRandomNumber3
local userAnswer
local correctAnswer
local incorrectAnswer 
local points = 0
local lives = 4
local loseObject
local livesObject
local pointsObject
local winObject
local randomOperator

-- variables for the timer
local totalSeconds = 10 
local secondsLeft = 10
local clockText
local countDownTimer

local heart1
local heart2
local heart3
local heart4

-------------------------------------------------------------------------------------------------------------------------
-- SOUNDS
-------------------------------------------------------------------------------------------------------------------------------------------------

-- correct sound
local correctSound = audio.loadSound( "Sounds/correctSound.mp3" ) -- Setting a variable to an mp3 field
local correctSoundChannel

-- wrong sound
local wrongSound = audio.loadSound( "Sounds/wrongSound.mp3" ) -- Setting a variable to an mp3 field
local wrongSoundChannel
-----------------------------------------------------------------------------------------------------------
-- local Functions
-------------------------------------------------------------------------------------------------------------------


local function UpdateTime()
	
	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1

	-- display the number of seconds left in the clock object
	clockText.text = "time left = " .. secondsLeft .. ""

	if (secondsLeft == 0) then
		-- reset the number of seconds left
		secondsLeft = totalSeconds
		lives = lives - 1
		AskQuestion()

		-- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW LOSE IMAGE
		-- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE 
		if (lives == 3) then
			heart4.isVisible = false
		elseif (lives == 2) then
			heart3.isVisible = false
		elseif (lives == 1) then
			heart2.isVisible = false
		elseif (lives == 0) then 
			heart1.isVisible = false
			Lose()
		end
	end
end

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinitely
	countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end

local function EndTimer()
	timer.cancel(countDownTimer)
end

function AskQuestion()
	-- generate 2 random numbers between a max. and a min. number
	randomNumber1 = math.random(1, 10)
	randomNumber2 = math.random(1, 10)

	-- chooses a random operator
	randomOperator = math.random(1, 5)
	

	if (randomOperator == 1) then
		correctAnswer = randomNumber1 + randomNumber2

		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "

	elseif (randomOperator == 2) then
		
		if (randomNumber1 < randomNumber2) then
			tempRandomNumber3 = randomNumber1
			randomNumber1 = randomNumber2
			randomNumber2 = tempRandomNumber3
		end

		correctAnswer = randomNumber1 - randomNumber2

		--create question in text object
		questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
		
	
	elseif (randomOperator == 3) then
		correctAnswer = randomNumber1 * randomNumber2

		--create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	elseif (randomOperator == 4) then
		randomNumber3 = math.random(1, 10)
		ramdomNumber4 = math.random(1, 10)
		divQuestion = randomNumber3 * ramdomNumber4
		correctAnswer = divQuestion / randomNumber3
		questionObject.text = divQuestion .. " ÷ " .. randomNumber3 .." = "

	elseif (randomOperator == 5) then
		srQuestion = randomNumber1 * randomNumber1
		correctAnswer = randomNumber1
		questionObject.text = " √ " .. srQuestion  .." = "
	end	
end


local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	IncorrectObject.isVisible = false
	AskQuestion()
end

local function numericFieldListener( event )

	-- User begins editing "numericField"
	if ( event.phase == "began" ) then

		-- clear text field
		event.target.text = " "

	elseif (event.phase == "submitted") then
		userAnswer = tonumber(event.target.text)

		-- when the answer is submitted (enter key is pressed) set user input to user's answer 
		if (userAnswer == correctAnswer) then
			IncorrectObject.isVisible = false
			correctObject.isVisible = true
			timer.performWithDelay(1000, HideCorrect)
			event.target.text = " "
			points = points + 1
			pointsObject.text = "Points = " .. points
			correctSoundChannel = audio.play(correctSound)
			secondsLeft = 10
			if (points == 5) then
				
				--hide everything
				IncorrectObject.isVisible = false
				correctObject.isVisible = false
				numericField.isVisible = false
				questionObject.isVisible = false
				pointsObject.isVisible = false
				clockText.isVisible = false
				heart1.isVisible = false
				heart2.isVisible = false
				heart3.isVisible = false
				heart4.isVisible = false
				EndTimer()
				bkg.isVisible = false
				--display you win
				winObject.isVisible = true
				winBkg.x = display.contentCenterX
				winBkg.y = display.contentCenterY
			end

		else 
			IncorrectObject.isVisible = true
			correctObject.isVisible = false
			timer.performWithDelay(2000, HideIncorrect)
			event.target.text = " "			
			lives = lives - 1
			if (lives == 3) then
				heart4.isVisible = false
			elseif (lives == 2) then
				heart3.isVisible = false
			elseif (lives == 1) then
				heart2.isVisible = false
			elseif (lives == 0) then 
				heart1.isVisible = false
			end
			secondsLeft = 10
			wrongSoundChannel = audio.play(wrongSound)

			if (lives == 0) then
				Lose()
			end
		end
	end	
end

function Lose()
	-- hide everything
	IncorrectObject.isVisible = false
	correctObject.isVisible = false
	numericField.isVisible = false
	questionObject.isVisible = false
	pointsObject.isVisible = false
	clockText.isVisible = false
	heart1.isVisible = false
	heart2.isVisible = false
	heart3.isVisible = false
	heart4.isVisible = false
	EndTimer()
	-- display you lose
	loseObject.isVisible = true
	bkg.isVisible = false
	
end



----------------------------------------------------------------------------------------------------------------------------
-- object creation
----------------------------------------------------------------------------------------------------------------------------

-- displays a question and sets the colour 
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
questionObject:setTextColor(255/255, 20/255, 0/255)

-- displays "you lose" and sets the colour 
loseObject = display.newText( "You Lose", display.contentWidth/2, display.contentHeight/2, nil, 200 )
loseObject:setTextColor(255/255, 0/255, 0/255)
loseObject.isVisible = false

-- displays the point count
pointsObject = display.newText("points = " .. points, display.contentWidth/4.5, display.contentHeight/4, nil, 50 )
pointsObject:setTextColor(255/255, 20/255, 0/255)

-- displays "you win" and sets the colour 
winObject = display.newText( "You Win", display.contentWidth/2, display.contentHeight/2, nil, 200 )
winObject:setTextColor(0/255, 255/255, 5/255)
winObject.isVisible = false

-- create the text and make it invisible
correctObject = display.newText( "Correct", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(0/255, 204/255, 0/255)
correctObject.isVisible = false

-- create the text and make it invisible
IncorrectObject = display.newText( "Incorrect", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
IncorrectObject:setTextColor(255/255, 0/255, 0/255)
IncorrectObject.isVisible = false

-- create numeric field 
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80 )
numericField.inputType = "number"

-- add the event listener for the numeric field 
numericField:addEventListener( "userInput", numericFieldListener )

-- displays the clock count
clockText = display.newText("time left = " .. secondsLeft, 800, display.contentHeight/4, nil, 50 )
clockText:setTextColor(255/255, 20/255, 0/255)

-- create the lives to display on the screen
heart4 = display.newImageRect("Images/heart.png", 100, 100)
heart4.x = display.contentWidth * 7 / 8
heart4.y = display.contentHeight * 1 / 7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth * 6 / 8
heart3.y = display.contentHeight * 1 / 7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth * 5 / 8
heart2.y = display.contentHeight * 1 / 7

heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth * 4 / 8
heart1.y = display.contentHeight * 1 / 7
---------------------------------------------------------------------------------------------------------------------------------------
-- function calls
--------------------------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()
StartTimer()