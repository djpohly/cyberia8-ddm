local t = LoadFallbackB();

--[[ top of screen ]]
--life
t[#t+1] = StandardDecorationFromFile( "LifeFrame", "LifeFrame" );
t[#t+1] = LoadActor("mclife")..{
	InitCommand=cmd(x,SCREEN_RIGHT-23;y,SCREEN_TOP+34;draworder,93);
	OnCommand=cmd(zoomy,0;sleep,0.8;linear,0.2;zoomy,1);
};

return t;