//**************************************************************************
//
//                        Sybase Inc. 
//
//    THIS IS A TEMPORARY FILE GENERATED BY POWERBUILDER. IF YOU MODIFY 
//    THIS FILE, YOU DO SO AT YOUR OWN RISK. SYBASE DOES NOT PROVIDE 
//    SUPPORT FOR .NET ASSEMBLIES BUILT WITH USER-MODIFIED CS FILES. 
//
//**************************************************************************

#line 1 "c:\\svil_11\\gestione_associati\\pippo.pbl\\pippo.sra"
#line hidden
#line 1 "pippo"
#line hidden
[Sybase.PowerBuilder.PBGroupAttribute("pippo",Sybase.PowerBuilder.PBGroupType.Application,"c:\\svil_11\\gestione_associati\\pippo.pbl",null)]
[Sybase.PowerBuilder.PBFieldInfoCollectionAttribute("AppName","pippo", typeof(Sybase.PowerBuilder.PBString))]
public class c__pippo : Sybase.PowerBuilder.PBApplication
{
	#line hidden
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kGlobalVar, "sqlca", null, "pippo", null, null, "sqlca")]
	public Sybase.PowerBuilder.PBTransaction sqlca = null;
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kGlobalVar, "sqlda", null, "pippo", null, null, "sqlda")]
	public Sybase.PowerBuilder.PBDynamicDescriptionArea sqlda = null;
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kGlobalVar, "sqlsa", null, "pippo", null, null, "sqlsa")]
	public Sybase.PowerBuilder.PBDynamicStagingArea sqlsa = null;
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kGlobalVar, "error", null, "pippo", null, null, "error")]
	public Sybase.PowerBuilder.PBError error = null;
	[Sybase.PowerBuilder.PBVariableAttribute(Sybase.PowerBuilder.VariableTypeKind.kGlobalVar, "message", null, "pippo", null, null, "message")]
	public Sybase.PowerBuilder.PBMessage message = null;
	public c__pippo pippo = null;
	public c__w_pippo w_pippo = null;

	public static c__pippo GetCurrentApplication()
	{
		c__pippo currApp = Sybase.PowerBuilder.PBApplication.CurrentApplication as c__pippo;
		if ((currApp != null )&&(currApp.pippo == null))
		{
			currApp.pippo = currApp;
		}

		return currApp;
	}

	public override Sybase.PowerBuilder.PBError Error
	{
		get { return error; }
	}

	public override Sybase.PowerBuilder.PBMessage Message
	{
		get { return message; }
	}

	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("create")]
	public override void create()
	{
		#line hidden
		#line hidden
		AppName = new Sybase.PowerBuilder.PBString("pippo");
		#line hidden
		#line hidden
		message = (Sybase.PowerBuilder.PBMessage)this.CreateInstance(typeof(Sybase.PowerBuilder.PBMessage));
		#line hidden
		#line hidden
		sqlca = (Sybase.PowerBuilder.PBTransaction)this.CreateInstance(typeof(Sybase.PowerBuilder.PBTransaction));
		#line hidden
		#line hidden
		sqlda = (Sybase.PowerBuilder.PBDynamicDescriptionArea)this.CreateInstance(typeof(Sybase.PowerBuilder.PBDynamicDescriptionArea));
		#line hidden
		#line hidden
		sqlsa = (Sybase.PowerBuilder.PBDynamicStagingArea)this.CreateInstance(typeof(Sybase.PowerBuilder.PBDynamicStagingArea));
		#line hidden
		#line hidden
		error = (Sybase.PowerBuilder.PBError)this.CreateInstance(typeof(Sybase.PowerBuilder.PBError));
		#line hidden
	}

	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("destroy")]
	public override void destroy()
	{
		#line hidden
		#line hidden
		Sybase.PowerBuilder.Win.PBSession.CurrentSession.DestroyObject(sqlca);
		#line hidden
		#line hidden
		Sybase.PowerBuilder.Win.PBSession.CurrentSession.DestroyObject(sqlda);
		#line hidden
		#line hidden
		Sybase.PowerBuilder.Win.PBSession.CurrentSession.DestroyObject(sqlsa);
		#line hidden
		#line hidden
		Sybase.PowerBuilder.Win.PBSession.CurrentSession.DestroyObject(error);
		#line hidden
		#line hidden
		Sybase.PowerBuilder.Win.PBSession.CurrentSession.DestroyObject(message);
		#line hidden
	}

	#line 1 "pippo.open"
	#line hidden
	[Sybase.PowerBuilder.PBEventAttribute("open")]
	public override void open(Sybase.PowerBuilder.PBString commandline)
	{
		#line hidden
		#line 1
		Sybase.PowerBuilder.Win.PBSystemFunctions.Open(ref w_pippo);
		#line hidden
	}

	void _init()
	{
		AppName = new Sybase.PowerBuilder.PBString("pippo");
		#line hidden
		this.CreateEvent += new Sybase.PowerBuilder.PBEventHandler(this.create);
		this.DestroyEvent += new Sybase.PowerBuilder.PBEventHandler(this.destroy);
		this.OpenEvent += new Sybase.PowerBuilder.PBOpenHandler(this.open);
	}

	public c__pippo()
	{
		_init();
	}


	[System.STAThread]
	static void Main()
	{
		c__pippo.ApplicationName = "pippo";
		Sybase.PowerBuilder.PBSessionBase.HasPBExtensions = false;
		Sybase.PowerBuilder.PBSessionBase.MainAssembly = System.Reflection.Assembly.GetExecutingAssembly();
		Sybase.PowerBuilder.Win.PBSession session = Sybase.PowerBuilder.Win.PBSession.CreateSession(
			typeof(c__pippo), 
			@"pippo.pbd");
		c__pippo.GetCurrentApplication().pippo = c__pippo.GetCurrentApplication();
		session.RunWinForm();
	}
}
 