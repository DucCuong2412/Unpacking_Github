using Galaxy.Api;
using Helpers;
using UnityEngine;

public class StatsAndAchievements : MonoBehaviour
{
	private class UserStatsAndAchievementsRetrieveListener : GlobalUserStatsAndAchievementsRetrieveListener
	{
		public bool retrieved;

		public override void OnUserStatsAndAchievementsRetrieveSuccess(GalaxyID userID)
		{
			retrieved = true;
			Debug.Log(string.Concat("User ", userID, " stats and achievements retrieved"));
		}

		public override void OnUserStatsAndAchievementsRetrieveFailure(GalaxyID userID, FailureReason failureReason)
		{
			retrieved = false;
			Debug.LogWarning(string.Concat("User ", userID, " stats and achievements could not be retrieved, for reason ", failureReason));
		}
	}

	private class StatsAndAchievementsStoreListener : GlobalStatsAndAchievementsStoreListener
	{
		public override void OnUserStatsAndAchievementsStoreFailure(FailureReason failureReason)
		{
			Debug.LogWarning("OnUserStatsAndAchievementsStoreFailure: " + failureReason);
		}

		public override void OnUserStatsAndAchievementsStoreSuccess()
		{
			Debug.Log("OnUserStatsAndAchievementsStoreSuccess");
		}
	}

	private class AchievementChangeListener : GlobalAchievementChangeListener
	{
		public override void OnAchievementUnlocked(string name)
		{
			Debug.Log("Achievement \"" + name + "\" unlocked");
		}
	}

	private UserStatsAndAchievementsRetrieveListener achievementRetrieveListener;

	private AchievementChangeListener achievementChangeListener;

	private StatsAndAchievementsStoreListener achievementStoreListener;

	private void OnEnable()
	{
		ListenersInit();
		if (GogGalaxyManager.Instance.IsSignedIn())
		{
			RequestUserStatsAndAchievements();
		}
	}

	private void OnDisable()
	{
		ListenersDispose();
	}

	private void ListenersInit()
	{
		Listener.Create(ref achievementRetrieveListener);
		Listener.Create(ref achievementChangeListener);
		Listener.Create(ref achievementStoreListener);
	}

	private void ListenersDispose()
	{
		Listener.Dispose(ref achievementStoreListener);
		Listener.Dispose(ref achievementRetrieveListener);
		Listener.Dispose(ref achievementChangeListener);
	}

	public void RequestUserStatsAndAchievements()
	{
		Debug.Log("Requesting Stats and Achievements");
		try
		{
			GalaxyInstance.Stats().RequestUserStatsAndAchievements();
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Achievements definitions could not be retrived for reason: " + error);
		}
	}

	public void SetAchievement(string apiKey)
	{
		if (!GogGalaxyManager.Instance.IsSignedIn(silent: true))
		{
			Debug.Log("SetAchievement | not signed in");
			return;
		}
		Debug.Log("Trying to unlock achievement " + apiKey);
		try
		{
			GalaxyInstance.Stats().SetAchievement(apiKey);
			GalaxyInstance.Stats().StoreStatsAndAchievements();
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Achievement " + apiKey + " could not be unlocked for reason: " + error);
		}
	}

	public bool GetAchievement(string apiKey)
	{
		Debug.Log("Trying to get achievement status for " + apiKey);
		bool unlocked = false;
		try
		{
			uint unlockTime = 0u;
			GalaxyInstance.Stats().GetAchievement(apiKey, ref unlocked, ref unlockTime);
			Debug.Log("Achievement: \"" + apiKey + "\" unlocked: " + unlocked.ToString() + " unlock time: " + unlockTime);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not get status of achievement " + apiKey + " for reason: " + error);
		}
		return unlocked;
	}

	public string GetAchievementName(string apiKey)
	{
		Debug.Log("Trying to get achievement name " + apiKey);
		string text = "";
		try
		{
			text = GalaxyInstance.Stats().GetAchievementDisplayName(apiKey);
			Debug.Log("Achievement display name: " + text);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not get name of achievement " + apiKey + " for reason: " + error);
		}
		return text;
	}

	public void SetStatFloat(string apiKey, float statValue)
	{
		Debug.Log("Setting stat " + apiKey);
		try
		{
			GalaxyInstance.Stats().SetStatFloat(apiKey, statValue);
			GalaxyInstance.Stats().StoreStatsAndAchievements();
			Debug.Log("Stat " + apiKey + " set to " + statValue);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not set value of statistic " + apiKey + " for reason: " + error);
		}
	}

	public void SetStatInt(string apiKey, int statValue)
	{
		Debug.Log("Setting stat " + apiKey);
		try
		{
			GalaxyInstance.Stats().SetStatInt(apiKey, statValue);
			GalaxyInstance.Stats().StoreStatsAndAchievements();
			Debug.Log("Stat " + apiKey + " set to " + statValue);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not set value of statistic " + apiKey + " for reason: " + error);
		}
	}

	public float GetStatFloat(string apiKey)
	{
		Debug.Log("Getting stat " + apiKey);
		float num = 0f;
		try
		{
			num = GalaxyInstance.Stats().GetStatFloat(apiKey);
			Debug.Log("Stat with key " + apiKey + " has value " + num);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not get value of statistic " + apiKey + " for reason: " + error);
		}
		return num;
	}

	public int GetStatInt(string apiKey)
	{
		Debug.Log("Getting stat " + apiKey);
		int num = 0;
		try
		{
			num = GalaxyInstance.Stats().GetStatInt(apiKey);
			Debug.Log("Stat with key " + apiKey + " has value " + num);
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not get value of statistic " + apiKey + " for reason: " + error);
		}
		return num;
	}

	public void ResetStatsAndAchievements()
	{
		if (!GogGalaxyManager.Instance.IsSignedIn(silent: true))
		{
			Debug.Log("ResetStatsAndAchievements | not signed in");
			return;
		}
		Debug.Log("Trying to reset user stats and achievements");
		try
		{
			GalaxyInstance.Stats().ResetStatsAndAchievements();
			Debug.Log("User stats and achievements reset");
		}
		catch (GalaxyInstance.Error error)
		{
			Debug.LogWarning("Could not get reset user stats and achievements for reason: " + error);
		}
	}
}
