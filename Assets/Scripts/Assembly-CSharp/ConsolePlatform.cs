using System;
using UnityEngine;

public class ConsolePlatform : MonoBehaviour
{
	public Action<bool> UserChanged;

	public Action PlatformInitialised;

	public virtual void Initialise()
	{
	}

	public virtual bool IsPlatformInitialised()
	{
		return true;
	}

	public virtual string GetCurrentUserName()
	{
		return "NO USER";
	}

	public virtual void GetCurrentUserImage(Action<Texture2D> completionCallback)
	{
	}

	public virtual bool IsUserSignedIn()
	{
		return true;
	}

	public virtual void SignInUser()
	{
	}

	public virtual void LoadData(string a_bufferName, Action<byte[]> a_dataLoadedCallback)
	{
	}

	public virtual void SaveData(string a_bufferName, byte[] a_data)
	{
	}

	public virtual void DeleteData(string a_bufferName)
	{
	}

	public virtual void DeleteAllData()
	{
	}

	public virtual bool SaveDataExists(string a_bufferName)
	{
		return false;
	}

	public virtual void UnlockAchievement(string a_achievementId, int a_progress, int a_target)
	{
	}

	public virtual void SetPresence(string location)
	{
	}

	public virtual void GetTextInput(string title, string subtitle, string @default, Action<string> callback)
	{
	}

	public virtual void TakeScreenShot()
	{
	}

	public virtual bool IsCapturingScreenShot()
	{
		return false;
	}
}
