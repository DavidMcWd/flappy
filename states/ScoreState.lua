--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- adding a medal system that displays different medals depending on final score
    if self.score == 0 then
        self.scoreMessage = 'Oof! You Lost!'
    elseif  self.score > 0 and self.score <= 3 then
        self.scoreMessage = "You Earned a Bronze Medal!"
        self.medal = gTextures['bronze']
    elseif  self.score > 3 and self.score <=6  then
        self.scoreMessage = "You Earned a Silver Medal!"
        self.medal = gTextures['silver']
    else
        self.scoreMessage = "You Earned a Gold Medal"
        self.medal = gTextures['gold']
    end

    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)

    love.graphics.printf(self.scoreMessage, 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.score > 0 then
    love.graphics.draw(self.medal, VIRTUAL_WIDTH / 2 - (self.medal:getWidth() * 0.75 / 2), 120, 0, 0.75)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 180, VIRTUAL_WIDTH, 'center')
end