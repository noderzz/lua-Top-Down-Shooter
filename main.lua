function love.load()
    -- Sprites Values
    sprites = {}
    sprites.background = love.graphics.newImage("sprites/background.png")
    sprites.bullet = love.graphics.newImage("sprites/bullet.png")
    sprites.player = love.graphics.newImage("sprites/player.png")
    sprites.zombie = love.graphics.newImage("sprites/zombie.png")

    -- Player Values
end

function love.update(dt)

end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)
end
