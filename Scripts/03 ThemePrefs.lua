-- sm-ssc Default Theme Preferences Handler

-- Example usage of new system (not really implemented yet)
local Prefs =
{
	AutoSetStyle =
	{
		Default = false,
		Choices = { "ON", "OFF" },
		Values = { true, false }
	},
}

ThemePrefs.InitAll(Prefs)

function InitUserPrefs()
	local Prefs = {
		UserPrefScoringMode = 'DDR SuperNOVA 2',
		UserPrefShowLotsaOptions = true,
		UserPrefComboOnRolls = false,
		UserPrefProtimingP1 = false,
		UserPrefProtimingP2 = false,
		FlashyCombos = false,
		UserPrefComboUnderField = true,
	}
	for k, v in pairs(Prefs) do
		-- kind of xxx
		local GetPref = type(v) == "boolean" and GetUserPrefB or GetUserPref
		if GetPref(k) == nil then
			SetUserPref(k, v)
		end
	end
end

function InitUserScorePrefs()
	if GetUserPref("UserPrefScoringMode") == nil then
		SetUserPref("UserPrefScoringMode", 'DDR Extreme');
	end;
end;

function GetProTiming(pn)
	local pname = ToEnumShortString(pn)
	if GetUserPrefB("ProTiming"..pname) then
		return GetUserPrefB("ProTiming"..pname)
	else
		SetUserPref("ProTiming"..pname,false)
		return false
	end
end

function GetDefaultOptionLines()
	local numpn = GAMESTATE:GetNumPlayersEnabled()
	local as = GetScreenAspectRatio()
	local LineSets = { -- none of these include characters yet.
		"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,Stats,Graph,19", -- All
		"1,2,3,4,5,6,7,8,9,10,11,12,13,15,17,18,Stats,Graph,19", -- Non Steps
		"1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,17,18,19", -- All
		"1,2,3,4,5,6,7,8,9,10,11,12,13,15,17,18,19", -- Non Steps
		"1,2,3,6,7,10,11,12,14,15", -- DDR Essentials ( no turns, fx )
		"1,2,3,6,7,10,11,12,15", -- DDR Essentials Non Steps ( no turns, fx )
	};
	local function IsExtra1()
		if GAMESTATE:IsExtraStage() and getenv("exflag") == "" then return true
		else return false
		end
	end
	local function IsExtra2()
		if GAMESTATE:IsExtraStage2() then return true
		else return false
		end
	end
	local function IsCSC()
		if GAMESTATE:IsExtraStage() and getenv("exflag") == "csc" then return true
		else return false
		end
	end
	
	local function CheckCharacters(mods)
		if CHARMAN:GetCharacterCount() > 0 then
			return mods .. ",16" --TODO: Better line name.
		end
		return mods
	end
	
	modLines = LineSets[2]
	
	if IsExtra1() then
		if GetUserPrefB("UserPrefShowLotsaOptions") == true then
			if numpn == 2 then
				if as >= 1.6 then
					modLines = LineSets[1];
				else
					modLines = LineSets[3];
				end
			else modLines = LineSets[1];
			end
		else
			modLines = LineSets[5];
		end
	end
	if IsExtra2() or IsNetConnected() or IsCSC() then
		if GetUserPrefB("UserPrefShowLotsaOptions") == true then
			if numpn == 2 then
				if as >= 1.6 then
					modLines = LineSets[2];
				else
					modLines = LineSets[4];
				end
			else modLines = LineSets[2];
			end
		else
			modLines = LineSets[6];
		end
	end
	if not IsExtra1() and not IsExtra2() and not IsNetConnected() and not IsCSC() then
		if GetUserPrefB("UserPrefShowLotsaOptions") == true then
			if numpn == 2 then
				if as >= 1.6 then
					modLines = LineSets[1];
				else
					modLines = LineSets[3];
				end
			else modLines = LineSets[1];
			end
		else
			modLines = LineSets[5];
		end
	end
	
	return CheckCharacters(modLines)
end

function GetDefaultOptionRestrictedLines()
	local numpn = GAMESTATE:GetNumPlayersEnabled()
	local as = GetScreenAspectRatio()
	local LineSets = { -- none of these include characters yet.
		"1,8,10,12,14,15,17,18,Stats,Graph", -- All
		"1,8,10,12,14,15,17,18", -- Non Steps
	};

	local function CheckCharacters(mods)
		if CHARMAN:GetCharacterCount() > 0 then
			return mods .. ",16" --TODO: Better line name.
		end
		return mods
	end
	
	modLines = LineSets[2]

	if numpn == 2 then
		if as >= 1.6 then
			modLines = LineSets[1];
		else
			modLines = LineSets[2];
		end
	else modLines = LineSets[1];
	end

	return CheckCharacters(modLines)
end

function GetDefaultOptionRaveLines()
	local LineSets = { -- none of these include characters yet.
		"1,8,12,14,15,17,18", -- All
	};

	local function CheckCharacters(mods)
		if CHARMAN:GetCharacterCount() > 0 then
			return mods .. ",16" --TODO: Better line name.
		end
		return mods
	end

	modLines = LineSets[1]
	return CheckCharacters(modLines)
