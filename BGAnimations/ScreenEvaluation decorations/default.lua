--eval
local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional( "StageDisplay", "StageDisplay" );
t[#t+1] = StandardDecorationFromFileOptional( "WinDisplay", "WinDisplay" );

-- life graph
local function GraphDisplay( pn )
	local t = Def.ActorFrame {
		Def.GraphDisplay {
			InitCommand=cmd(Load,"GraphDisplay"..ToEnumShortString(pn););
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
				local pm = GAMESTATE:GetPlayMode()
				if pm == 'PlayMode_Battle' or pm == "PlayMode_Rave" then
					if pn == PLAYER_1 then
						self:rotationz(180);
						self:rotationy(180);
					end;
				end;
			end;
		};
	};
	return t;
end

if ShowStandardDecoration("GraphDisplay") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable( "GraphDisplay" .. ToEnumShortString(pn), GraphDisplay(pn) );
	end
end

-- combo graph
local function ComboGraph( pn )
	local t = Def.ActorFrame {
		Def.ComboGraph {
			InitCommand=cmd(Load,"ComboGraph"..ToEnumShortString(pn););
			BeginCommand=function(self)
				local ss = SCREENMAN:GetTopScreen():GetStageStats();
				self:Set( ss, ss:GetPlayerStageStats(pn) );
				self:player( pn );
			end
		};
	};
	return t;
end

if ShowStandardDecoration("ComboGraph") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable( "ComboGraph" .. ToEnumShortString(pn), ComboGraph(pn) );
	end
end


local function PercentScoreText( pn )
	local t = LoadFont("ScreenEvaluation percent text")..{
		InitCommand=cmd(player,pn);
		BeginCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			(cmd(horizalign,right;vertalign,bottom;maxwidth,180))(self)
			local pss = STATSMAN:GetPlayedStageStats(1):GetPlayerStageStats(pn);
			if pss then
				local pct = pss:GetPercentDancePoints();
				local DPforOni = PREFSMAN:GetPreference('DancePointsForOni');
				local pm = GAMESTATE:GetPlayMode()
				if not DPforOni and pm == "PlayMode_Oni" then
					if pct == 1 then
						self:settext("100%");
					elseif pct == 0 then
						self:settext("0%");
					else self:settext(FormatPercentScore(pct));
					end;
					(cmd(addx,50;zoom,0;sleep,1.85;zoomx,1;accelerate,0.15;zoomy,1))(self)
				elseif pm == "PlayMode_Endless" then
					self:diffusealpha(0);
				elseif pm == "PlayMode_Rave" then
					self:diffusealpha(0);
				else
					if pct == 1 then
						self:settext("100%");
						self:addx(14);
					elseif pct == 0 then
						self:settext("0%");
						self:addx(14);
					else self:settext(FormatPercentScore(pct));
					end;
					(cmd(zoom,0;sleep,1.85;zoomx,1;accelerate,0.15;zoomy,1))(self)
				end;
			end;
		end;
	};
	return t;
end


if ShowStandardDecoration("PercentScore") then
	for pn in ivalues(PlayerNumber) do
		t[#t+1] = StandardDecorationFromTable( "PercentScore" .. ToEnumShortString(pn), PercentScoreText(pn) );
	end
end

for pn in ivalues(PlayerNumber) do
	local MetricsName = "MachineRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "MachineRecord"), pn ) .. {
		InitCommand=function(self) 
			self:player(pn); 
			self:name(MetricsName); 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
		end;
	};
end

for pn in ivalues(PlayerNumber) do
	local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn ) .. {
		InitCommand=function(self) 
			self:player(pn); 
			self:name(MetricsName); 
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen"); 
		end;
	};
end

