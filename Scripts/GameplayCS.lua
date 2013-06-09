-- sm-ssc fallback theme | script ring 03 | Gameplay.lua
-- [en] This file is used to store settings that should be different in each
-- game mode.

-- shakesoda calls this pump.lua
local function CurGameName()
	return GAMESTATE:GetCurrentGame():GetName()
end

-- Check the active game mode against a string. Cut down typing this in metrics.
function IsGame(str) return CurGameName() == str end

-- GetExtraColorThreshold()
-- [en] returns the difficulty threshold in meter
-- for songs that should be counted as boss songs.
function GetExtraColorThreshold()
	local Modes = {
		dance = 999999,
		pump = 999999,
		beat = 999999,
		kb7 = 999999,
		para = 999999,
		techno = 999999,
		lights = 999999, -- lights shouldn't be playable
	}
	return Modes[CurGameName()]
end

-- GameCompatibleModes:
-- [en] returns possible modes for ScreenSelectPlayMode
function GameCompatibleModes()
	sGame = CurGameName()
	local Modes = {
		dance = "Single,Double,Solo,Versus,Couple",
		pump = "Single,Double,HalfDouble,Versus,Couple",
		beat = "5Keys,7Keys,10Keys,14Keys",
		kb7 = "KB7",
		para = "Single",
		techno = "Single4,Single5,Single8,Double4,Double8",
		lights = "Single" -- lights shouldn't be playable
	}
	return Modes[sGame]
end

function SelectProfileKeys()
	sGame = CurGameName()	
	if sGame == "pump" then
		return "Up,Down,Start,Back,Center,DownLeft,DownRight"
	elseif sGame == "dance" then
		return "Up,Down,Start,Back,Up2,Down2"
	else
		return "Up,Down,Start,Back"
	end
end

function ComboUnderField()
	return GetUserPrefB("UserPrefComboUnderField")
end

function JudgmentTransformCommand( self, params )
	local x = 0
	local y = -30
	if params.bReverse then y = 20 end
	-- This makes no sense and wasn't even being used due to misspelling.
	-- if bCentered then y = y * 2 end
	self:x( x )
	self:y( y )
end

function JudgmentTransformSharedCommand( self, params )
	local x = -120
	local y = -30
	if params.bReverse then y = 20 end
	if params.Player == PLAYER_1 then x = 120 end
	self:x( x )
	self:y( y )
end

function ComboTransformCommand( self, params )
	local x = 0
	local y = 30
	if params.bReverse then y = -50 end

	if params.bCentered then
		if params.bReverse then
			y = y - 30
		else
			y = y + 40
		end
	end
	self:x( x )
	self:y( y )
end

function ScoreMissedHoldsAndRolls()
	if not IsGame("pump") and (not (IsGame("dance") and GetAdhocPref("HoldArrowJudge") == "1Point")) then
		return true
	else
		return false
	end
end

function PlayerP1OnePlayerSoloPlay()
	local IsUsingCenterPlay = PREFSMAN:GetPreference('Center1Player');
	local stylemode = GAMESTATE:GetCurrentStyle(PLAYER_1):GetStepsType()
	if not IsUsingCenterPlay and stylemode == 'StepsType_Dance_Solo' then
		return SCREEN_CENTER_X;
	elseif IsUsingCenterPlay and stylemode == 'StepsType_Dance_Solo' then
		return SCREEN_CENTER_X;
	else
		return math.floor(scale((0.75/3),0,1,SCREEN_LEFT,SCREEN_RIGHT));
	end
end

function PlayerP2OnePlayerSoloPlay()
	local IsUsingCenterPlay = PREFSMAN:GetPreference('Center1Player');
	local stylemode = GAMESTATE:GetCurrentStyle(PLAYER_2):GetStepsType()
	if not IsUsingCenterPlay and stylemode == 'StepsType_Dance_Solo' then
		return SCREEN_CENTER_X;
	elseif IsUsingCenterPlay and stylemode == 'StepsType_Dance_Solo' then
		return SCREEN_CENTER_X;
	else
		return math.floor(scale((2.25/3),0,1,SCREEN_LEFT,SCREEN_RIGHT));
	end
end

function PlayerP1OnePlayerBattlePlay()
	local pm = GAMESTATE:GetPlayMode()
	if pm == 'PlayMode_Battle' or pm == 'PlayMode_Rave' then
		return math.floor(scale((0.75/3),0,1,SCREEN_LEFT,SCREEN_RIGHT));
	else
		return SCREEN_CENTER_X;
	end
end

