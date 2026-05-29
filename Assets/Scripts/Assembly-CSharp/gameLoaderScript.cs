using System.Collections.Generic;
using UnityEngine;

public class gameLoaderScript : MonoBehaviour
{
	public Transform[] m_load;

	public Transform[] m_reload;

	public Transform m_mainSoundbank;

	private static List<GameObject> s_reloadableObjects;

	private static bool s_init;

	private static bool s_reload;

	private void Awake()
	{
		if (!s_init)
		{
			for (int i = 0; i < m_load.Length; i++)
			{
				Object.DontDestroyOnLoad(Object.Instantiate(m_load[i]).gameObject);
			}
			s_init = true;
		}
		if (!s_reload)
		{
			if (s_reloadableObjects == null)
			{
				s_reloadableObjects = new List<GameObject>();
			}
			for (int j = 0; j < m_reload.Length; j++)
			{
				GameObject gameObject = Object.Instantiate(m_reload[j]).gameObject;
				s_reloadableObjects.Add(gameObject);
				Object.DontDestroyOnLoad(gameObject);
			}
			s_reload = true;
		}
	}

	public static void ResetLoader()
	{
		s_reload = false;
		ClearLoadedObjects();
	}

	private static void ClearLoadedObjects()
	{
		if (s_reloadableObjects == null)
		{
			return;
		}
		foreach (GameObject s_reloadableObject in s_reloadableObjects)
		{
			Object.Destroy(s_reloadableObject);
		}
		s_reloadableObjects.Clear();
	}
}
