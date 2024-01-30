function love.load()
    -- Sprite Values
    sprites = {}
    sprites.background = love.graphics.newImage("sprites/background.png")
    sprites.bullet = love.graphics.newImage("sprites/bullet.png")
    sprites.player = love.graphics.newImage("sprites/player.png")
    sprites.zombie = love.graphics.newImage("sprites/zombie.png")

    -- Player Values
    player = {}
    player.x = love.graphics.getWidth() / 2
    player.y = love.graphics.getHeight() / 2
    player.speed = 180

    -- Zombie Values
    zombies = {}

    -- Bullets
    bullets = {}
end

function love.update(dt)
    -- Player Movement
    if love.keyboard.isDown("d") then
        player.x = player.x + (player.speed * dt)
    end
    if love.keyboard.isDown("a") then
        player.x = player.x - (player.speed * dt)
    end
    if love.keyboard.isDown("w") then
        player.y = player.y - (player.speed * dt)
    end 
    if love.keyboard.isDown("s") then
        player.y = player.y + (player.speed * dt)
    end

    for i,z in ipairs(zombies) do
        z.x = z.x + math.cos(playerZombieAngle(z)) * z.speed * dt
        z.y = z.y + math.sin(playerZombieAngle(z)) * z.speed * dt
        
        if distanceBetween(z.x, z.y, player.x, player.y) < 30 then
            for i,z in ipairs(zombies) do
                zombies[i] = nil
            end
        end
    end

    for i,b in ipairs(bullets) do
        b.x = b.x + math.cos(b.direction) * b.speed * dt
        b.y = b.y + math.sin(b.direction) * b.speed * dt
    end
end

function love.draw()
    love.graphics.draw(sprites.background, 0, 0)
    love.graphics.draw(sprites.player, player.x, player.y, playerMouseAngle(), nil, nil, sprites.player:getWidth() / 2, sprites.player:getHeight() / 2)

    for i,z in ipairs(zombies) do 
        love.graphics.draw(sprites.zombie, z.x, z.y, playerZombieAngle(z), nil, nil, sprites.zombie:getWidth() / 2, sprites.zombie:getHeight() / 2 )
    end

    for i,b in ipairs(bullets) do
        love.graphics.draw(sprites.bullet, b.x, b.y, b.direction, .5, .5)
    end
end

-- Calculate the angle between the line formed from the mouse to the sprite and the positive X axis.  This is then applied to the sprite to make it always face the mouse.
function playerMouseAngle()
    return math.atan2( love.mouse.getY() - player.y, love.mouse.getX() - player.x )
end

-- Calculate the angle between the line formed from the player to the zombie and the positive X axis.  This is then applied to the zombie to make it always face the player.
function playerZombieAngle(enemy)
    return math.atan2( player.y - enemy.y, player.x - enemy.x )
end

function love.mousepressed( x, y, button )
    if button == 1 then
        spawnBullet()
    end
end

function spawnZombie() 
    zombie = {}
    zombie.x = math.random(0, love.graphics.getWidth())
    zombie.y = math.random(0, love.graphics.getHeight())
    zombie.speed = 100
    table.insert(zombies, zombie)
end

function spawnBullet()
    local bullet = {}
    bullet.x = player.x 
    bullet.y = player.y 
    bullet.speed = 500
    bullet.direction = playerMouseAngle()
    table.insert(bullets, bullet)
end

function love.keypressed(key)
    if key == "space" then
        spawnZombie()
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt( (x2 - x1)^2 + (y2 - y1)^2 )
end