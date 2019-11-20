-- Title: 
-- Name: Thomas
-- this is the main menu screen for the game for the corpus kids

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
sceneName = "main_menu"

-----------------------------------------------------------------------------------------

-- Creating Scene Object
local scene = composer.newScene( sceneName )

----------------------------------------------------------------------------------------------
-- LOCAL VARIABLES--------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
local playButton
local instructionsButton
local creditsButton

-----------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------

-- The function that will go to the main menu 
local function gotolevel1screen()
    composer.gotoScene( "level1_screen" )
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
    bkg_image = display.newImageRect("Images/MainMenuThomas.png", display.contentWidth, display.contentHeight)
    bkg_image.x = display.contentCenterX
    bkg_image.y = display.contentCenterY
    bkg_image.width = display.contentWidth
    bkg_image.height = display.contentHeight

    -- Send the background image to the back layer so all other objects can be on top
    bkg_image:toBack()

     -- Insert background image into the scene group in order to ONLY be associated with this scene
    sceneGroup:insert( bkg_image )    

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
			defaultFile = "Images/PlayButtonUnpressedThomas.png",
			overFile = "Images/PlayButtonPressedThomas.png",

			-- When the button is released, call the Level1 screen transition function
			onRelease = gotolevel1screen          
		} )

    -- Creating Credits Button
    creditsButton = widget.newButton( 
        {
            -- Set its position on the screen relative to the screen size
            x = 300,
            y = 650,
			width = 200,
            height = 100,
            -- Insert the images here
            defaultFile = "Images/CreditsButtonUnpressedThomas.png",
            overFile = "Images/CreditsButtonPressedThomas.png",

            -- When the button is released, call the Credits transition function
            onRelease = CreditsTransition
        } ) 
	
	-- Creating instructions Button
    instructionsButton = widget.newButton( 
        {   
			-- Set its position on the screen relative to the screen size
            x = 700,
            y = 650,
			width = 200,
            height = 100,


			-- Insert the images here 
			defaultFile = "Images/InstructionsButtonUnpressedThomas.png",
			overFile = "Images/InstructionsButtonPressedThomas.png",

			-- When the button is released, call the Level1 screen transition function
			onRelease = Level1ScreenTransition          
		} )
	--------------------------------------------------------------------------------------------------
    
    -- Associating button widgets with this scene
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

		--
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