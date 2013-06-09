return LoadFont("Common Normal")..{
	InitCommand=function(self)
		local csversion = THEME:GetMetric("ThemeInfo","Version");
		self:settext(csversion);
	end;
};