-- Title: 
-- Name: Thomas
-- this is the main menu screen for the game for the corpus kids

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
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )


----------------------------------------------------------------------------------------------
-- GLOBAL VARIABLES--------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
soundOn = true

----------------------------------------------------------------------------------------------
-- LOCAL VARIABLES--------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
local playButton
local instructionsButton
local creditsButton
local muteButton
local unmuteButton


----------------------------------------------------------------------------------------------
-- GLOBAL SOUNDS--------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
bkgMusic = audio.loadStream("Sounds/bkgmusic.mp3")
-----------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------

-- Pre-Setting Transition Options
local transitionOptions = (
    {
        effect = "slideLeft",
        time = 1000
    })

-- Pre-Setting Transition Options
local transitionOptions1 = (
    {
        effect = "slideRight",
        time = 1000
    })

-- The function that will go to the level 2 screen
local function gotolevel2screen()
    composer.gotoScene( "level2_screen" )
end

-- The function that will go to the credits screen
local function gotocreditscreen()
    composer.gotoScene( "credits_screen", transitionOptions1 )
end

-- The function that will go to the main menu 
local function gotoinstructionscreen()
    composer.gotoScene( "instructions_screen", transitionOptions )
end

local function Mute (touch)
    if (touch.phase == "ended" ) then
        -- pause the sound
        audio.pause(bkgMusic)
        -- set the boolean variable to be false (sound is now muted)
        soundOn = false
        -- hide the mute button
        muteButton.isVisible = false
        -- show the unmute button
        unmuteButton.isVisible = true
    end
end

local function unmute (touch)
    if (touch.phase == "ended" ) then
        -- play the sound
        audio.resume(bkgMusic)
        -- set the boolean variable to be false (sound is now on)
        soundOn = true
        -- hide the mute button
        muteButton.isVisible = true
        -- show the unmute button
        unmuteButton.isVisible = false
    end
end

-----------------------------------------------------------------------------------------
-- GLOBAL SCENE FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function called when the screen doesn't exist
function scene:create( event )

    -- Creating a group that associates objects with the scene
    local sceneGroup = self.view

    -- sets the background 
    -- Insert the background image
    bkg_image = display.newImageRect("Images/MainMenuThomas@2x.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    ---- creating mute button
    muteButton = display.newImageRect("Images/muteButtonthomas@2x.png", 200, 200)
    muteButton.x = 900
    muteButton.y = 100
    muteButton.height = 150
    muteButton.width = 150
    muteButton.isVisible = true

    -- creating unmute button
    unmuteButton = display.newImageRect("Images/unmuteButtonthomas@2x.png", 200, 200)
    unmuteButton.x = 900
    unmuteButton.y = 100
    unmuteButton.height = 150
    unmuteButton.width = 150
    unmuteButton.isVisible = false


    -----------------------------------------------------------------------------------------
    -- BUTTON WIDGETS
    -----------------------------------------------------------------------------------------   

    -- Creating Play Button
    playButton = widget.newButton( 
        {   
			-- Set its position and its size
			x = display.contentWidth/2 - 25,
			y = display.contentHeight/2 - 25,
			width = 200,
            height = 200,
			
			-- Insert the images here 
			defaultFile = "Images/PlayButtonUnpressedThomas@2x.png",
			overFile = "Images/PlayButtonPressedThomas@2x.png",

			-- When the button is released, call the Level1 screen transition function
			onRelease = gotolevel2screen          
		} )

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 300,
            y = 650,
			width = 250,
            height = 125,
            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedThomas@2x.png",
            overFile = "Images/CreditsButtonPressedThomas@2x.png",

            -- When the button is released, call the Credits transition function
            onRelease = gotocreditscreen
        } ) 
	
	-- Creating instructions Button
    instructionsButton = widget.newButton( 
        {   
			-- Set its position on the screen relative to the screen size
            x = 700,
            y = 650,
			width = 250,
            height = 125,


			-- Insert the images here 
			defaultFile = "Images/InstructionsButtonUnpressedThomas@2x.png",
			overFile = "Images/InstructionsButtonPressedThomas@2x.png",

			-- When the button is released, call the Level1 screen transition function
			onRelease = gotoinstructionscreen          
		} )
	--------------------------------------------------------------------------------------------------
    
    -- Associating button widgets with this scene
    sceneGroup:insert( bkg_image ) 
    sceneGroup:insert( muteButton )
    sceneGroup:insert( unmuteButton )
    sceneGroup:insert( playButton )
    sceneGroup:insert( creditsButton )
    sceneGroup:insert( instructionsButton )
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
        bkgMusicChannel = audio.play(bkgMusic, {loops = -1})
        muteButton:addEventListener("touch", Mute)
        unmuteButton:addEventListener("touch", unmute)
        
        if (soundOn == true) then
            audio.resume(bkgMusicChannel)
            muteButton.isVisible = true
            unmuteButton.isVisible = false
        else
            audio.pause(bkgMusicChannel)
            muteButton.isVisible = false
            unmuteButton.isVisible = true
        end
    end

end --function scene:show( event )

-----------------------------------------------------------------------------------------

-- The function called when the scene is issued to leave the screen
function scene:hide( event )

    -- Creating  a group that associates objects with the scene
    local sceneGroup = self.view
    local phase = event.phase

    -----------------------------------------------------------------------------------------


    if ( phase == "will" ) then 
        -- Called when the scene is on screen (but is about to go off screen).
        -- Insert code here to "pause" the scene.
        -- Example: stop timers, stop animation, stop audio, etc.

    -----------------------------------------------------------------------------------------


    elseif ( phase == "did" ) then
    	    -- Called immediately after scene goes off screen.
            muteButton:removeEventListener("touch", Mute)
            unmuteButton:removeEventListener("touch", unmute)
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