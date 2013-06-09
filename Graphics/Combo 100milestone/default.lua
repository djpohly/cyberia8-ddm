local ShowFlashyCombo = GetUserPrefB("UserPrefFlashyCombo");
local pn;

if GAMESTATE:IsHumanPlayer(PLAYER_1) then pn = PLAYER_1;
else pn = PLAYER_2;
end;

local stepwidth = 0;
local stt;
local one = THEME:GetMetric("ArrowEffects","ArrowSpacing");

local t = Def.ActorFrame{};

if ShowFlashyCombo then
	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(playcommand,"Set");
		OnCommand=cmd(playcommand,"Set");
		SetCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				stt = GAMESTATE:GetCurrentTrail(pn):GetStepsType();
			else
				stt = GAMESTATE:GetCurrentSteps(pn):GetStepsType();
			end;
			if stt == 'StepsType_Dance_Single' then stepwidth = one*4;
			elseif stt == 'StepsType_Dance_Double' then stepwidth = one*8;
			elseif stt == 'StepsType_Dance_Couple' then stepwidth = one*4;
			elseif stt == 'StepsType_Dance_Solo' then stepwidth = one*6;
			elseif stt == 'StepsType_Dance_Threepanel' then stepwidth = one*3;
			else stepwidth = SCREEN_WIDTH;
			end;
		end;

		Def.Quad{
			InitCommand=cmd(playcommand,"Set");
			OnCommand=cmd(playcommand,"Set");
			SetCommand=cmd(x,-(stepwidth/2)-20;horizalign,right;zoomtoheight,0;zoomtowidth,20;diffuse,color("0,1,1,1");blend,'BlendMode_Add';);
			MilestoneCommand=cmd(zoomtowidth,0;zoomtoheight,0;fadeleft,0.5;diffusealpha,1;accelerate,0.35;
							zoomtowidth,20;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0.75;linear,1.65;fadeleft,1;diffusealpha,0);
		};
		Def.Quad {
			InitCommand=cmd(playcommand,"Set");
			OnCommand=cmd(playcommand,"Set");
			SetCommand=cmd(x,(stepwidth/2)+20;horizalign,left;zoomtoheight,0;zoomtowidth,20;diffuse,color("0,1,1,1");blend,'BlendMode_Add';);
			MilestoneCommand=cmd(zoomtowidth,0;zoomtoheight,0;faderight,0.5;diffusealpha,1;accelerate,0.35;
							zoomtowidth,20;zoomtoheight,SCREEN_HEIGHT;diffusealpha,0.75;linear,1.65;faderight,1;diffusealpha,0);
		};
	};
end;

return t;