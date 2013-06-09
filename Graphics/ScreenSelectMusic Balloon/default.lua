local t = Def.ActorFrame{
	Def.Sprite{
		OnCommand=cmd(playcommand,"Set");
		ShowCommand=cmd(cropleft,1;cropright,0;sleep,0.1;decelerate,0.2;cropleft,0;diffusealpha,1;);
		HideCommand=cmd(linear,0.1;diffusealpha,0;);
		SetCommand=function(self)
			self:stoptweening();
			local song = GAMESTATE:GetCurrentSong();
			if song then
				if song:IsLong() or song:IsMarathon() then
					self:playcommand("Show");
					if song:IsLong() then
						self:Load(THEME:GetPathG("ScreenSelectMusic","Balloon/_long"));
					elseif song:IsMarathon() then
						self:Load(THEME:GetPathG("ScreenSelectMusic","Balloon/_marathon"));
					end;
				else
					self:playcommand("Hide");	
				end;
			else
				self:playcommand("Hide");
			end;
		end;
		CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	};
};

return t;