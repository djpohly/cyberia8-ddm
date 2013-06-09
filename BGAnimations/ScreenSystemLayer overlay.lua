local function CreditsText( pn )
	function update(self)
		local str = ScreenSystemLayerHelpers.GetCreditsMessage(pn);
		local topScreenName = SCREENMAN:GetTopScreen():GetName();
		--[ja] WARNING出まくってるから…
		if topScreenName ~= "ScreenOptionsFrameSet" then self:settext(str);
		end;
	end

	function UpdateVisible(self)
		local screen = SCREENMAN:GetTopScreen();
		local bShow = true;
		if screen then
			local sClass = screen:GetName();
			bShow = THEME:GetMetric( sClass, "ShowCoinsAndCredits" );
		end

		self:visible( bShow );
	end

	local text = LoadFont(Var "LoadingScreen","credits") .. {
		InitCommand=THEME:GetMetric(Var "LoadingScreen","CreditsInitCommand");
		RefreshCreditTextMessageCommand=update;
		CoinInsertedMessageCommand=update;
		PlayerJoinedMessageCommand=update;
		ScreenChangedMessageCommand=UpdateVisible;
	};
	return text;
end

local t = Def.ActorFrame {
	Def.ActorFrame {
		Def.Quad {
			InitCommand=cmd(zoomtowidth,SCREEN_WIDTH;zoomtoheight,50;horizalign,left;vertalign,top,SCREEN_TOP;diffuse,color("0,0,0,0"););
			OnCommand=cmd(finishtweening;linear,0.5;diffuse,color("0,0,0,0.65");diffusebottomedge,color("0,0,0,0"););
			OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
		};
		LoadFont(Var "LoadingScreen","SystemMessage") .. {
			Name="Text";
			InitCommand=cmd(maxwidth,SCREEN_WIDTH*1.5-10;horizalign,left;vertalign,top;zoom,0.75;
						x,SCREEN_LEFT+10;y,SCREEN_TOP+10;shadowlength,2;strokecolor,color("0,0,0,1");diffusealpha,0;);
			OnCommand=cmd(finishtweening;linear,0.5;diffusealpha,1;);
			OffCommand=cmd(sleep,3;linear,0.5;diffusealpha,0;);
		};
		SystemMessageMessageCommand = function(self, params)
			self:GetChild("Text"):settext( params.Message );
			self:playcommand( "On" );
			if params.NoAnimate then
				self:finishtweening();
			end
			self:playcommand( "Off" );
		end;
		HideSystemMessageMessageCommand = cmd(finishtweening);
	};
	CreditsText( PLAYER_1 ) .. {
		InitCommand=cmd(x,THEME:GetMetric(Var "LoadingScreen","CreditsP1X");y,THEME:GetMetric(Var "LoadingScreen","CreditsP1Y"););
	};
	CreditsText( PLAYER_2 ) .. {
		InitCommand=cmd(x,THEME:GetMetric(Var "LoadingScreen","CreditsP2X");y,THEME:GetMetric(Var "LoadingScreen","CreditsP2Y"););
	};
};
return t;
