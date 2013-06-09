return LoadFont("Common Normal") .. {
	Text = PREFSMAN:GetPreference('SongsPerPlay');
	BeginCommand=function(self)
		if GAMESTATE:IsEventMode() then
			self:settextf( Screen.String("EventMode") );
		elseif PREFSMAN:GetPreference('SongsPerPlay') == 1 then
			self:settextf( Screen.String("1Stage"), PREFSMAN:GetPreference('SongsPerPlay') );
		elseif PREFSMAN:GetPreference('SongsPerPlay') > 1 then
			self:settextf( Screen.String("MaxStages"), PREFSMAN:GetPreference('SongsPerPlay') );
		end
	end
};