t[#t+1] = StandardDecorationFromFileOptional("SongInformation","SongInformation");
t[#t+1] = StandardDecorationFromFileOptional("LifeDifficulty","LifeDifficulty");
t[#t+1] = StandardDecorationFromFileOptional("TimingDifficulty","TimingDifficulty");
t[#t+1] = StandardDecorationFromFileOptional( "TryExtraStage", "TryExtraStage" );

for pn in ivalues(PlayerNumber) do
	local st = GAMESTATE:GetCurrentStyle():GetStepsType();
	local SongOrCourse, StepsOrTrail;
	if GAMESTATE:IsCourseMode() then
		SongOrCourse = GAMESTATE:GetCurrentCourse();
		StepsOrTrail = GAMESTATE:GetCurrentTrail(pn);
	else
		SongOrCourse = GAMESTATE:GetCurrentSong();
		StepsOrTrail = GAMESTATE:GetCurrentSteps(pn);
	end;
	local t2 = Def.ActorFrame{
		InitCommand=cmd(player,pn);
		LoadActor( THEME:GetPathB("ScreenStageInformation","in/diffback") )..{
			InitCommand=function(self)
				if pn == PLAYER_1 then
					self:x(20);
				else
					self:x(-20);	
					self:rotationy(180);
				end;
				self:playcommand("Update");
			end;
			UpdateCommand=cmd(croptop,1;sleep,0.8;linear,0.2;croptop,0;);
		};
		LoadActor( THEME:GetPathG("DiffDisplay","frame/frame") )..{
			InitCommand=cmd(animate,false;playcommand,"Update");
			UpdateCommand=function(self)
				local difficultyStates = {
					Difficulty_Beginner	= 0,
					Difficulty_Easy		= 2,
					Difficulty_Medium	= 4,
					Difficulty_Hard		= 6,
					Difficulty_Challenge	= 8,
					Difficulty_Edit		= 10,
				};
				if StepsOrTrail then
					local state = difficultyStates[StepsOrTrail:GetDifficulty()];
					if pn == PLAYER_2 then state = state + 1; end;
					self:setstate(state);
				end;
			end;
		};
		LoadFont("StepsDisplay meter")..{
			InitCommand=function(self)
				if pn == PLAYER_1 then
					self:x(44);
					self:horizalign(left);
				else
					self:x(-44);
					self:horizalign(right);
				end;
				(cmd(shadowlength,0;maxwidth,60;zoom,0.65;skewx,-0.175;playcommand,"Update"))(self)
			end;
			UpdateCommand=function(self)
				if not GAMESTATE:IsCourseMode() then
					self:stoptweening();
					if SongOrCourse then
						if SongOrCourse:HasStepsTypeAndDifficulty(st,StepsOrTrail:GetDifficulty()) then
							local meter = StepsOrTrail:GetMeter();
							if GetAdhocPref("UserMeterType") == "CSStyle" and StepsOrTrail:GetDifficulty() ~= "Difficulty_Edit" then
								meter = GetConvertDifficulty(SongOrCourse,StepsOrTrail:GetDifficulty());
							end;
							self:settextf("%d",meter);
							self:diffuse(CustomDifficultyToColor(StepsOrTrail:GetDifficulty()));
						end;
					end;
				else
					self:settext("");
				end;
			end;
		};
		Def.StepsDisplay {
			InitCommand=cmd(Load,"StepsDisplayEvaluation",pn;SetFromGameState,pn;);
			UpdateNetEvalStatsMessageCommand=function(self,param)
				if GAMESTATE:IsPlayerEnabled(pn) then
					self:SetFromSteps(param.Steps)
				end;
			end;
		};
	};
	t[#t+1] = StandardDecorationFromTable( "StepsDisplay" .. ToEnumShortString(pn), t2 );
end

--[[
t[#t+1] = LoadFont("Common Normal") .. {
	InitCommand=cmd(Center;settext,getenv("exgrade"));
};
]]

if THEME:GetMetric( Var "LoadingScreen","Summary" ) == false then
	for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
		t[#t+1] = LoadActor("upset", pn)..{
			InitCommand=cmd(draworder,73);
		};
	end;
	t[#t+1] = StandardDecorationFromFileOptional( "FOpen", "FOpen" );
end;

return t;