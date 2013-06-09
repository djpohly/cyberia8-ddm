local pn = ...;
assert(pn);

local t = Def.ActorFrame{};

local numPlayers = GAMESTATE:GetNumPlayersEnabled();
local playernum = GAMESTATE:GetPlayerState(pn):GetPlayerNumber();
local sides = GAMESTATE:GetNumSidesJoined();
local twosides = (numPlayers == 1 and sides == 2);
local meterwidth = SCREEN_WIDTH/2-88;
setenv("oldlife","");

local op = GAMESTATE:GetSongOptionsString();
local opstr = string.lower(op);
local maxlives,maxlivesstr;
maxlives,maxlivesstr = string.find(opstr,"%d+lives");
local maxlivesnum;
if maxlives then
	maxlivesnum = tonumber(string.sub(opstr,maxlives,maxlivesstr-5));
else
	maxlivesnum = 0;
end;
local liveswidth = meterwidth / maxlivesnum;

local mframe;
mframe = Def.ActorFrame{
	BeginCommand=function(self)
		if twosides and pn ~= GAMESTATE:GetMasterPlayerNumber() then
			self:visible(true);
		else
			if GAMESTATE:IsPlayerEnabled(pn) then
				self:visible(true);
				-- oni
--					if GAMESTATE:IsCourseMode()
--						and GAMESTATE:GetPlayMode() == 'PlayMode_Oni' then
--						smLifeMeter = SCREENMAN:GetTopScreen():GetLifeMeter(Player);
--					end;
			elseif GAMESTATE:IsDemonstration() then
				self:visible(false);
			end;
		end;
	end;

	Def.Quad{
		Name="Meterback";
		InitCommand=cmd(zoomto,meterwidth,12;diffuse,color("0,0,0,0.6"));
		BeginCommand=function(self)
			if pn == PLAYER_1 then
				self:horizalign(left);
			else
				self:horizalign(right);
			end;
		end;

		HealthStateChangedMessageCommand=function(self,params)
			if not maxlives then
				if params.PlayerNumber == pn then
					if params.HealthState == 'HealthState_Danger' then
						self:playcommand("Show");
					else
						self:playcommand("Hide");
					end;
				end;
			end;
		end;
		ShowCommand=cmd(diffuse,color("0,0,0,1");diffuseshift;effectperiod,0.5;effectcolor1,color("0.6,0,0,1");effectcolor2,color("0,0,0,1"););
		HideCommand=cmd(stopeffect;stoptweening;diffuse,color("0,0,0,0.6"););
	};
	
	LoadActor("normalover")..{
		Name="Meter";
		InitCommand=cmd(setsize,meterwidth,12;diffuse,color("0,1,1,1");diffusetopedge,color("0,0.5,0.7,1");blend,"BlendMode_Add";);
		BeginCommand=function(self)
			if not GAMESTATE:IsPlayerEnabled(pn) then
				self:visible(false);
			end;
			if pn == PLAYER_1 then
				self:horizalign(left);
			else
				self:horizalign(right);
			end;
		end;
		HealthStateChangedMessageCommand=function(self,params)
			if params.PlayerNumber == pn then
				if params.HealthState == 'HealthState_Hot' then
					(cmd(finishtweening;diffuse,color("1,1,1,1");diffusetopedge,color("0.5,0.5,0.5,1");))(self);
				else
					(cmd(diffuse,color("0,1,1,1");diffusetopedge,color("0,0.5,0.7,1");))(self)
				end;
				if maxlives then
					--local diff = GAMESTATE:GetCurrentSteps(Player):GetDifficulty();
					--if (diff == 'Difficulty_Beginner' or diff == 'Difficulty_Easy') then
						if numPlayers == 1 then
							if params.HealthState == 'HealthState_Dead' then
								--GAMESTATE:ApplyGameCommand("stopmusic");
								SCREENMAN:GetTopScreen():PostScreenMessage('SM_BeginFailed', 0.5);
							end;
						else
							if pn == PLAYER_1 then
								local p1health = GAMESTATE:GetPlayerState(PLAYER_1):GetHealthState();
								if p1health == 'HealthState_Dead' then
									setenv("p1dead",'HealthState_Dead');
								else
									setenv("p1dead",'HealthState_Alive');
								end;
							end
							if pn == PLAYER_2 then
								local p2health = GAMESTATE:GetPlayerState(PLAYER_2):GetHealthState();
								if p2health == 'HealthState_Dead' then
									setenv("p2dead",'HealthState_Dead');
								else
									setenv("p2dead",'HealthState_Alive');
								end;
							end;
							local p1he = getenv("p1dead");
							local p2he = getenv("p2dead");
							if p1he == 'HealthState_Dead' and p2he == 'HealthState_Dead' then
								SCREENMAN:GetTopScreen():PostScreenMessage('SM_BeginFailed', 0.5);
							end;
						end;
					--end;
				end;
			end;
		end;
		LifeChangedMessageCommand=function(self,params)
			if params.Player == pn then
				local playerlife = params.LifeMeter:GetLife();
				self:finishtweening();
				if pn == PLAYER_1 then
					self:bounceend(0.2);
					self:cropright(1 - playerlife);
				else
					self:bounceend(0.2);
					self:cropleft(1 - playerlife);
				end;
				if maxlives then
					local lives = 1 / maxlivesnum;
					if playerlife == 1 then
						self:finishtweening();
						self:diffuse(color("1,1,1,1"));
						self:diffusetopedge(color("0.5,0.5,0.5,1"));
					elseif playerlife <= lives then
						self:finishtweening();
						self:diffuse(color("0.6,0,0,1"));
						self:diffusetopedge(color("0.8,0,0,1"));
					else
						self:finishtweening();
						self:diffuse(color("0,1,1,1"));
						self:diffusetopedge(color("0,0.5,0.7,1"));
					end;
				end;
			end;
		end;
	};
	
	LoadActor("hotover")..{
		Name="Lifehot";
		InitCommand=cmd(setsize,meterwidth,12;diffusealpha,0;blend,'BlendMode_Add';); 
		BeginCommand=function(self)
			if not GAMESTATE:IsPlayerEnabled(pn) then
				self:visible(false);
			end;
			if pn == PLAYER_1 then
				self:horizalign(left);
			else
				self:horizalign(right);
			end;
		end;
		HealthStateChangedMessageCommand=function(self,params)
			if params.PlayerNumber == pn then
				if params.HealthState == 'HealthState_Hot' then
					self:playcommand("Show");
				else
					self:playcommand("Hide");
				end;
			end;
		end;
		ShowCommand=cmd(diffusealpha,1;finishtweening;diffuse,color("0.6,0.6,0.6,0.5");rainbow;effectperiod,3;);
		HideCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	};
};

