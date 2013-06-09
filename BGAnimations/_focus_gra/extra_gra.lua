--[[_focus_gra]]

local t = Def.ActorFrame{};

local state = nil;

for i = 1, 2 do
	local function yset()
		local y = 300;
		if i == 1 then y = 300;
		else y = 1092;
		end;
		return y
	end;

	t[#t+1] = Def.ActorFrame{
		InitCommand=cmd(fov,100;x,SCREEN_RIGHT+40;y,SCREEN_CENTER_Y-170;rotationx,160;rotationy,140;rotationz,220;);
		OnCommand=cmd(zoom,2;accelerate,0.5;zoom,0.5;rotationx,200;rotationy,180;rotationz,200;);
		LoadActor("3dwarback")..{
			InitCommand=function(self)
				(cmd(y,yset();diffusealpha,0.4;fadeleft,0.2))(self)
				--local bExtra2 = GAMESTATE:IsExtraStage2();
				--local style = GAMESTATE:GetCurrentStyle();
				local song, steps = SONGMAN:GetExtraStageInfo( bExtra2, style );
				if song == GAMESTATE:GetCurrentSong() then
					state = true;
					else state = nil;
				end;
				if state == true then self:playcommand("Repeat");
				else self:playcommand("Stop");
				end;
			end;
			CurrentSongChangedMessageCommand=function(self)
				local bExtra2 = GAMESTATE:IsExtraStage2();
				local style = GAMESTATE:GetCurrentStyle();
				local song, steps = SONGMAN:GetExtraStageInfo( bExtra2, style );
				if song == GAMESTATE:GetCurrentSong() then
					state = true;
					else state = nil;
				end;
				if state == true then self:playcommand("Repeat");
				else self:playcommand("Stop");
				end;
			end;
			RepeatCommand=cmd(stoptweening;sleep,1;diffuse,color("1,1,1,0.4");linear,0.05;diffuse,color("1,1,1,1");linear,1;diffuse,color("1,1,1,0.4");queuecommand,"Repeat";);
			StopCommand=cmd(linear,0.05;diffuse,color("1,1,1,0.4");finishtweening;);
		};
	};
end;

return t;
