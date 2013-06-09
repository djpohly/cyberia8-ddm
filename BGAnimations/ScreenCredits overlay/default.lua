local t = Def.ActorFrame{};
local count = tonumber(GetAdhocPref("CSCreditFlag"));

local movetime = 41;
local sleeptime = 20.5;

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(Center;);
	Def.ActorFrame{
		InitCommand=cmd(y,SCREEN_TOP;);
		LoadActor( "staff01" )..{
			OnCommand=cmd(addy,900;linear,movetime;addy,-1800;linear,0.1;diffusealpha,0);
		};

		LoadActor( "staff02" )..{
			OnCommand=cmd(addy,900;sleep,sleeptime;linear,movetime;addy,-1800;);
		};

		LoadActor( "staff03" )..{
			OnCommand=cmd(addy,900;sleep,sleeptime*2;linear,movetime;addy,-1800;);
		};

		LoadActor( "staff04" )..{
			OnCommand=cmd(addy,900;sleep,(sleeptime*3)+3;linear,movetime;addy,-1800;);
		};

		LoadActor( "staff05" )..{
			OnCommand=cmd(addy,900;sleep,(sleeptime*4)+3;linear,movetime;addy,-1800;);
		};

		LoadActor( "staff06" )..{
			OnCommand=cmd(addy,900;sleep,(sleeptime*5)+3;linear,movetime;addy,-1800;);
		};
		
		LoadActor( "staff07" )..{
			OnCommand=cmd(addy,900;sleep,(sleeptime*6)-5;linear,movetime;addy,-1800;);
		};
	};

	LoadActor( "thankyou" )..{
		OnCommand=cmd(diffusealpha,0;sleep,146.5;linear,0.5;diffusealpha,1;);
	};
};

--[[
t[#t+1] = LoadFont("Common Normal") ..{
	InitCommand=function(self)
		(cmd(visible,true;uppercase,true;settext,getenv("CSCreditFlag");addx,-16;addy,-10;horizalign,right;shadowlength,2;diffuse,color("1,1,0,1");zoom,0.65;))(self)
	end;
};
]]

t[#t+1] = Def.Quad{
	InitCommand=cmd(Center;FullScreen;diffuse,color("0,0,0,1"););
	OnCommand=cmd(sleep,2;linear,2;diffusealpha,0;sleep,148;linear,2;diffusealpha,1);
};

if count < 2 then
	--local topScreenName = SCREENMAN:GetTopScreen():GetName();
	setenv("CSCreditFlag",tonumber(GetAdhocPref("CSCreditFlag")));
	if tonumber(getenv("CSCreditFlag")) == 0 then
		t[#t+1] = Def.ActorFrame{
			InitCommand=cmd(y,SCREEN_TOP);
			OnCommand=cmd(sleep,4;linear,0.2;zoomy,0;);
			Def.Quad{
				InitCommand=cmd(horizalign,left;y,32;cropright,1;cropbottom,1;zoomtowidth,SCREEN_WIDTH;zoomtoheight,40*0.75;
							diffuse,color("0,0.5,0.5,0.5");diffuseleftedge,color("0,0,0,0.8"););
				OnCommand=cmd(sleep,0.5+0.25;linear,0.1;cropright,0;cropbottom,0;);
			};
			LoadFont("_Shared2") .. {
				InitCommand=function(self)
					(cmd(x,(SCREEN_WIDTH*0.1)+24;horizalign,left;zoom,0.65;y,32-2;maxwidth,SCREEN_WIDTH*1.35-40;diffuse,color("1,1,0,1");))(self)
					self:settext(string.format( THEME:GetString("ScreenCredits","Added1"),THEME:GetString("ScreenTitleMenu","Credits") ));
				end;
				OnCommand=cmd(cropright,1;sleep,0.5+0.25;decelerate,0.35;cropright,0;diffusealpha,1;);
			};
		};
		setenv("CSCreditFlag",count + 1);
	end;
	SetAdhocPref("CSCreditFlag",count + 1);
end;

return t;