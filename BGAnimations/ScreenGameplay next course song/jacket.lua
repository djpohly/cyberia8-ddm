local t = Def.ActorFrame{
	-- song or course banner
	Def.Banner{
		InitCommand=cmd(Center;shadowlength,2;);
		ChangeCourseSongInMessageCommand=cmd(diffusealpha,0;);
		StartCommand=function(self)
			self:visible(false);
			local songorcourse = SCREENMAN:GetTopScreen():GetNextCourseSong();
			local sbannerpath = songorcourse:GetBannerPath();
			local sjacketpath = songorcourse:GetJacketPath();
			local scdimagepath = songorcourse:GetCDImagePath();
			if (not sbannerpath and (sjacketpath or scdimagepath)) then
				self:visible(true);
				if sjacketpath then self:Load( sjacketpath );
				elseif scdimagepath then self:Load( scdimagepath );
				elseif not sjacketpath and not scdimagepath then
					self:Load( THEME:GetPathG("Common fallback","jacket") );
				end;
			elseif not sbannerpath and not sjacketpath and not scdimagepath then
				self:visible(true);
				self:Load( THEME:GetPathG("Common fallback","jacket") );
			end;
			(cmd(x,SCREEN_RIGHT-146;y,SCREEN_CENTER_Y+60;rotationx,0;rotationz,0;diffusealpha,0;
			zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,8/2;sleep,0.3;diffusealpha,1;accelerate,0.3;zoomtowidth,256;
			accelerate,0.2;zoomtoheight,256;sleep,1.2;linear,0.075;x,SCREEN_CENTER_X;zoomtowidth,300;linear,0.075;
			y,SCREEN_CENTER_Y-60+20;zoomtoheight,300;sleep,0.7+0.7;linear,0.1;rotationx,-50;
			rotationz,30;zoomtowidth,SCREEN_WIDTH*1.5;zoomtoheight,SCREEN_HEIGHT*1.25;diffusealpha,0))(self)
		end;
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};
};

return t;