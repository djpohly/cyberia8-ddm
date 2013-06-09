
local titleMaxWidth = 225;
local subtitleMaxWidth = 379;
local artistMaxWidth = 375;

function TextBannerAfterSet(self,param)
	local Title = self:GetChild("Title");
	local Subtitle = self:GetChild("Subtitle");
	local Artist = self:GetChild("Artist");

	-- no subtitle
	if Subtitle:GetText() == "" then
		( cmd(maxwidth,titleMaxWidth;x,15;y,-9;shadowlength,0) )(Title);
		( cmd(visible,false) )(Subtitle);
		( cmd(zoom,0.575;maxwidth,artistMaxWidth;x,15;y,9;shadowlength,0) )(Artist);
	-- yes subtitle
	else
		( cmd(maxwidth,titleMaxWidth;zoomy,0.9;x,15;y,-23/2;shadowlength,0) )(Title);
		( cmd(maxwidth,subtitleMaxWidth;zoomx,0.575;zoomy,0.565;x,22;y,2;visible,true;shadowlength,0) )(Subtitle);
		( cmd(maxwidth,artistMaxWidth;zoomx,0.6;zoomy,0.565;x,15;y,12;shadowlength,0) )(Artist);
	end;

	-- hack I stole from AJ 187's moonlight
	if Title:GetText() == "DVNO" then
	-- four capital letters, printed in gold
		local attr = {
			Length = 4;
			Diffuse = color("1,0.8,0,1");
		};
		Title:AddAttribute(0,attr);
	-- details make the girls sweat even more
	end;
end;

function CourseTextBannerAfterSet(self,param)
	local Title = self:GetChild("Title");
	local Subtitle = self:GetChild("Subtitle");
	local Artist = self:GetChild("Artist");

	-- no subtitle
	if Subtitle:GetText() == "" then
		( cmd(maxwidth,titleMaxWidth;x,15;y,-6;shadowlength,0) )(Title);
		( cmd(visible,false) )(Subtitle);
		( cmd(visible,false) )(Artist);
	-- yes subtitle
	else
		( cmd(maxwidth,titleMaxWidth;zoomy,0.9;x,15;y,-20/2;shadowlength,0) )(Title);
		( cmd(maxwidth,subtitleMaxWidth;zoomx,0.575;zoomy,0.565;x,8;y,4;visible,true;shadowlength,0) )(Subtitle);
		( cmd(visible,false) )(Artist);
	end;

	-- and the DVNO hack again
	if Title:GetText() == "DVNO" then
	-- four capital letters, printed in gold
		local attr = {
			Length = 4;
			Diffuse = color("1,0.8,0,1");
		};
		Title:AddAttribute(0,attr);
	-- no need to ask my name to figure out how cool I am -asg
	end;
end;

function EvaluationTextBannerAfterSet(self,param)
	local Title = self:GetChild("Title");
	local Subtitle = self:GetChild("Subtitle");
	local Artist = self:GetChild("Artist");

	-- no subtitle
	if Subtitle:GetText() == "" then
		( cmd(maxwidth,titleMaxWidth;x,15;y,-9;shadowlength,0) )(Title);
		( cmd(visible,false) )(Subtitle);
		( cmd(zoom,0.575;maxwidth,artistMaxWidth;x,15;y,9;shadowlength,0) )(Artist);
	-- yes subtitle
	else
		( cmd(maxwidth,titleMaxWidth;zoomy,0.9;x,15;y,-23/2;shadowlength,0) )(Title);
		( cmd(maxwidth,subtitleMaxWidth;zoomx,0.575;zoomy,0.565;x,22;y,2;visible,true;shadowlength,0) )(Subtitle);
		( cmd(maxwidth,artistMaxWidth;zoomx,0.6;zoomy,0.565;x,15;y,12;shadowlength,0) )(Artist);
	end;

	-- hack I stole from AJ 187's moonlight
	if Title:GetText() == "DVNO" then
	-- four capital letters, printed in gold
		local attr = {
			Length = 4;
			Diffuse = color("1,0.8,0,1");
		};
		Title:AddAttribute(0,attr);
	-- details make the girls sweat even more
	end;
end;

function DemoTextBannerAfterSet(self,param)
	local Title = self:GetChild("Title");
	local Subtitle = self:GetChild("Subtitle");
	local Artist = self:GetChild("Artist");

	-- no subtitle
	if Subtitle:GetText() == "" then
		( cmd(maxwidth,titleMaxWidth;x,15;y,-9;shadowlength,0) )(Title);
		( cmd(visible,false) )(Subtitle);
		( cmd(zoom,0.575;maxwidth,artistMaxWidth;x,15;y,9;shadowlength,0) )(Artist);
	-- yes subtitle
	else
		( cmd(maxwidth,titleMaxWidth;zoomy,0.9;x,15;y,-23/2;shadowlength,0) )(Title);
		( cmd(maxwidth,subtitleMaxWidth;zoomx,0.575;zoomy,0.565;x,8;y,2;visible,true;shadowlength,0) )(Subtitle);
		( cmd(maxwidth,artistMaxWidth;zoomx,0.6;zoomy,0.565;x,15;y,12;shadowlength,0) )(Artist);
	end;

	-- hack I stole from AJ 187's moonlight
	if Title:GetText() == "DVNO" then
	-- four capital letters, printed in gold
		local attr = {
			Length = 4;
			Diffuse = color("1,0.8,0,1");
		};
		Title:AddAttribute(0,attr);
	-- details make the girls sweat even more
	end;
end;

function GamePlayTextBannerAfterSet(self,param)
	local Title = self:GetChild("Title");
	local Subtitle = self:GetChild("Subtitle");
	local Artist = self:GetChild("Artist");

	-- no subtitle
	if Subtitle:GetText() == "" then
		( cmd(maxwidth,titleMaxWidth;x,15;y,-9;shadowlength,2) )(Title);
		( cmd(visible,false) )(Subtitle);
		( cmd(zoom,0.575;maxwidth,artistMaxWidth;x,15;y,9;shadowlength,2) )(Artist);
	-- yes subtitle
	else
		( cmd(maxwidth,titleMaxWidth;zoomy,0.9;x,15;y,-23/2;shadowlength,2) )(Title);
		( cmd(maxwidth,subtitleMaxWidth;zoomx,0.575;zoomy,0.565;x,22;y,2;visible,true;shadowlength,2) )(Subtitle);
		( cmd(maxwidth,artistMaxWidth;zoomx,0.6;zoomy,0.565;x,15;y,12;shadowlength,2) )(Artist);
	end;

	-- hack I stole from AJ 187's moonlight
	if Title:GetText() == "DVNO" then
	-- four capital letters, printed in gold
		local attr = {
			Length = 4;
			Diffuse = color("1,0.8,0,1");
		};
		Title:AddAttribute(0,attr);
	-- details make the girls sweat even more
	end;
end;