using UnityEngine;

namespace Console
{
	public class Preferences
	{
		public static bool IsInitialised => true;

		public static void Initialise()
		{
			Debug.Log("Initialising Preferences");
		}

		public static void Reinitialise()
		{
			Debug.Log("Reinitialising Preferences");
		}

		public static void Save()
		{
			PlayerPrefs.Save();
		}

		public static bool HasKey(string key)
		{
			return PlayerPrefs.HasKey(key);
		}

		public static void SetInt(string key, int value)
		{
			PlayerPrefs.SetInt(key, value);
		}

		public static void SetFloat(string key, float value)
		{
			PlayerPrefs.SetFloat(key, value);
		}

		public static void SetString(string key, string value)
		{
			PlayerPrefs.SetString(key, value);
		}

		public static int GetInt(string key, int defaultValue = 0)
		{
			return PlayerPrefs.GetInt(key, defaultValue);
		}

		public static float GetFloat(string key, float defaultValue = 0f)
		{
			return PlayerPrefs.GetFloat(key, defaultValue);
		}

		public static string GetString(string key, string defaultValue = "")
		{
			return PlayerPrefs.GetString(key, defaultValue);
		}

		public static void DeleteAll()
		{
			PlayerPrefs.DeleteAll();
		}

		public static void DeleteKey(string key)
		{
			PlayerPrefs.DeleteKey(key);
		}
	}
}
