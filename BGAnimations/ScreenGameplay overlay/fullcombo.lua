
local pn = ...
assert(pn);

local t = Def.ActorFrame{};

local gpTier = {
	Tier01		= THEME:GetMetric("PlayerStageStats", "GradePercentTier01"),
	Tier02		= THEME:GetMetric("PlayerStageStats", "GradePercentTier02"),
	Tier03		= THEME:GetMetric("PlayerStageStats", "GradePercentTier03"),
	Tier04		= THEME:GetMetric("PlayerStageStats", "GradePercentTier04"),
	Tier05		= THEME:GetMetric("PlayerStageStats", "GradePercentTier05"),
	Tier06		= THEME:GetMetric("PlayerStageStats", "GradePercentTier06"),
	Tier07		= THEME:GetMetric("PlayerStageStats", "GradePercentTier07"),
};
local playername = GAMESTATE:GetPlayerDisplayName(pn);
local ssStats = STATSMAN:GetCurStageStats();
local pnstats = ssStats:GetPlayerStageStats(pn);

setenv("fullcjudgep1",( 0 ) );
setenv("fullcjudgep2",( 0 ) );

setenv("evacountupflag",1);
setenv("evacheckflag",1);

local IsUsingSoloSingles = PREFSMAN:GetPreference('Center1Player');
local NumPlayers = GAMESTATE:GetNumPlayersEnabled();
local NumSides = GAMESTATE:GetNumSidesJoined();

local start = GAMESTATE:GetCurrentSong():GetFirstSecond();
local stepseconds = GAMESTATE:GetCurrentSong():GetLastSecond();

local function GetPosition(pn)
	if IsUsingSoloSingles and NumPlayers == 1 and NumSides == 1 then return SCREEN_CENTER_X; end;

	local strPlayer = (NumPlayers == 1) and "OnePlayer" or "TwoPlayers";
	local strSide = (NumSides == 1) and "OneSide" or "TwoSides";
	
	return THEME:GetMetric("ScreenGameplay","Player".. pname(pn) .. strPlayer .. strSide .."X");
end;

local function GetFullComboEffectSizeX(pn)
	local r=0;
	local one = THEME:GetMetric("ArrowEffects","ArrowSpacing");
	local stt = GAMESTATE:GetCurrentSteps(pn):GetStepsType();

	if stt=='StepsType_Dance_Single' then
		r=one*4;
	elseif stt=='StepsType_Dance_Double' then
		r=one*8;
	elseif stt=='StepsType_Dance_Couple' then
		r=one*4;
	elseif stt=='StepsType_Dance_Solo' then
		r=one*6;
	elseif stt=='StepsType_Dance_Threepanel' then
		r=one*3;
	else
		r=SCREEN_WIDTH;
	end;
	return r;
end;

local function FullComboColor(pn)
	local fcacolor = "0,0,0";
	if pnstats:FullComboOfScore('TapNoteScore_W1') == true then
		fcacolor = "1,1,1";
	elseif pnstats:FullComboOfScore('TapNoteScore_W2') == true then
		fcacolor = "1,0.8,0.2";
	elseif pnstats:FullComboOfScore('TapNoteScore_W3') == true then
		fcacolor = "0,1,0.2";		
	else
		fcacolor = "0,0,0";
	end;
	return fcacolor;
end;


