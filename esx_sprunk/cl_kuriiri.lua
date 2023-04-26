ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local hakupaikka = vector3(-571.06927490234,-1776.3900146484,23.180374145508)
local carpoint = vector3(-572.27642822266,-1783.2027587891,22.517280578613)
local driving = false
local deliverypoint = {}
local deliverydistance = nil
local cooldown = false
local delivered = false
local deliverypoints = {
[1] = {coords=vector3(-1271.6595458984,-1428.0672607422,4.353771686554)},
[2] = {coords=vector3(-476.43618774414,269.97619628906,83.199203491211)},
[3] = {coords=vector3(324.39654541016,96.952049255371,99.705718994141)},
[4] = {coords=vector3(1915.4074707031,582.55914306641,176.36744689941)},
[5] = {coords=vector3(2954.1950683594,2735.6857910156,44.326873779297)},
[6] = {coords=vector3(2594.7673339844,479.42660522461,108.48071289063)},
[7] = {coords=vector3(2670.3581542969,1600.7271728516,24.500690460205)},
[8] = {coords=vector3(173.69543457031,2778.6369628906,46.077301025391)},
[9] = {coords=vector3(639.78247070313,2778.388671875,41.973861694336)},
[10] = {coords=vector3(558.65557861328,2657.7346191406,42.168830871582)},
[11] = {coords=vector3(1894.267578125,3715.015625,32.761547088623)},
[12] = {coords=vector3(1219.2553710938,-3204.8894042969,5.6542053222656)},
[13] = {coords=vector3(-2079.5573730469,-335.42922973633,13.133531570435)},
[14] = {coords=vector3(-2956.5322265625,58.145088195801,11.608504295349)},
[15] = {coords=vector3(-2174.2934570313,4272.2885742188,48.983562469482)},
[16] = {coords=vector3(-1165.7602539063,-888.65826416016,14.114741325378)},
[17] = {coords=vector3(-1180.4942626953,-903.98687744141,13.512077331543)},
[18] = {coords=vector3(-1183.2723388672,-884.15216064453,13.745457649231)},
[19] = {coords=vector3(-74.316780090332,6427.5942382813,31.440059661865)},
[20] = {coords=vector3(-1302.4409179688,-614.49291992188,27.387674331665)},
[21] = {coords=vector3(659.66003417969,593.05328369141,129.05116271973)},
[22] = {coords=vector3(689.97351074219,602.21984863281,128.91111755371)},
[23] = {coords=vector3(924.66857910156,50.507377624512,80.764808654785)},
[24] = {coords=vector3(966.73016357422,1.945669054985,80.98641204834)},
[25] = {coords=vector3(1097.8424072266,67.133544921875,80.891319274902)},
[26] = {coords=vector3(900.79956054688,-189.08828735352,73.796943664551)},
[27] = {coords=vector3(1097.9622802734,-261.07757568359,68.644569396973)},
[28] = {coords=vector3(1140.7315673828,-308.64602661133,68.377983093262)},
[29] = {coords=vector3(1256.7248535156,-358.25714111328,68.475624084473)},
[30] = {coords=vector3(1164.365234375,-455.59463500977,66.977867126465)},
[31] = {coords=vector3(1157.3465576172,-453.59036254883,66.984397888184)},
[32] = {coords=vector3(1144.8012695313,-471.02685546875,66.559936523438)},
[33] = {coords=vector3(1135.0256347656,-793.81927490234,56.985721588135)},
[34] = {coords=vector3(1067.3199462891,-785.66351318359,57.656307220459)},
[35] = {coords=vector3(1085.9522705078,-342.65594482422,66.846656799316)},
[36] = {coords=vector3(813.28155517578,-280.97839355469,66.462600708008)},
[37] = {coords=vector3(711.25604248047,-302.16152954102,59.247741699219)},
[38] = {coords=vector3(548.05499267578,-207.90138244629,53.534519195557)},
[39] = {coords=vector3(534.24066162109,-151.21925354004,57.06969833374)},
[40] = {coords=vector3(500.78045654297,-98.510520935059,61.413326263428)},
[41] = {coords=vector3(361.71844482422,359.58407592773,103.35779571533)},
[42] = {coords=vector3(299.75253295898,368.06921386719,104.9125289917)},
[43] = {coords=vector3(253.3335723877,378.09854125977,105.11260223389)},
[44] = {coords=vector3(188.16452026367,306.03485107422,104.97756958008)},
[45] = {coords=vector3(17.845226287842,-236.63215637207,47.244956970215)},
[46] = {coords=vector3(-41.432460784912,-387.6794128418,38.163272857666)},
[47] = {coords=vector3(39.530582427979,-407.86141967773,39.530410766602)},
[48] = {coords=vector3(31.153886795044,-1025.294921875,29.064977645874)},
[49] = {coords=vector3(135.4302520752,-1050.5249023438,28.763605117798)},
[50] = {coords=vector3(1706.8477783203,6422.9594726563,32.244380950928)},
[51] = {coords=vector3(1578.7165527344,6449.1923828125,24.58557510376)},
}

