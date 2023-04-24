
MingameBase = 5 -- 10 for decimal or 16 for hexadecimal
MinigameTimeLimit = 250 -- time limit in seconds
MingameAttemptLimit = 10 -- number of guesses allowed



-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local MiniGame ={}
local HackStatus = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local px,py,pz = GetCharCoordinates(GetPlayerChar(-1)) -- the the current position of player in the game
		local atmmodel = GetHashKey("gb_cashmachine01")
		local atmmodel2 = GetHashKey("gb_cashmachine01_hi")
		local atmmodel3 = GetHashKey("gb_cashmachine02")
		local atmmodel4 = GetHashKey("gb_cashmachine_hi")

		if(DoesObjectOfTypeExistAtCoords(px, py, pz, 2.0, atmmodel)
		 or DoesObjectOfTypeExistAtCoords(px, py, pz, 2.0, atmmodel2)
		 or DoesObjectOfTypeExistAtCoords(px, py, pz, 2.0, atmmodel3) 
		 or DoesObjectOfTypeExistAtCoords(px, py, pz, 2.0, atmmodel4)) then -- If any of the above atm objects are near player then  

			if(IsGameKeyboardKeyJustPressed(18)) then -- if player presses E key then
				MiniGame.Open() -- triggers the MiniGame.Open function to start the hack
				--hack started
			end
		end
	end
end)

MiniGame.Open = function() -- function which gives message to javascript for starting the hack
	SendNUIMessage({
		action = "open",
		base = MingameBase, 
		timeLimit = MinigameTimeLimit,
		attemptLimit = MingameAttemptLimit 
	})
	SetNuiFocus(true, true)-- setting mouse on
end

RegisterNUICallback('close', function(data, cb) -- got callback from javascript that hacking is completed

	SetPlayerControl(GetPlayerId(), true)-- freezing playermovement player
	cb('ok')
	HackStatus = data
	Citizen.Wait(500)
	ClearCharTasksImmediately(GetPlayerChar(-1)) -- clearing player animations
	Citizen.Wait(500)

	if HackStatus then -- if hacking is sucess then 
		-- Hack Sucessful 
		-- adding money to the player , sync this event with your server
	else -- if hacking got failed then
		-- Hack Failed
		-- script here the things that should be happen when the hack is failed 
	end

	SetNuiFocus(false, false)-- setting mouse off
	
	ClearCharTasksImmediately(GetPlayerChar(-1))-- clearing player animations

end)