end

--[ja] ネット接続時にScreenTestInput画面に進もうとすると操作できなくなるので対策しています。
function GetOptionLines()
	if IsNetConnected() then
		if SelectFrameSet() ~= "" then
			return "1,2,3,4,6,7,8,9,10,11,12,FS,13,14"
		else
			return "1,2,3,4,6,7,8,9,10,11,12,13,14"
		end
	else
		if SelectFrameSet() ~= "" then
			return "1,2,3,4,5,6,7,8,9,10,11,12,FS,13,14"
		else
			return "1,2,3,4,5,6,7,8,9,10,11,12,13,14"
		end
	end
end

--option rows 
function OptionRowProTiming()
	local t = {
		Name = "ProTiming",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = false,
		ExportOnChange = false,
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn)) then
				local bShow = GetUserPrefB("UserPrefProtiming" .. ToEnumShortString(pn))
				if bShow then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefProtiming", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local bSave = list[2] and true or false
			SetUserPref("UserPrefProtiming" .. ToEnumShortString(pn), bSave)
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefShowLotsaOptions()
	local t = {
		Name = "UserPrefShowLotsaOptions",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Many','Few' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefShowLotsaOptions") ~= nil then
				if GetUserPrefB("UserPrefShowLotsaOptions") then
					list[1] = true
				else
					list[2] = true
				end
			else
				WritePrefToFile("UserPrefShowLotsaOptions", false)
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[1] and true or false
			WritePrefToFile("UserPrefShowLotsaOptions", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t);
	return t
end

function UserPrefComboOnRolls()
	local t = {
		Name = "UserPrefComboOnRolls",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefComboOnRolls") ~= nil then
				if GetUserPrefB("UserPrefComboOnRolls") then
					list[2] = true;
				else
					list[1] = true;
				end;
			else
				WritePrefToFile("UserPrefComboOnRolls",false);
				list[1] = true;
			end;
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefComboOnRolls", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefFlashyCombo()
	local t = {
		Name = "UserPrefFlashyCombo",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefFlashyCombo") ~= nil then
				if GetUserPrefB("UserPrefFlashyCombo") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefFlashyCombo", false)
				list[1] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefFlashyCombo", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t
end

function UserPrefComboUnderField()
	local t = {
		Name = "UserPrefComboUnderField",
		LayoutType = "ShowAllInRow",
		SelectType = "SelectOne",
		OneChoiceForAllPlayers = true,
		ExportOnChange = false,
		Choices = { 'Off','On' },
		LoadSelections = function(self, list, pn)
			if ReadPrefFromFile("UserPrefComboUnderField") ~= nil then
				if GetUserPrefB("UserPrefComboUnderField") then
					list[2] = true
				else
					list[1] = true
				end
			else
				WritePrefToFile("UserPrefComboUnderField", true)
				list[2] = true
			end
		end,
		SaveSelections = function(self, list, pn)
			local val = list[2] and true or false
			WritePrefToFile("UserPrefComboUnderField", val)
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" })
			THEME:ReloadMetrics()
		end
	}
	setmetatable(t, t)
	return t;
end

function GamePrefDefaultFail2()
	local t = {
		Name = "GamePrefDefaultFail2";
		LayoutType = "ShowAllInRow";
		SelectType = "SelectOne";
		OneChoiceForAllPlayers = true;
		ExportOnChange = false;
		Choices = { "Immediate","ImmediateContinue", "AtEnd", "Off" };
		LoadSelections = function(self, list, pn)
			if ReadGamePrefFromFile("DefaultFail") ~= nil then
				if GetGamePref("DefaultFail") then
					if GetGamePref("DefaultFail") == "Immediate" then
						list[1] = true;
					elseif GetGamePref("DefaultFail") == "ImmediateContinue" then
						list[2] = true;
					elseif GetGamePref("DefaultFail") == "AtEnd" then
						list[3] = true;
					elseif GetGamePref("DefaultFail") == "Off" then
						list[4] = true;
					else
						list[1] = true;
					end
					-- list[table.find( list, GetGamePref("DefaultFail") )] = true;
				else
					list[1] = true;
				end;
			else
				WriteGamePrefToFile("DefaultFail","Immediate");
				list[1] = true;
			end;
		end;
		SaveSelections = function(self, list, pn)
			-- This is so stupid.
			local tChoices = { "Immediate","ImmediateContinue", "AtEnd", "Off" };
			local val;
			if list[1] then
				val = tChoices[1];
			elseif list[2] then
				val = tChoices[2];
			elseif list[3] then
				val = tChoices[3];
			elseif list[4] then
				val = tChoices[4];
			else
				val = tChoices[1];
			end
			WriteGamePrefToFile("DefaultFail",val);
			MESSAGEMAN:Broadcast("PreferenceSet", { Message == "Set Preference" } );
			THEME:ReloadMetrics();
		end;
	};
	setmetatable( t, t );
	return t;
end
