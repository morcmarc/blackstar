function checkControlEvents(player)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    if love.keyboard.isDown("right") then
        player.goRight()
    end

    if love.keyboard.isDown("left") then
        player.goLeft()
    end

    if love.keyboard.isDown("up") then
        player.jump()
    end
end