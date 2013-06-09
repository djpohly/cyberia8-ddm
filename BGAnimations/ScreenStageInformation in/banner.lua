
local t = Def.ActorFrame{
	-- song or course banner
	Def.Banner{
		InitCommand=cmd(Center;shadowlength,2;);
		OnCommand=function(self)
			local sbannerpath ,cbannerpath;
			local songorcourse;
			local coursemode = GAMESTATE:IsCourseMode();
			if coursemode then
				songorcourse = GAMESTATE:GetCurrentCourse();
				cbannerpath = songorcourse:GetBannerPath();
				if not cbannerpath then cbannerpath = THEME:GetPathG("Common fallback","banner");
				end;
				self:Load( cbannerpath );
			else
				songorcourse = GAMESTATE:GetCurrentSong();
				sbannerpath = songorcourse:GetBannerPath();
				if not sbannerpath then sbannerpath = THEME:GetPathG("Common fallback","banner");
				end;
				self:Load( sbannerpath );
			end;
			(cmd(x,SCREEN_RIGHT-210;y,SCREEN_CENTER_Y+60;diffusealpha,0;zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,8/2;
			sleep,0.3;diffusealpha,1;accelerate,0.3;zoomtowidth,384;accelerate,0.2;zoomtoheight,110;sleep,1.2;linear,0.075;
			x,SCREEN_CENTER_X;linear,0.075;y,SCREEN_CENTER_Y-50;sleep,0.7+0.7;linear,0.1;rotationx,-50;rotationz,30;
			zoomtowidth,SCREEN_WIDTH*1.5;zoomtoheight,SCREEN_HEIGHT*1.25;diffusealpha,0))(self)
		end;
	};
};

return t;