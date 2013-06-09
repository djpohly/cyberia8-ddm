
local t = Def.ActorFrame{
	-- song or course banner
	Def.Banner{
		InitCommand=cmd(Center;shadowlength,2;);
		OnCommand=function(self)
			local sjacketPath ,cbannerpath ,scdimagepath;
			local songorcourse;
			local coursemode = GAMESTATE:IsCourseMode();
			if coursemode then
				songorcourse = GAMESTATE:GetCurrentCourse();
				cbannerpath = songorcourse:GetBannerPath();
				if not cbannerpath then cbannerpath = THEME:GetPathG("Common fallback","jacket");
				end;
				self:Load( cbannerpath );
			else
				songorcourse = GAMESTATE:GetCurrentSong();
				sjacketpath = songorcourse:GetJacketPath();
				scdimagepath = songorcourse:GetCDImagePath();
				if sjacketpath then self:Load( sjacketpath );
				elseif scdimagepath then self:Load( scdimagepath );
				elseif not sjacketpath and not scdimagepath then
					self:Load( THEME:GetPathG("Common fallback","jacket") );
				end;
			end;
			(cmd(x,SCREEN_RIGHT-146;y,SCREEN_CENTER_Y+60;diffusealpha,0;zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,8/2;
			sleep,0.3;diffusealpha,1;accelerate,0.3;zoomtowidth,256;accelerate,0.2;zoomtoheight,256;sleep,1.2;linear,0.075;
			x,SCREEN_CENTER_X;zoomtowidth,300;linear,0.075;y,SCREEN_CENTER_Y-60;zoomtoheight,300;sleep,0.7+0.7;
			linear,0.1;rotationx,-50;rotationz,30;zoomtowidth,SCREEN_WIDTH*1.5;zoomtoheight,SCREEN_HEIGHT*1.25;diffusealpha,0))(self)
		end;
	};
};

return t;