return Def.ActorFrame {
	Def.ActorFrame {
		Condition=GAMESTATE:GetCoinMode() == 'CoinMode_Pay' or GAMESTATE:GetCoinMode() == 'CoinMode_Free';
		LoadActor("premium_back")..{
			Condition=GAMESTATE:GetPremium() == 'Premium_DoubleFor1Credit' or GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit';
			InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-120+5;zoomtowidth,SCREEN_WIDTH);
			OnCommand=cmd(diffuseshift;effectcolor1,color("0.4,0.4,0.4,0.4");effectcolor2,color("0.8,0.8,0.8,0.8");effectperiod,3);
		};

		LoadActor("information")..{
			Condition=GAMESTATE:GetPremium() == 'Premium_DoubleFor1Credit' or GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit';
			InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-132+5;zoomto,SCREEN_WIDTH,18;customtexturerect,0,0,SCREEN_WIDTH/self:GetWidth(),1;ztest,true);
			OnCommand=cmd(texcoordvelocity,0.15,0;diffuseshift;effectcolor1,color("0,1,1,1");effectcolor2,color("1,1,0,0.75");effectperiod,4);
		};

		LoadActor("doubles_premium")..{
			Condition=GAMESTATE:GetPremium() == 'Premium_DoubleFor1Credit';
			InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-112+5;zoomto,SCREEN_WIDTH,24;customtexturerect,0,0,SCREEN_WIDTH/self:GetWidth(),1;ztest,true);
			OnCommand=cmd(texcoordvelocity,0.1,0;diffuseshift;effectcolor1,color("0.75,0.75,0.75,0.75");effectcolor2,color("1,1,1,1");effectperiod,3);
		};

		LoadActor("joint_premium")..{
			Condition=GAMESTATE:GetPremium() == 'Premium_2PlayersFor1Credit';
			InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-112+5;zoomto,SCREEN_WIDTH,24;customtexturerect,0,0,SCREEN_WIDTH/self:GetWidth(),1;ztest,true);
			OnCommand=cmd(texcoordvelocity,0.1,0;diffuseshift;effectcolor1,color("0.75,0.75,0.75,0.75");effectcolor2,color("1,1,1,1");effectperiod,3);
		};
	};
};