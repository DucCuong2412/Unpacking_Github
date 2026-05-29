using System.Collections.Generic;

public class GameState
{
	public delegate void OnStateChanged(string stateName);

	private static Dictionary<string, string> stateMap = new Dictionary<string, string>();

	private static Dictionary<string, List<OnStateChanged>> listeners = new Dictionary<string, List<OnStateChanged>>();

	public static void Set(string name, string value)
	{
		stateMap.TryGetValue(name, out var value2);
		if (!(value2 != value))
		{
			return;
		}
		stateMap[name] = value;
		listeners.TryGetValue(name, out var value3);
		if (value3 == null)
		{
			return;
		}
		foreach (OnStateChanged item in value3)
		{
			item?.Invoke(name);
		}
	}

	public static string Get(string name)
	{
		stateMap.TryGetValue(name, out var value);
		return value;
	}

	public static void Remove(string name, bool removeListeners = false)
	{
		stateMap.Remove(name);
		if (removeListeners)
		{
			RemoveListeners(name);
		}
	}

	public static void AddListener(string name, OnStateChanged del)
	{
		if (!listeners.ContainsKey(name))
		{
			listeners[name] = new List<OnStateChanged>();
		}
		listeners[name].Add(del);
	}

	public static void RemoveListener(string name, OnStateChanged del)
	{
		listeners.TryGetValue(name, out var value);
		if (value != null && value.Remove(del) && value.Count == 0)
		{
			listeners.Remove(name);
		}
	}

	public static void RemoveListeners(string name)
	{
		listeners.Remove(name);
	}
}
