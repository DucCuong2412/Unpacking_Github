using Galaxy.Api;
using Helpers;
using UnityEngine;

public class GogGalaxyManager : MonoBehaviour
{
	public class AuthenticationListener : GlobalAuthListener
	{
		public override void OnAuthSuccess()
		{
			myGalaxyID = GalaxyInstance.User().GetGalaxyID();
			Debug.Log("Successfully signed in as user: " + myGalaxyID);
			Instance.StartStatsAndAchievements();
		}

		public override void OnAuthFailure(FailureReason failureReason)
		{
			Debug.LogWarning("Failed to sign in for reason " + failureReason);
			Instance.StartStatsAndAchievements();
		}

		public override void OnAuthLost()
		{
			Debug.LogWarning("Authorization lost");
		}
	}

	public class GogServicesConnectionStateListener : GlobalGogServicesConnectionStateListener
	{
		public override void OnConnectionStateChange(GogServicesConnectionState connected)
		{
			Debug.Log("Connection state to GOG services changed to " + connected);
		}
	}

	private readonly string clientID = "54686787193254536";

	private readonly string clientSecret = "b548b3b75a37225929a6efd8a66e1f08481b3c30991704c96857a1384f27c68c";

	public static GogGalaxyManager Instance;

	public StatsAndAchievements StatsAndAchievements;

	private static GalaxyID myGalaxyID;

	private bool galaxyFullyInitialized;

	public AuthenticationListener authListener;

	public GogServicesConnectionStateListener gogServicesConnectionStateListener;

	public GalaxyID MyGalaxyID => myGalaxyID;

	public bool GalaxyFullyInitialized => galaxyFullyInitialized;

	private void Awake()
	{
		if (Instance == null)
		{
			Instance = this;
			Object.DontDestroyOnLoad(base.gameObject);
		}
		else
		{
			Object.Destroy(this);
		}
	}

	private void OnEnable()
	{
		Init();
		ListenersInit();
		SignInGalaxy();
	}

	private void Update()
	{
		GalaxyInstance.ProcessData();
	}

	private void OnDisable()
	{
		ShutdownAllFeatureClasses();
		ListenersDispose();
	}

	private void OnApplicationQuit()
	{
		GalaxyInstance.Shutdown(unloadModule: true);
		Instance = null;
		Object.Destroy(this);
	}

	private void ListenersInit()
	{
		Listener.Create(ref authListener);
		Listener.Create(ref gogServicesConnectionStateListener);
	}

	private void ListenersDispose()
	{
		Listener.Dispose(ref authListener);
		Listener.Dispose(ref gogServicesConnectionStateListener);
	}

	public void StartStatsAndAchievements()
	{
		if (StatsAndAchievements == null)
		{
			StatsAndAchievements = base.gameObject.AddComponent<StatsAndAchievements>();
		}
	}

	public void ShutdownStatsAndAchievements()
	{
		if (StatsAndAchievements != null)
		{
			Object.Destroy(StatsAndAchievements);
		}
	}

	public void ShutdownAllFeatureClasses()
	{
		ShutdownStatsAndAchievements();
	}

	private void Init()
	{
		InitParams initpParams = new InitParams(clientID, clientSecret);
		Debug.Log("Initializing GalaxyPeer instance...");
		try
		{
			GalaxyInstance.Init(initpParams);
			galaxyFullyInitialized = true;
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Init failed for reason " + error);
			galaxyFullyInitialized = false;
		}
	}

	public void SignInGalaxy()
	{
		Debug.Log("Signing user in using Galaxy client...");
		try
		{
			GalaxyInstance.User().SignInGalaxy();
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("SignInGalaxy failed for reason " + error);
		}
	}

	public void SignInCredentials(string username, string password)
	{
		Debug.Log("Signing user in using credentials...");
		try
		{
			GalaxyInstance.User().SignInCredentials(username, password);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("SignInCredentials failed for reason " + error);
		}
	}

	public void SignOut()
	{
		Debug.Log("Singing user out...");
		try
		{
			GalaxyInstance.User().SignOut();
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("SignOut failed for reason " + error);
		}
	}

	public bool IsSignedIn(bool silent = false)
	{
		bool result = false;
		if (!silent)
		{
			Debug.Log("Checking SignedIn status...");
		}
		try
		{
			result = GalaxyInstance.User().SignedIn();
			if (!silent)
			{
				Debug.Log("User SignedIn: " + result);
			}
		}
		catch (GalaxyInstance.Error error)
		{
			if (!silent)
			{
				Debug.LogWarning("Could not check user signed in status for reason " + error);
			}
		}
		return result;
	}

	public bool IsLoggedOn(bool silent = false)
	{
		bool result = false;
		if (!silent)
		{
			Debug.Log("Checking LoggedOn status...");
		}
		try
		{
			result = GalaxyInstance.User().IsLoggedOn();
			if (!silent)
			{
				Debug.Log("User logged on: " + result);
			}
		}
		catch (GalaxyInstance.Error error)
		{
			if (!silent)
			{
				Debug.LogWarning("Could not check user logged on status for reason " + error);
			}
		}
		return result;
	}

	public string GetCurrentGameLanguage()
	{
		string text = null;
		Debug.Log("Checking current game language");
		try
		{
			text = GalaxyInstance.Apps().GetCurrentGameLanguage();
			Debug.Log("Current game language is " + text);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.Log("Could not check current game language for reason " + error);
		}
		return text;
	}
}
