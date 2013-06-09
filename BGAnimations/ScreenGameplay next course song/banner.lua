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
			local showjacket = GetAdhocPref("ShowJackets");
			if sbannerpath and not sjacketpath and not scdimagepath then
				self:visible(true);
				self:Load( sbannerpath );
			elseif showjacket == "Off" and not sbannerpath then
				self:visible(true);
				self:Load( THEME:GetPathG("Common fallback","banner") );
			end;
			(cmd(x,SCREEN_RIGHT-210;y,SCREEN_CENTER_Y+60;rotationx,0;rotationz,0;diffusealpha,0;
			zoomtowidth,SCREEN_WIDTH*2;zoomtoheight,8/2;sleep,0.3;diffusealpha,1;accelerate,0.3;zoomtowidth,384;accelerate,0.2;
			zoomtoheight,110;sleep,1.2;linear,0.075;x,SCREEN_CENTER_X;linear,0.075;y,SCREEN_CENTER_Y-50;sleep,0.7+0.7;
			linear,0.1;rotationx,-50;rotationz,30;zoomtowidth,SCREEN_WIDTH*1.5;zoomtoheight,SCREEN_HEIGHT*1.25;diffusealpha,0))(self)
		end;
		FinishCommand=cmd(finishtweening;diffusealpha,0;);
	};
};

return t;