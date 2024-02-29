
--[[
    Scripts specific to 5M Tycoon Roleplay
]]
RegisterNetEvent('QBCore:Client:OnSharedUpdate')
RegisterNetEvent('QBCore:Client:SyncItems')

local itemSyncAck = false


AddEventHandler('QBCore:Client:OnSharedUpdate', function(action, itemName, item)
    if action:upper() == "ITEMS" then
        if type(itemName) ~= "string" then
            return false, "invalid_item_name"
        end
    
        if QBCore.Shared.Items[itemName] then
            return false, "item_exists"
        end
        QBCore.Shared.Items[itemName] = item
        
        TriggerEvent('QBCore:Client:UpdateObject')
        return true, "success"
    end
    return false, "not_items"
end)


AddEventHandler('QBCore:Client:SyncItems', function(newItemList)
    itemSyncAck = true
    local numItems, numExisting, numFinal = 0, 0, 0
    for itemNames,itemData in pairs (newItemList) do
        numItems = numItems + 1
    end
    for itemNames,itemData in pairs (QBCore.Shared.Items) do
        numExisting = numExisting + 1
    end
    print("Received "..numItems.." from Server (Currently tracking "..numExisting..")")
    for newItemName, newItemData in pairs (newItemList) do
        QBCore.Shared.Items[newItemName] = newItemData
        numFinal = numFinal + 1
    end
    print("Tracking "..numFinal.." items after update.")
    TriggerEvent('QBCore:Client:UpdateObject')
end)

CreateThread(function()
    while not QBCore do Wait(100) end
    Wait(1000)
    repeat
        TriggerServerEvent('QBCore:Server:GetUpdatedItems')
        Wait(3000)
    until itemSyncAck
end)