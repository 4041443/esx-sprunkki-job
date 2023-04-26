ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('deliveryjob_pay')
AddEventHandler('deliveryjob_pay', function(deliverydistance)

    local xPlayer = ESX.GetPlayerFromId(source)
    if deliverydistance > 10000 then
        --TriggerEvent('discordbotti', GetPlayerName(source).." Triggerasi kuriiri homman")
        TriggerEvent('EasyAdmin:banPlayer', source, "Modmenu / event abuse: esx_kuriiri") 
    end
    xPlayer.addMoney(deliverydistance)
end)