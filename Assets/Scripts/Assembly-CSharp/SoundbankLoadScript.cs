using System;
using AK.Wwise;
using UnityEngine;

public class SoundbankLoadScript : MonoBehaviour
{
	public Bank m_soundbank = new Bank();

	private bool m_loaded;

	public bool loaded => m_loaded;

	private void Start()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		m_soundbank.LoadAsync(CallbackFunction);
	}

	private void CallbackFunction(uint in_bankID, IntPtr in_InMemoryBankPtr, AKRESULT in_eLoadResult, object in_Cookie)
	{
		m_loaded = true;
	}

	private void OnDestroy()
	{
		m_soundbank.Unload();
	}
}
