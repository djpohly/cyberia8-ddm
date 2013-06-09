return LoadFont("_shared4") .. {
	Text=GetLifeDifficulty();
	AltText="";
	BeginCommand=function(self)
		self:settextf( Screen.String("LifeDifficulty"), GetLifeDifficulty() );
	end
};