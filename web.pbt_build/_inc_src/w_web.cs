//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\svil_11\\gestione_associati\\web.pbl\\w_web.srw"
#line hidden
#line 1 "w_web"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("w_web",Sybase.PowerBuilder.PBGroupType.Window,"c:\\svil_11\\gestione_associati\\web.pbl",null)]
[Sybase.PowerBuilder.PBFieldInfoCollectionAttribute("Width",1024, typeof(Sybase.PowerBuilder.PBInt),
"Height",660, typeof(Sybase.PowerBuilder.PBInt),
"TitleBar",true, typeof(Sybase.PowerBuilder.PBBoolean),
"Title","Untitled", typeof(Sybase.PowerBuilder.PBString),
"ControlMenu",true, typeof(Sybase.PowerBuilder.PBBoolean),
"MinBox",true, typeof(Sybase.PowerBuilder.PBBoolean),
"MaxBox",true, typeof(Sybase.PowerBuilder.PBBoolean),
"Resizable",true, typeof(Sybase.PowerBuilder.PBBoolean),
"BackColor",67108864, typeof(Sybase.PowerBuilder.PBLong),
"Icon","AppIcon!", typeof(Sybase.PowerBuilder.PBString),
"Center",true, typeof(Sybase.PowerBuilder.PBBoolean))]
public class c__w_web : Sybase.PowerBuilder.Web.PBWindow
{
	#line hidden
	public c__w_web.c__st_1 st_1 = null;

	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("create")]
	public override void create()
	{
		#line hidden
		#line hidden
		this.st_1 = (c__st_1)this.CreateInstance(this, "c__st_1");
		#line hidden
		#line hidden
		this.Control.AssignFrom( new Sybase.PowerBuilder.PBBoundedArray(typeof(c__w_web.c__st_1),  new Sybase.PowerBuilder.PBArray.ArrayBounds(new int[2]{1, 1}), new c__w_web.c__st_1[1]{
		this.st_1 }));
		#line hidden
	}

	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("destroy")]
	public override void destroy()
	{
		#line hidden
		#line hidden
		Sybase.PowerBuilder.Web.PBSession.CurrentSession.DestroyObject(this.st_1);
		#line hidden
	}

	#line 1 "w_web.st_1"
	#line hidden
[Sybase.PowerBuilder.PBFieldInfoCollectionAttribute("X",311, typeof(Sybase.PowerBuilder.PBInt),
"Y",204, typeof(Sybase.PowerBuilder.PBInt),
"Width",402, typeof(Sybase.PowerBuilder.PBInt),
"Height",64, typeof(Sybase.PowerBuilder.PBInt),
"TextSize",-10, typeof(Sybase.PowerBuilder.PBInt),
"Weight",400, typeof(Sybase.PowerBuilder.PBInt),
"FaceName","Tahoma", typeof(Sybase.PowerBuilder.PBString),
"TextColor",33554432, typeof(Sybase.PowerBuilder.PBLong),
"BackColor",67108864, typeof(Sybase.PowerBuilder.PBLong),
"Text","Ciao", typeof(Sybase.PowerBuilder.PBString),
"FocusRectangle",false, typeof(Sybase.PowerBuilder.PBBoolean))]
	public class c__st_1 : Sybase.PowerBuilder.Web.PBStaticText
	{
		#line hidden

		void _init()
		{
			X = new Sybase.PowerBuilder.PBInt(311);
			#line hidden
			Y = new Sybase.PowerBuilder.PBInt(204);
			#line hidden
			Width = new Sybase.PowerBuilder.PBInt(402);
			#line hidden
			Height = new Sybase.PowerBuilder.PBInt(64);
			#line hidden
			TextSize = new Sybase.PowerBuilder.PBInt(-10);
			#line hidden
			Weight = new Sybase.PowerBuilder.PBInt(400);
			#line hidden
			FontCharSet = (new Sybase.PowerBuilder.PBFontCharSetValue(Sybase.PowerBuilder.PBFontCharSet.Ansi));
			#line hidden
			FontPitch = (new Sybase.PowerBuilder.PBFontPitchValue(Sybase.PowerBuilder.PBFontPitch.Variable));
			#line hidden
			FontFamily = (new Sybase.PowerBuilder.PBFontFamilyValue(Sybase.PowerBuilder.PBFontFamily.Swiss));
			#line hidden
			FaceName = new Sybase.PowerBuilder.PBString("Tahoma");
			#line hidden
			TextColor = new Sybase.PowerBuilder.PBLong(33554432);
			#line hidden
			BackColor = new Sybase.PowerBuilder.PBLong(67108864);
			#line hidden
			Text = new Sybase.PowerBuilder.PBString("Ciao");
			#line hidden
			FocusRectangle = new Sybase.PowerBuilder.PBBoolean(false);
			#line hidden
			this.ID = "st_1";

			OnInitialUpdate();
		}

		public c__st_1()
		{
			_init();
		}

	}


	void _init()
	{
		Width = new Sybase.PowerBuilder.PBInt(1024);
		#line hidden
		Height = new Sybase.PowerBuilder.PBInt(660);
		#line hidden
		TitleBar = new Sybase.PowerBuilder.PBBoolean(true);
		#line hidden
		Title = new Sybase.PowerBuilder.PBString("Untitled");
		#line hidden
		ControlMenu = new Sybase.PowerBuilder.PBBoolean(true);
		#line hidden
		MinBox = new Sybase.PowerBuilder.PBBoolean(true);
		#line hidden
		MaxBox = new Sybase.PowerBuilder.PBBoolean(true);
		#line hidden
		Resizable = new Sybase.PowerBuilder.PBBoolean(true);
		#line hidden
		BackColor = new Sybase.PowerBuilder.PBLong(67108864);
		#line hidden
		Icon = new Sybase.PowerBuilder.PBString("AppIcon!");
		#line hidden
		Center = new Sybase.PowerBuilder.PBBoolean(true);
		#line hidden
		this.CreateEvent += new Sybase.PowerBuilder.PBEventHandler(this.create);
		this.DestroyEvent += new Sybase.PowerBuilder.PBEventHandler(this.destroy);
	}

	public c__w_web()
	{
		_init();
	}

}
 