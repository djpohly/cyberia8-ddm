return Def.ActorFrame {
	LoadActor("highlight") .. {
		InitCommand=cmd(x,-54;);
		GainFocusCommand=cmd(stoptweening;diffuse,color("1,0.8,1,1"));
		LoseFocusCommand=cmd(stoptweening;decelerate,0.1;diffuse,color("0,0,0,0");stopeffect;);
	};

	LoadActor("bullet1") .. {
		InitCommand=cmd(shadowlength,2;);
		GainFocusCommand=cmd(stoptweening;zoom,1.15;decelerate,0.2;diffuse,color("1,1,1,1"););
		LoseFocusCommand=cmd(stoptweening;decelerate,0.2;zoom,1;diffuse,color("0.5,0.5,0.5,1");stopeffect;);
	};
};