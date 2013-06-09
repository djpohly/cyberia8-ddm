local t = Def.ActorFrame {
	Def.ActorFrame {
		InitCommand=cmd(Center;);
		--p1
		Def.Quad {
			InitCommand=cmd(x,-233;y,4;zoomtowidth,152;zoomtoheight,364;diffuse,color("0,0,0,0.6"););
		};
		Def.Quad {
			InitCommand=cmd(x,-120;y,4;zoomtowidth,74;zoomtoheight,364;diffuse,color("0.2,0,0,0.6"););
		};
		
		--p1
		Def.Quad {
			InitCommand=cmd(x,157;y,4;zoomtowidth,152;zoomtoheight,364;diffuse,color("0,0,0,0.6"););
		};
		Def.Quad {
			InitCommand=cmd(x,270;y,4;zoomtowidth,74;zoomtoheight,364;diffuse,color("0.2,0,0,0.6"););
		};
	};

	Def.ActorFrame {
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_TOP+74;diffuse,color("0,1,1,1"););

		--p1
		LoadFont("Common Normal") .. {
			Text="Primary";
			InitCommand=cmd(x,-270;zoom,0.55;strokecolor,color("0,0,0,1"););
		};
		LoadFont("Common Normal") .. {
			Text="Secondary";
			InitCommand=cmd(x,-195;zoom,0.55;strokecolor,color("0,0,0,1"););
		};
		LoadFont("Common Normal") .. {
			Text="Default";
			InitCommand=cmd(x,-120;zoom,0.55;strokecolor,color("0,0,0,1"););
		};

		--p2
		LoadFont("Common Normal") .. {
			Text="Primary";
			InitCommand=cmd(x,120;zoom,0.55;strokecolor,color("0,0,0,1"););
		};
		LoadFont("Common Normal") .. {
			Text="Secondary";
			InitCommand=cmd(x,195;zoom,0.55;strokecolor,color("0,0,0,1"););
		};
		LoadFont("Common Normal") .. {
			Text="Default";
			InitCommand=cmd(x,270;zoom,0.55;strokecolor,color("0,0,0,1"););
		};
	};
};

return t