seedId = 3 -- Seed Id 
blocksId = 4 -- Blocks Id 
threshold = 200 -- Threshold for dropping
dropX = 50 -- X position for drop location
dropY = 50 -- Y position for drop location

delay = 300 -- Set delay Harvest

function Punch(x, y) 
    SendPacketRaw(false, {px = x, py = y, x = GetLocal().posX, y = GetLocal().posY, type = 3, value = 18}) 
end

function DropItem(itemId) 
    local inventory = GetLocal().inventory
    for _, item in ipairs(inventory) do
        if item.id == itemId and item.count >= threshold then
            SendPacketRaw(false, {type = 7, itemId = itemId, itemCount = 1, x = dropX, y = dropY})
            return
        end
    end
end

for _, tile in pairs(GetTiles()) do 
    if tile.fg == seedId then 
        FindPath(tile.x, tile.y) 
        Sleep(delay) 
        Punch(tile.x, tile.y) 
        Sleep(delay) 
        DropItem(seedId)
    elseif tile.fg == blocksId then 
        DropItem(blocksId)
    end 
end