t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:diffusealpha(0);
		self:x( GetPosition(pn) );
	end;
	OffCommand=cmd(sleep,0.5;playcommand,"Set";);
	SetCommand=function(self)
		local aliveseconds = 0;
		if GAMESTATE:IsCourseMode() then
			aliveseconds = stepseconds + 1;
		else
			aliveseconds = GAMESTATE:GetSongPosition():GetMusicSeconds();
		end;
		setenv("aseconds",aliveseconds);
		self:visible(false);
		local ssStats = STATSMAN:GetCurStageStats();
		local pnstats = ssStats:GetPlayerStageStats(pn);
		local hsp1fullcombo = 0;
		local hsp2fullcombo = 0;

		-- [ja] 今回のスコア
		local Grade						= pnstats:GetGrade();
		local PercentScore				= pnstats:GetPercentDancePoints();
		local TapNoteScore_W1			= pnstats:GetTapNoteScores('TapNoteScore_W1');
		local TapNoteScore_W2			= pnstats:GetTapNoteScores('TapNoteScore_W2');
		local TapNoteScore_W3			= pnstats:GetTapNoteScores('TapNoteScore_W3');
		local TapNoteScore_W4			= pnstats:GetTapNoteScores('TapNoteScore_W4');
		local TapNoteScore_W5			= pnstats:GetTapNoteScores('TapNoteScore_W5');
		local TapNoteScore_Miss			= pnstats:GetTapNoteScores('TapNoteScore_Miss');
		local HoldNoteScore_Held			= pnstats:GetHoldNoteScores('HoldNoteScore_Held');
		local HoldNoteScore_LetGo			= pnstats:GetHoldNoteScores('HoldNoteScore_LetGo');
		local TapNoteScore_HitMine			= pnstats:GetTapNoteScores('TapNoteScore_HitMine');
		local TapNoteScore_CheckpointMiss	= pnstats:GetTapNoteScores('TapNoteScore_CheckpointMiss');
		local MaxCombo					= pnstats:MaxCombo();
		if not GAMESTATE:IsEventMode() then
			if getenv("exflag") == "csc" and not GAMESTATE:IsExtraStage2() then
				local ccstpoint = getenv("ccstpoint");	--[ja] 今までの総合ポイント
				local oldpoint = 0;				--[ja] 今までのポイント
				local newpoint = 0;				--[ja] 今回のポイント
				
				local diffpoint = 0;
				local combopoint = 0;
				local gradepoint = 0;
				if not pnstats:GetFailed() then
					if aliveseconds >= stepseconds then
						if Grade ~= "Grade_None" then
							if PercentScore >= gpTier["Tier07"] then
								if PercentScore >= gpTier["Tier01"] then Grade = "Grade_Tier01";
								elseif PercentScore >= gpTier["Tier02"] then Grade = "Grade_Tier02";
								elseif PercentScore >= gpTier["Tier03"] then Grade = "Grade_Tier03";
								elseif PercentScore >= gpTier["Tier04"] then Grade = "Grade_Tier04";
								elseif PercentScore >= gpTier["Tier05"] then Grade = "Grade_Tier05";
								elseif PercentScore >= gpTier["Tier06"] then Grade = "Grade_Tier06";
								else Grade = "Grade_Tier07";
								end;
							end;
						end;

						if Grade == "Grade_Tier01" then gradepoint = 3;
						elseif Grade == "Grade_Tier02" then gradepoint = 2;
						elseif Grade == "Grade_Tier03" then gradepoint = 1;
						end;
						local StepsOrTrail;
						if GAMESTATE:IsCourseMode() then
							StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
						else
							StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
						end;
						if StepsOrTrail:GetDifficulty() == 'Difficulty_Beginner' then diffpoint = 2;
						elseif StepsOrTrail:GetDifficulty() == 'Difficulty_Easy' then diffpoint = 2;
						elseif StepsOrTrail:GetDifficulty() == 'Difficulty_Medium' then diffpoint = 3;
						elseif StepsOrTrail:GetDifficulty() == 'Difficulty_Hard' then diffpoint = 4;
						elseif StepsOrTrail:GetDifficulty() == 'Difficulty_Challenge' then diffpoint = 4;
						end;

						--hscombo
						if Grade ~= "Grade_Failed" then
							if TapNoteScore_W4 + TapNoteScore_W5 + TapNoteScore_Miss +
							TapNoteScore_HitMine + TapNoteScore_CheckpointMiss == 0 then
								if TapNoteScore_W1 + TapNoteScore_W2 + TapNoteScore_W3 > 0 then
									if TapNoteScore_W2 + TapNoteScore_W3 == 0 and PercentScore == 1 then
										if pn == PLAYER_1 then hsp1fullcombo = 1;
										else hsp2fullcombo = 1;
										end;
									elseif TapNoteScore_W3 == 0 then
										if pn == PLAYER_1 then hsp1fullcombo = 2;
										else hsp2fullcombo = 2;
										end;
									else
										if pn == PLAYER_1 then hsp1fullcombo = 3;
										else hsp2fullcombo = 3;
										end;
									end;
								end;
							end;
						end;
						if hsp1fullcombo == 1 or hsp2fullcombo == 1 then combopoint = 3;
						elseif hsp1fullcombo == 2 or hsp2fullcombo == 2 then combopoint = 2;
						elseif hsp1fullcombo == 3 or hsp2fullcombo == 3 then combopoint = 1;
						end;

						newpoint = gradepoint + diffpoint + combopoint;
						if newpoint >= 10 then
							newpoint = 10;
						end;
					else
						newpoint = 0;
						Grade = "Grade_Failed"
					end;
				else
					newpoint = 0;
					Grade = "Grade_Failed"
				end;
				setenv("newpoint",newpoint);
				
				local cscgroup = "";
				if ssStats then
					cscgroup = ssStats:GetPlayedSongs()[1]:GetGroupName();
				end;
				local txt_folders = GetGroupParameter(cscgroup,"Extra1List");
				local chk_folders = split(":",txt_folders);
				local songst = getenv("songst");
				local cs_path = "/CSDataSave/"..playername.."_Save/0000_co "..cscgroup.."";
				local stpoint = (#chk_folders * 7) + 1;
				function GetCSCCount()
					local pointtext = {};
					local sys_songc = split(":",GetCSCParameter(cscgroup,"Status",playername));
					local sys_spoint;
					for k=1, #chk_folders do
						if File.Read( cs_path ) then
							if chk_folders[k] == songst then
								sys_spoint = split(",",sys_songc[k]);
								if #sys_spoint >= 2 then
									oldpoint = tonumber(sys_spoint[2]);
									if tonumber(sys_spoint[2]) < newpoint then
										sys_spoint[2] = newpoint;
									else
										sys_spoint[2] = sys_spoint[2];
									end;
								end;
								pointtext[#pointtext+1] = { ""..songst..","..sys_spoint[2]..":" };
							else
								pointtext[#pointtext+1] = { sys_songc[k]..":" };
							end;
						else
							if chk_folders[k] == songst then
								pointtext[#pointtext+1] = { ""..songst..","..newpoint..":" };
							else
								pointtext[#pointtext+1] = { ""..chk_folders[k]..",0:" };
							end;
						end;
					end;
				
					return pointtext;
				end;

				local CSCList = GetCSCCount();
				local csctext = "#Status:";

				for i=1, #chk_folders do
					if CSCList[i] then
						csctext = csctext..""..table.concat(CSCList[i]);
					else
						csctext = csctext;
					end;
				end;
				csctext = string.sub(csctext,1,-2);
				csctext = csctext..";\r\n";
				File.Write( cs_path , csctext );
				setenv("oldpoint",oldpoint);
				if ccstpoint + (newpoint - oldpoint) >= stpoint then
					setenv("omsflag",1);
				else
					setenv("omsflag",0);
				end;
			else
				if getenv("cStage") == "Stage_Final" then
					if getenv("envAllowExtraStage") == true then
						if ssStats then
							if not pnstats:GetFailed() then
								if aliveseconds >= stepseconds then
									if PercentScore >= gpTier["Tier03"] then
										PREFSMAN:SetPreference("AllowExtraStage",true);
									else
										PREFSMAN:SetPreference("AllowExtraStage",false);
									end;
								end;
							end;
						end;
					end;
				end;
			end;
		end;

		if GAMESTATE:PlayerIsUsingModifier(pn,"no little") == true and GAMESTATE:PlayerIsUsingModifier(pn,"no nofakes") == true and 
		GAMESTATE:PlayerIsUsingModifier(pn,"no nohands") == true and GAMESTATE:PlayerIsUsingModifier(pn,"no noholds") == true and 
		GAMESTATE:PlayerIsUsingModifier(pn,"no nojumps") == true and GAMESTATE:PlayerIsUsingModifier(pn,"no nolifts") == true and 
		GAMESTATE:PlayerIsUsingModifier(pn,"no nomines") == true and GAMESTATE:PlayerIsUsingModifier(pn,"no noquads") == true and 
		GAMESTATE:PlayerIsUsingModifier(pn,"no norolls") == true and GAMESTATE:PlayerIsUsingModifier(pn,"no nostretch") == true and 
		GAMESTATE:PlayerIsUsingModifier(pn,"no autoplay") == true and GAMESTATE:PlayerIsUsingModifier(pn,"no assisttick") == true then
			if aliveseconds >= stepseconds then
				local w1full = pnstats:FullComboOfScore('TapNoteScore_W1');
				local w2full = pnstats:FullComboOfScore('TapNoteScore_W2');
				local w3full = pnstats:FullComboOfScore('TapNoteScore_W3');
				local radartap = GAMESTATE:GetCurrentSteps(pn):GetRadarValues(pn):GetValue('RadarCategory_TapsAndHolds');
				if not pnstats:GetFailed() then
					--[ja] ScreenEvaluation overlayにもこの状態を送ります
					if pn == PLAYER_1 then
						if radartap > 0 then
							if w1full == true or w2full == true or w3full == true then
								if TapNoteScore_W4 + TapNoteScore_W5 + TapNoteScore_Miss + 
								TapNoteScore_HitMine + TapNoteScore_CheckpointMiss + HoldNoteScore_LetGo == 0 then
									self:visible(true);
									setenv("fullcjudgep1",( 1 ) );
								end;
							end;
						end;
					else
						if radartap > 0 then
							if w1full == true or w2full == true or w3full == true then
								if TapNoteScore_W4 + TapNoteScore_W5 + TapNoteScore_Miss + 
								TapNoteScore_HitMine + TapNoteScore_CheckpointMiss + HoldNoteScore_LetGo == 0 then
									self:visible(true);
									setenv("fullcjudgep2",( 1 ) );
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;

	Def.Quad {
		InitCommand=cmd(shadowlength,0;draworder,102);
		BeginCommand=cmd(y,SCREEN_BOTTOM;vertalign,bottom;);
		OffCommand=function(self)
			self:visible(true);
			(cmd(zoomtowidth,0;zoomtoheight,0;diffuse,color(FullComboColor(pn)..",0.5");zoomtoheight,SCREEN_HEIGHT/9.5;
			accelerate,0.2;zoomtowidth,GetFullComboEffectSizeX(pn)*1.25;linear,0.25;zoomtoheight,SCREEN_HEIGHT;linear,0.25;diffusealpha,0;))(self);
		end;
	};
	
	Def.Quad {
		InitCommand=cmd(shadowlength,0;draworder,103);
		BeginCommand=cmd(y,SCREEN_BOTTOM;vertalign,bottom;blend,'BlendMode_Add');
		OffCommand=function(self)
			(cmd(zoomtowidth,0;zoomtoheight,0;diffuse,color(FullComboColor(pn)..",0.35");zoomtoheight,SCREEN_HEIGHT/8;
			accelerate,0.3;zoomtowidth,GetFullComboEffectSizeX(pn)*1.25;linear,0.7;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0;))(self);
		end;
	};
	
	Def.Quad {
		InitCommand=cmd(shadowlength,0;draworder,104);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;);
		OffCommand=function(self)
			(cmd(diffusealpha,0;sleep,0.9;diffuse,color(FullComboColor(pn)..",0.35");zoomtowidth,GetFullComboEffectSizeX(pn)*0.5;
			zoomtoheight,SCREEN_HEIGHT;accelerate,0.25;zoomtowidth,GetFullComboEffectSizeX(pn)*0.2;addx,-100;diffusealpha,0;))(self);
		end;
	};
	
	Def.Quad {
		InitCommand=cmd(shadowlength,0;draworder,105);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;);
		OffCommand=function(self)
			(cmd(diffusealpha,0;sleep,0.9;diffuse,color(FullComboColor(pn)..",0.35");zoomtowidth,GetFullComboEffectSizeX(pn)*0.5;
			zoomtoheight,SCREEN_HEIGHT;accelerate,0.25;zoomtowidth,GetFullComboEffectSizeX(pn)*0.2;addx,100;diffusealpha,0;))(self);
		end;
	};

	Def.Quad {
		InitCommand=cmd(shadowlength,0;draworder,106);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;);
		OffCommand=function(self)
			(cmd(zoomtowidth,0;zoomtoheight,SCREEN_HEIGHT;diffuse,color(FullComboColor(pn)..",0.5");
			sleep,0.5;diffusealpha,1;linear,0.5;zoomtowidth,SCREEN_WIDTH/2;diffusealpha,0;))(self);
		end;
	};
	
	Def.Quad {
		InitCommand=cmd(shadowlength,0;draworder,107);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;blend,'BlendMode_Add');
		OffCommand=function(self)
			(cmd(diffusealpha,1;zoomtowidth,0;zoomtoheight,0;accelerate,0.25;zoomtoheight,SCREEN_HEIGHT;
			diffuse,color(FullComboColor(pn)..",0.4");accelerate,0.75;zoomtowidth,SCREEN_WIDTH/2.25;diffusealpha,0;))(self);
		end;
	};
	
	LoadActor(THEME:GetPathB("","graph"))..{
		InitCommand=cmd(shadowlength,4;draworder,108);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;);
		OffCommand=function(self)
			(cmd(addx,40;addy,20;zoom,0;linear,0.5;diffusealpha,0.7;glow,color(FullComboColor(pn)..",0.6");zoom,0.75;rotationx,70;
			rotationy,-30;rotationz,100;linear,0.5;glow,color(FullComboColor(pn)..",0");diffusealpha,0.7;rotationz,400;zoomx,5;diffusealpha,0;))(self);
		end;
	};
	
	LoadActor(THEME:GetPathB("","graph"))..{
		InitCommand=cmd(shadowlength,4;draworder,109);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;);
		OffCommand=function(self)
			(cmd(addx,40;addy,20;zoom,0;linear,0.5;diffusealpha,0.7;glow,color(FullComboColor(pn)..",1");zoom,0.75;rotationx,70;rotationy,30;rotationz,100;
			linear,0.5;rotationx,-100;rotationy,60;rotationz,200;glow,color(FullComboColor(pn)..",0");linear,0.05;zoomx,5;diffusealpha,0;))(self);
		end;
	};

	LoadActor(THEME:GetPathG("","combo01"))..{
		InitCommand=cmd(shadowlength,0;draworder,110);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;blend,'BlendMode_Add');
		OffCommand=function(self)
			(cmd(glow,color(FullComboColor(pn)..",0.75");accelerate,0.25;diffusealpha,0.7;zoom,0;
			accelerate,1;glow,color(FullComboColor(pn)..",0");zoom,2;diffusealpha,0;))(self);
		end;
	};

	LoadActor(THEME:GetPathG("","combo01"))..{
		InitCommand=cmd(shadowlength,4;draworder,111);
		BeginCommand=cmd(y,SCREEN_CENTER_Y;);
		OffCommand=function(self)
			(cmd(accelerate,0.25;diffusealpha,0.7;glow,color(FullComboColor(pn)..",0.75");zoom,1.5;decelerate,0.75;
			glow,color(FullComboColor(pn)..",0");diffuse,color(FullComboColor(pn)..",1");zoom,1;sleep,0.5;linear,0.1;zoomx,0.5;diffusealpha,0;))(self);
		end;
	};
};
--[[

	t[#t+1] = LoadFont("Common normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-10;horizalign,right;zoom,0.45;);
		OffCommand=function(self)
			self:settext("alive : "..getenv("aseconds"));
		end;	
	};

	t[#t+1] = LoadFont("Common normal")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10;horizalign,right;zoom,0.45;);
		OffCommand=function(self)
			self:settext("step : "..stepseconds);
		end;	
	};
]]

return t;