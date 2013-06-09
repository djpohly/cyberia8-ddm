
local t = Def.ActorFrame{};

local meterwidth = SCREEN_WIDTH/2-88;

local mframe;
mframe = Def.ActorFrame{
	Def.Quad{
		Name="Meterback";
		InitCommand=cmd(zoomto,meterwidth,12;diffuse,color("0,0,0,0.6"));
		BeginCommand=cmd(horizalign,right);
		ShowCommand=cmd(diffuse,color("0,0,0,1");diffuseshift;effectperiod,0.5;effectcolor1,color("0.6,0,0,1");effectcolor2,color("0,0,0,1"););
		HideCommand=cmd(stopeffect;stoptweening;diffuse,color("0,0,0,0.6"););
	};

	LoadActor(THEME:GetPathB("ScreenGameplay","decorations/normalover"))..{
		Name="Meter";
		InitCommand=cmd(setsize,meterwidth,12;diffuse,color("0,1,1,1");diffusetopedge,color("0,0.5,0.7,1");blend,"BlendMode_Add";);
		BeginCommand=cmd(horizalign,right);
		LifeChangedMessageCommand=function(self,params)
			self:finishtweening();
			self:bounceend(0.2);
			self:cropleft(1 - params.LifeMeter:GetLife());
		end;
		ShowCommand=cmd(finishtweening;diffuse,color("1,1,1,1");diffusetopedge,color("0.5,0.5,0.5,1"););
		HideCommand=cmd(diffuse,color("0,1,1,1");diffusetopedge,color("0,0.5,0.7,1"););
	};

	LoadActor(THEME:GetPathB("ScreenGameplay","decorations/hotover"))..{
		Name="Lifehot";
		InitCommand=cmd(setsize,meterwidth,12;diffusealpha,0;blend,'BlendMode_Add';); 
		BeginCommand=cmd(horizalign,right);
		ShowCommand=cmd(diffusealpha,1;finishtweening;diffuse,color("0.6,0.6,0.6,0.5");rainbow;effectperiod,3;);
		HideCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	};
};

local function update(self)
	local meterback = self:GetChild("Meterback");
	local hotline = self:GetChild("Lifehot");
	local normalline = self:GetChild("Meter");
	local bpmnormalmove = 0;
	local bpmhotmove = 0;
	local songPosition = GAMESTATE:GetSongPosition();
	local bpm = songPosition:GetCurBPS() * 60;
	local stop = songPosition:GetFreeze();
	local cbpm = bpm;
	if stop then cbpm = 0;
	end;
	
	local htplife = SCREENMAN:GetTopScreen():GetLifeMeter();

	bpmnormalmove = (cbpm/60)/3.5;
	bpmhotmove = (cbpm/60)/3;
	
	normalline:texcoordvelocity(bpmnormalmove,0);
	hotline:texcoordvelocity(bpmhotmove,0);

	if htplife:IsHot() then
		hotline:playcommand("Show");
		normalline:playcommand("Show");
	elseif htplife:IsInDanger() then
		meterback:playcommand("Show");
	else
		meterback:playcommand("Hide");
		normalline:playcommand("Hide");
		hotline:playcommand("Hide");
	end;
end;

mframe.InitCommand=cmd(SetUpdateFunction,update;);

t[#t+1] = mframe;

return t;