--[[ScreenSelectMusic underlay]]

local t = Def.ActorFrame{};

--etc
if not IsNetConnected() then
	t[#t+1] = LoadActor("_back_m")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-224;y,SCREEN_CENTER_Y+70;diffusealpha,0;zoom,1.5;addx,-60;);
		OnCommand=cmd(sleep,0.2;decelerate,0.3;zoom,1;addx,60;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0"););
		--RepeatCommand=cmd(sleep,14.25;diffusealpha,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,0.5");decelerate,1;glow,color("1,1,0,0");queuecommand,"Repeat";);
	};
end;
	
t[#t+1] = LoadActor("_diff")..{
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y+74);
		if IsNetConnected() then self:x(DifficultyListX()+10);
		else self:x(SCREEN_CENTER_X-88);
		end;
	end;
	OnCommand=cmd(zoomy,0;sleep,0.2;decelerate,0.3;zoomy,1;glow,color("1,1,0,0");linear,0.05;glow,color("1,1,0,1");decelerate,0.4;glow,color("1,1,0,0"););
};

return t;