function PlayerP2OnePlayerBattlePlay()
	local pm = GAMESTATE:GetPlayMode()
	if pm == 'PlayMode_Battle' or pm == 'PlayMode_Rave' then
		return math.floor(scale((2.25/3),0,1,SCREEN_LEFT,SCREEN_RIGHT));
	else
		return SCREEN_CENTER_X;
	end
end

function GetScoreKeeper()
	local ScoreKeeper = "ScoreKeeperNormal"
	local game = GAMESTATE:GetCurrentGame():GetName()
	-- guitar has a separate scorekeeper
	if game == 'guitar' then
		ScoreKeeper = "ScoreKeeperGuitar"
	end

	-- two players and shared sides need the Shared ScoreKeeper.
	local styleType = GAMESTATE:GetCurrentStyle():GetStyleType()
	if styleType == 'StyleType_TwoPlayersSharedSides' then
		ScoreKeeper = "ScoreKeeperShared"
	end

	return ScoreKeeper
end

function StageSelection()
	if GAMESTATE:IsAnExtraStage() then
		local bExtra2 = GAMESTATE:GetCurrentStage() == 'Stage_Extra2'
		if bExtra2 then return true
		else return false
		end
	end
end

function OldStyleStringToDifficulty(diff)
	if diff == "beginner" then		return "Difficulty_Beginner"
	elseif diff == "easy" then		return "Difficulty_Easy"
	elseif diff == "basic" then		return "Difficulty_Easy"
	elseif diff == "light" then		return "Difficulty_Easy"
	elseif diff == "medium" then	return "Difficulty_Medium"
	elseif diff == "another" then	return "Difficulty_Medium"
	elseif diff == "trick" then		return "Difficulty_Medium"
	elseif diff == "standard" then	return "Difficulty_Medium"
	elseif diff == "difficult" then	return "Difficulty_Medium"
	elseif diff == "hard" then		return "Difficulty_Hard"
	elseif diff == "ssr" then		return "Difficulty_Hard"
	elseif diff == "maniac" then		return "Difficulty_Hard"
	elseif diff == "heavy" then		return "Difficulty_Hard"
	elseif diff == "smaniac" then	return "Difficulty_Challenge"
	elseif diff == "challenge" then	return "Difficulty_Challenge"
	elseif diff == "expert" then		return "Difficulty_Challenge"
	elseif diff == "oni" then		return "Difficulty_Challenge"
	elseif diff == "edit" then 		return "Difficulty_Edit"
	else 						return "Difficulty_Invalid"
	end
end

function GoToEX2()
	if getenv("exflag") == "csc" then
		local omsflag = getenv("omsflag");
		if omsflag == 1 then
			return true
		else return false
		end
	else
		local song = GAMESTATE:GetCurrentSong()
		local bExtra2 = GAMESTATE:IsExtraStage2()
		local bExtra = GAMESTATE:IsExtraStage()
		local style = GAMESTATE:GetCurrentStyle()
		local st = style:GetStepsType()
		local extrasong, extrasteps = SONGMAN:GetExtraStageInfo( bExtra2, style )
		local p1Steps = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty()
		local p2Steps = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty()
		local extracrs = OpenFile("/Songs/".. song:GetGroupName() .."/extra1.crs")
		if not extracrs then
			extracrs = OpenFile("/AdditionalSongs/".. song:GetGroupName() .."/extra1.crs")
		end
		if extracrs then
			local diffu = split(":",GetFileParameter(extracrs ,"song"))[2]
			local diff = string.lower(diffu);
			if bExtra and extrasong == song then
				if OldStyleStringToDifficulty(diff) == p1Steps or OldStyleStringToDifficulty(diff) == p2Steps then
					return true
				else return false
				end
			else return false
			end
			CloseFile(extracrs);
		else
			if bExtra and extrasong == song then
				if song:GetOneSteps(st,"Difficulty_Challenge") then
					if song:GetOneSteps(st,"Difficulty_Hard") then
						if song:GetOneSteps(st,"Difficulty_Challenge"):GetMeter() >= song:GetOneSteps(st,"Difficulty_Hard"):GetMeter() then
							if (p1Steps == "Difficulty_Challenge" or p1Steps == "Difficulty_Hard") then
								return true
							elseif (p2Steps == "Difficulty_Challenge" or p2Steps == "Difficulty_Hard") then
								return true
							else return false
							end
						else return false
						end
					elseif p1Steps == "Difficulty_Challenge" or p2Steps == "Difficulty_Challenge" then
						return true
					else return false
					end
				elseif p1Steps == "Difficulty_Hard" or p2Steps == "Difficulty_Hard" then
					return true
				else return false
				end
			else return false
			end
		end
	end
end