local function update(self)
	local hotline = self:GetChild("Lifehot");
	local normalline = self:GetChild("Meter");
	local bpmnormalmove = 0;
	local bpmhotmove = 0;
	local lifemove = 1;
	--[ja] ScreenGameplay BPMDisplayからBPMの値をもらいます
	
	if numPlayers == 1 then
		if NumSides == 1 then lifemove = -1;
		end;
		bpmnormalmove = ((getenv("playercurrentbpm")/60)*lifemove)/3.5;
		bpmhotmove = ((getenv("playercurrentbpm")/60)*lifemove)/3;
	else
		if pn == PLAYER_1 then
			lifemove = -1;
			bpmnormalmove = ((getenv("playercurrentbpmp1")/60)*lifemove)/3.5;
			bpmhotmove = ((getenv("playercurrentbpmp1")/60)*lifemove)/3;
		else
			bpmnormalmove = (getenv("playercurrentbpmp2")/60)/3.5;
			bpmhotmove = (getenv("playercurrentbpmp2")/60)/3;
		end;
	end;
	
	normalline:texcoordvelocity(bpmnormalmove,0);
	hotline:texcoordvelocity(bpmhotmove,0);
end;

mframe.InitCommand=cmd(SetUpdateFunction,update;);

t[#t+1] = mframe;

if maxlives then
	if maxlivesnum > 0 and maxlivesnum <= 15 then
		maxlivesnum = maxlivesnum - 1;
		for i = 1, maxlivesnum do
			t[#t+1] = Def.Quad {
				InitCommand=cmd(zoomtowidth,3;zoomtoheight,12;diffusealpha,1;);
				BeginCommand=function(self)
					if not GAMESTATE:IsPlayerEnabled(pn) then
						self:visible(false);
					end;
					self:visible(true);
					self:diffusetopedge(color("0,0,0,0.75"));
					self:diffusebottomedge(color("0,0,0,0.3"));
					if pn == PLAYER_1 then
						self:horizalign(left);
						self:x( liveswidth * i );
					else
						self:horizalign(right);
						self:x( -liveswidth * i );
					end;
				end;

				HealthStateChangedMessageCommand=function(self,params)
					if params.PlayerNumber == pn then
						if params.HealthState == 'HealthState_Hot' then
							self:playcommand("Show");
						else
							self:playcommand("Hide");
						end;
					end;
				end;
				ShowCommand=cmd(diffusealpha,1;linear,0.1;diffusealpha,0.3;);
				HideCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,1;);
			};
		end;	
	end;

	t[#t+1] = Def.Sprite {
		InitCommand=cmd(y,206;);
		LifeChangedMessageCommand=function(self,param)
			if param.Player == pn then
				self:visible(false);
				if numPlayers > 1 then
					self:zoom(2);
					if pn == PLAYER_1 then
						if param.LivesLeft == 0 then
							local p1diff = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
							self:visible(true);
							self:Load( THEME:GetPathB("ScreenGameplay","decorations/battery_failed_P1" ) );
							if not GAMESTATE:IsCourseMode() then
								local stageindex = GAMESTATE:GetCurrentStageIndex();
								if not GAMESTATE:IsEventMode() and stageindex == 0 and p1diff == 'Difficulty_Beginner' then
									self:visible(false);
								end;
							end;
							(cmd(horizalign,left;glow,color("0,0,0,0");diffusealpha,0;linear,0.1;glow,color("1,0,0,1");
							decelerate,0.2;zoom,1;diffusealpha,1;glow,color("0,0,0,0")))(self)
						end;
					else
						if param.LivesLeft == 0 then
							local p2diff = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
							self:visible(true);
							self:Load( THEME:GetPathB("ScreenGameplay","decorations/battery_failed_P2" ) );
							if not GAMESTATE:IsCourseMode() then
								local stageindex = GAMESTATE:GetCurrentStageIndex();
								if not GAMESTATE:IsEventMode() and stageindex == 0 and p2diff == 'Difficulty_Beginner' then
									self:visible(false);
								end;
							end;
							(cmd(horizalign,right;glow,color("0,0,0,0");diffusealpha,0;linear,0.1;glow,color("1,0,0,1");
							decelerate,0.2;zoom,1;diffusealpha,1;glow,color("0,0,0,0")))(self)
						end;
					end;
				end;
			end;
		end;
	};
end;

t.CurrentSongChangedMessageCommand=function(self)
	self:playcommand("LifeChangedMessage");
end;

return t;