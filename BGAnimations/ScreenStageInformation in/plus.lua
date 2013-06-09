local t = Def.ActorFrame{}

local sjacketPath ,sbannerpath ,scdimagepath;
local songorcourse = GAMESTATE:GetCurrentSong();
sbannerpath = songorcourse:GetBannerPath();
sjacketpath = songorcourse:GetJacketPath();
scdimagepath = songorcourse:GetCDImagePath();

t[#t+1] = Def.ActorFrame{
	-- song or course banner
	Def.Banner{
		InitCommand=cmd(Center;shadowlength,2;);
		OnCommand=function(self)
			if sjacketpath then self:Load( sjacketpath );
			else self:Load( scdimagepath );
			end;
			(cmd(diffusealpha,0;zoomtowidth,384;zoomtoheight,110;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+10;
			sleep,2;zoomtowidth,300;linear,0.15;y,SCREEN_CENTER_Y-60;diffusealpha,1;zoomtoheight,300;sleep,0.7+0.7;
			linear,0.1;rotationx,-50;rotationz,30;zoomtowidth,SCREEN_WIDTH*1.5;zoomtoheight,SCREEN_HEIGHT*1.25;diffusealpha,0))(self)
		end;
	};

	Def.Banner{
		InitCommand=cmd(Center;shadowlength,2;);
		OnCommand=function(self)
			self:Load( sbannerpath );
			
			(cmd(x,SCREEN_RIGHT-210;y,SCREEN_CENTER_Y+60;diffusealpha,0;zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,8/2;
			sleep,0.3;diffusealpha,1;accelerate,0.3;zoomtowidth,384;accelerate,0.2;zoomtoheight,110;sleep,1.2;linear,0.075;
			x,SCREEN_CENTER_X;zoomtowidth,300;linear,0.15;zoomtoheight,300;y,SCREEN_CENTER_Y+10;diffusealpha,0))(self)
		end;
	};
};

return t;