Citizen.CreateThread(function()
	Wait(1000)
	jobiblip = AddBlipForCoord(hakupaikka)
	SetBlipSprite (jobiblip, 478)
	SetBlipColour (jobiblip, 67)
	SetBlipAsShortRange(jobiblip, true)
	SetBlipScale(jobiblip, 0.7)
	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Sprunkki')
	EndTextCommandSetBlipName(jobiblip)
	while true do
		local wait = 1000
		local coords = GetEntityCoords(PlayerPedId())
		if #(coords-carpoint) < 3 then
			if IsPedInAnyVehicle(PlayerPedId(), false) then
				ESX.ShowHelpNotification('Palauta auto ~INPUT_CONTEXT~')
				if IsControlJustPressed(0,38) then
					DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
				end
			else
				ESX.ShowHelpNotification('Ota auto ~INPUT_CONTEXT~')
				if IsControlJustPressed(0,38) then
					ESX.Game.SpawnVehicle("buffalo3", carpoint, 147.0, function(vehicle)
						TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle, -1)
					end)
					ESX.ShowNotification('Auto on hieman huonossa kunnossa - aja varovasti!')
				end
			end
		end
		if #(coords-hakupaikka) < 10 then
			wait = 0
			local x, y, z = table.unpack(hakupaikka)
			DrawMarker(3, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 3, 222, 3, 50, false, true, 2, false, false, false, false)
			local x2, y2, z2 = table.unpack(carpoint)
			DrawMarker(36, x2, y2, z2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 3, 222, 3, 50, false, true, 2, false, false, false, false)
			if #(coords-hakupaikka) < 3 then
				if delivered then
					ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ lopettaaksesi tehtävän')
					if IsControlJustPressed(0,38) then
						TriggerServerEvent('deliveryjob_pay', deliverydistance)
						driving = false
						delivered = false
						if deliverydistance > 2000 then
							ESX.ShowNotification('Hienoa! Tienasit: ' ..deliverydistance.. ' $')
						end
						elseif deliverydistance > 1000 and deliverydistance < 2000 then
							ESX.ShowNotification('Kerkesit juuri ja juuri! Tienasit: ' ..deliverydistance.. ' $')
						elseif deliverydistance < 1000 then
							ESX.ShowNotification('Hohhoijaa olet hidas... Tienasit vain: ' ..deliverydistance.. ' $')
						end
				else
					if driving then
						ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ lopettaaksesi tehtävä')
					else
						ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ aloittaksesi tehtävä')
					end
					if IsControlJustPressed(0,38) then
						if not cooldown then
							if not driving then
								ESX.ShowNotification('Toimita paketti kohteeseen')
								local random33 = math.random(1,#deliverypoints)
								deliverypoint = deliverypoints[random33]
								deliverydistance = math.floor(#(coords-deliverypoint.coords))
								deliverydistance = deliverydistance + 850
								toimitusblip = AddBlipForCoord(deliverypoint.coords)
								SetBlipSprite (toimitusblip, 483)
								SetBlipColour (toimitusblip, 76)
								SetBlipAsShortRange(toimitusblip, true)
								BeginTextCommandSetBlipName('STRING')
								AddTextComponentSubstringPlayerName('Toimituspiste')
								EndTextCommandSetBlipName(toimitusblip)
								SetNewWaypoint(deliverypoint.coords)
							else
								ESX.ShowNotification('Lopetit tehtävän')
								RemoveBlip(toimitusblip)
								ESX.ShowNotification('Ai ei työt kelpaa, tuuppa 5 minuutin päästä uudelleen')
								cooldown = true
								CreateThread(function()
									Wait(1000*60*5)
									cooldown = false
								end)
							end
							driving = not driving
						else
							ESX.ShowNotification('Ei sulle oo täällä töitä kerta ne ei kelpaa')
						end
					end
				end
			end
		end
		if driving then
			if #(coords-deliverypoint.coords) < 30 then
				if not delivered then
					local x, y, z = table.unpack(deliverypoint.coords)
					DrawMarker(4, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 233, 3, 3, 100, false, true, 2, false, false, false, false)
					wait = 0
					if #(coords-deliverypoint.coords) < 3 then
						ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ toimittaaksesi paketti')
						if IsControlJustPressed(0,38) then
							if IsPedInAnyVehicle(PlayerPedId(), false) then
								if GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) == GetHashKey("buffalo3") then
									ESX.ShowNotification('Toimitit paketin - palaa aloituspaikkaan')
									delivered = true
									RemoveBlip(toimitusblip)
									SetNewWaypoint(hakupaikka)
								else
									ESX.ShowNotification('Paketit toimitetaan firman autolla!')
								end
							else
								if GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), true)) == GetHashKey("buffalo3") then
									ESX.ShowNotification('Toimitit paketin - palaa aloituspaikkaan')
									delivered = true
									RemoveBlip(toimitusblip)
									SetNewWaypoint(hakupaikka)
								else
									ESX.ShowNotification('Paketit toimitetaan firman autolla!')
								end
							end
						end
					end
				end
			end
			if not delivered and wait ~= 0 then
				deliverydistance = deliverydistance - 30
				if GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) == GetHashKey("buffalo3") then
					local tuuri = math.random(0,1000)
					if tuuri == 1 then
						if IsVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), 0, true) then
							SetVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), 1, true, 1000)
						else
							SetVehicleTyreBurst(GetVehiclePedIsIn(PlayerPedId(), false), 0, true, 1000)
						end
					end
				end
			end
		end
		Wait(wait)
	end
end)