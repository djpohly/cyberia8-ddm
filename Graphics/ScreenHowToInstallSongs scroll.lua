local gc = Var("GameCommand");
local squareSize = 8; -- was 18

return Def.ActorFrame {
	Def.Quad{
		InitCommand=cmd(x,-12;y,2;zoom,squareSize;diffuse,color("1,1,0,1");strokecolor,color("0,0,0,1"););
		GainFocusCommand=cmd(stoptweening;accelerate,0.25;zoom,squareSize;);
		LoseFocusCommand=cmd(stoptweening;decelerate,0.25;zoom,0;rotationz,360;);
	};
	LoadFont("Common Normal") .. {
		Text=gc:GetText();
		InitCommand=cmd(halign,0;zoom,0.625;wrapwidthpixels,200*1.375;strokecolor,color("0,0,0,1"););
		GainFocusCommand=cmd(stoptweening;decelerate,0.25;diffuse,color("0,1,1,1"););
		LoseFocusCommand=cmd(stoptweening;accelerate,0.25;diffuse,color("0,0.5,0.5,1"));
	};
};