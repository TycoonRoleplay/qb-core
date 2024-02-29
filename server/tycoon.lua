
RegisterServerEvent('QBCore:Server:GetUpdatedItems')

AddEventHandler('QBCore:Server:GetUpdatedItems', function()
    local playerSrc = source
    local items = QBCore.Shared.Items
    local numItems = 0
    for itemNames,itemData in pairs (items) do
        numItems = numItems + 1
    end
    print("Sending "..numItems.." to "..GetPlayerName(playerSrc).." ("..playerSrc..")")
    TriggerClientEvent('QBCore:Client:SyncItems', playerSrc, items)
end)