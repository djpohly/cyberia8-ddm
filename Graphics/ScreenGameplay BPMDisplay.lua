local numPlayers = GAMESTATE:GetNumPlayersEnabled()

local function UpdateSingleBPM(self)
	local bpmDisplay = self:GetChild("BPMDisplay");
	local pn = GAMESTATE:GetMasterPlayerNumber();
	local pState = GAMESTATE:GetPlayerState(pn);
	local songPosition = pState:GetSongPosition();
	local bpm = songPosition:GetCurBPS() * 60;
	local stop = songPosition:GetFreeze();
	local cbpm = string.format("%01.0f",bpm);
	if stop then cbpm = 0;
	end;
	bpmDisplay:settext( cbpm );
	--[ja] ScreenGameplay decorations/mclifeにBPMの値を渡します
	-------------------------------------
	setenv("playercurrentbpm",( cbpm ) );
end

local displaySingle = Def.ActorFrame{
	-- manual bpm displays
	LoadFont("","BPMDisplay")..{
		Name="BPMDisplay";
		Condition=not GAMESTATE:IsDemonstration();
		InitCommand=cmd(x,-126;maxwidth,60;diffuse,color("1,1,0,1"););
		OnCommand=cmd(addx,20;diffusealpha,0;sleep,0.9;linear,0.2;addx,-20;diffusealpha,1;);
	};
};

displaySingle.InitCommand=cmd(SetUpdateFunction,UpdateSingleBPM);

if numPlayers == 1 then
	return displaySingle
elseif numPlayers == 2 and (not GAMESTATE:IsHumanPlayer(PLAYER_1) or 
not GAMESTATE:IsHumanPlayer(PLAYER_2)) then
	return displaySingle
else
	local function Update2PBPM(self)
		local dispP1 = self:GetChild("DisplayP1");
		local dispP2 = self:GetChild("DisplayP2");

		-- needs current bpm for p1 and p2
		for pn in ivalues(PlayerNumber) do
			local bpmDisplay;
			if pn == PLAYER_1 then bpmDisplay = dispP1;
			else bpmDisplay = dispP2;
			end;
			local pState = GAMESTATE:GetPlayerState(pn);
			local songPosition = pState:GetSongPosition();
			local bpm = songPosition:GetCurBPS() * 60;
			local stop = songPosition:GetFreeze();
			local cbpm = string.format("%01.0f",bpm);
			if stop then cbpm = 0;
			end;
			bpmDisplay:settext( cbpm );

			if (pn == PLAYER_1) then setenv("playercurrentbpmp1",( cbpm ) );
			else setenv("playercurrentbpmp2",( cbpm ) );
			end;
		end
	end

	local displayTwoPlayers = Def.ActorFrame{
		-- manual bpm displays
		LoadFont("","BPMDisplay")..{
			Name="DisplayP1";
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_1) and not GAMESTATE:IsDemonstration();
			InitCommand=cmd(x,-126;maxwidth,60;diffuse,PlayerColor(PLAYER_1););
			OnCommand=cmd(addx,20;diffusealpha,0;sleep,0.9;linear,0.2;addx,-20;diffusealpha,1;);
		};
		LoadFont("","BPMDisplay")..{
			Name="DisplayP2";
			Condition=GAMESTATE:IsHumanPlayer(PLAYER_2) and not GAMESTATE:IsDemonstration();
			InitCommand=cmd(x,126+1;maxwidth,60;diffuse,PlayerColor(PLAYER_2););
			OnCommand=cmd(addx,-20;diffusealpha,0;sleep,0.9;linear,0.2;addx,20;diffusealpha,1;);
		};
	};

	displayTwoPlayers.InitCommand=cmd(SetUpdateFunction,Update2PBPM);
	return displayTwoPlayers
end

-- should not get here
-- return Def.ActorFrame{}