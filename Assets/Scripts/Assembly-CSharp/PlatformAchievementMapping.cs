using System;

[Serializable]
public class PlatformAchievementMapping
{
	public string AchievementString;

	public string PlatformID;

	public PlatformAchievementMapping()
	{
	}

	public PlatformAchievementMapping(string a_achievementString, string a_platformId)
	{
		AchievementString = a_achievementString;
		PlatformID = a_platformId;
	}

	public int GetIDAsInt()
	{
		int result = -1;
		int.TryParse(PlatformID, out result);
		return result;
	}
}
