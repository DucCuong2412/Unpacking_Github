using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine;

public class saveData
{
	[Serializable]
	public class saveDataMain
	{
		private int m_ver;

		public int[] saves;

		public int resume;

		public bool[] stickers;

		public bool[] unlocks;

		public int ver => m_ver;

		public saveDataMain()
		{
			m_ver = 2;
			saves = new int[0];
			resume = -1;
			stickers = new bool[0];
			unlocks = new bool[0];
		}
	}

	public struct saveScrape
	{
		public string name;

		public int color;

		public int stageComplete;

		public int stageReached;

		public saveScrape(string _name, int _color, int _stageComplete, int _stageReached)
		{
			name = _name;
			color = _color;
			stageComplete = _stageComplete;
			stageReached = _stageReached;
		}

		public saveScrape(saveDataGame _save)
		{
			name = _save.name;
			color = _save.color;
			stageComplete = _save.stagesComplete;
			stageReached = GetLastStage(_save);
		}
	}

	[Serializable]
	public class saveDataGame
	{
		private int m_ver;

		public string name;

		public int color;

		public int stagesComplete;

		public bool[] unlocks;

		[SerializeField]
		public saveDataStage[] stages;

		[SerializeField]
		public saveDataStage tempStage;

		public int ver => m_ver;

		public saveDataGame()
		{
			m_ver = 2;
			name = "";
			color = 0;
			stagesComplete = 0;
			unlocks = new bool[0];
			stages = new saveDataStage[8];
			tempStage = default(saveDataStage);
		}

		public saveDataGame(string _name, int _color)
		{
			m_ver = 2;
			name = FormatName(_name);
			color = _color;
			stagesComplete = 0;
			unlocks = new bool[0];
			stages = new saveDataStage[8];
			tempStage = default(saveDataStage);
		}
	}

	[Serializable]
	public struct saveDataSnapshot
	{
		[SerializeField]
		public saveDataStage stage;

		[SerializeField]
		public saveDataItem[] items;

		public Vector2 itemOffset;

		public saveDataSnapshot(saveDataZone[] _zones, int _zone, int _x, int _y, int _tod, saveDataItem[] _items, Vector2 _itemOffset)
		{
			stage = new saveDataStage(1, _zone, _x, _y, _tod, _zones, new gameScript.historyEvent[0], new saveDataZone[0], new byte[0], "", "");
			items = _items;
			itemOffset = _itemOffset;
		}
	}

	[Serializable]
	public struct saveDataStage
	{
		public int state;

		public int zone;

		public int x;

		public int y;

		public int tod;

		[SerializeField]
		public saveDataZone[] zones;

		public gameScript.historyEvent[] history;

		public saveDataZone[] historyZones;

		public byte[] image;

		public string checksumZone;

		public string checksumItem;

		public saveDataStage(int _state, int _zone, int _x, int _y, int _tod, saveDataZone[] _zones, gameScript.historyEvent[] _history, saveDataZone[] _historyZones, byte[] _image, string _checksumZone, string _checksumItem)
		{
			state = _state;
			zone = _zone;
			x = _x;
			y = _y;
			tod = _tod;
			zones = _zones;
			history = _history;
			historyZones = _historyZones;
			image = _image;
			checksumZone = _checksumZone;
			checksumItem = _checksumItem;
		}
	}

	[Serializable]
	public struct saveDataZone
	{
		[Serializable]
		public struct saveDataDrawerManager
		{
			public bool[] drawer;

			public saveDataDrawerManager(bool[] _drawer)
			{
				drawer = _drawer;
			}
		}

		[SerializeField]
		public saveDataItem[] items;

		public saveDataBox[] boxes;

		public bool[] doorHinge;

		public bool[] doorSlide;

		public bool[] doorFold;

		public bool[] environmentMisc;

		[SerializeField]
		public saveDataDrawerManager[] drawerManager;

		public saveDataZone(saveDataItem[] _items, saveDataBox[] _boxes, bool[] _doorHinge, bool[] _doorSlide, bool[] _doorFold, saveDataDrawerManager[] _drawerManager, bool[] _environmentMisc)
		{
			items = _items;
			boxes = _boxes;
			doorHinge = _doorHinge;
			doorSlide = _doorSlide;
			doorFold = _doorFold;
			drawerManager = _drawerManager;
			environmentMisc = _environmentMisc;
		}
	}

	[Serializable]
	public struct saveDataItem
	{
		public int grid;

		public int stackOrder;

		public string type;

		public int variant;

		public bool movable;

		public int state;

		public int flatState;

		public int pinState;

		public int[] pinTypes;

		public int[] attachmentStates;

		public saveDataItem(int _grid, int _stackOrder, string _type, int _variant, bool _movable, int _state, int _flatState, int _pinState, int[] _pinTypes, int[] _attachmentStates)
		{
			grid = _grid;
			stackOrder = _stackOrder;
			type = _type;
			variant = _variant;
			movable = _movable;
			state = _state;
			flatState = _flatState;
			pinState = _pinState;
			pinTypes = _pinTypes;
			attachmentStates = _attachmentStates;
		}
	}

	[Serializable]
	public struct saveDataBox
	{
		public int next;

		public int contentArt;

		public saveDataBox(int _next, int _contentArt)
		{
			next = _next;
			contentArt = _contentArt;
		}
	}

	private const int c_ver = 2;

	private const int c_maxSaves = 5;

	private static int m_index = -1;

	private static saveDataMain m_main;

	private static saveDataGame m_data;

	private static saveScrape[] m_scrape;

	private static bool s_savesApplied = false;

	public static bool SaveActive => m_index > -1;

	public static int SaveCount
	{
		get
		{
			if (m_main != null)
			{
				return m_main.saves.Length;
			}
			return 0;
		}
	}

	public static int MaxSaves => 5;

	public static void Reset()
	{
		m_index = -1;
		m_main = null;
		m_data = null;
		m_scrape = null;
	}

	public static bool TempStageActive(int _stageIndex)
	{
		if (m_index > -1)
		{
			return m_data.stages[_stageIndex].state > 1;
		}
		return false;
	}

	public static bool TempStageExists(int _stageIndex)
	{
		if (m_index > -1)
		{
			return m_data.tempStage.state == _stageIndex + 1;
		}
		return false;
	}

	public static bool AlbumsExist()
	{
		if (m_main != null)
		{
			return m_main.saves.Length != 0;
		}
		return false;
	}

	public static bool SaveDataLoaded()
	{
		if (m_main != null)
		{
			return s_savesApplied;
		}
		return false;
	}

	public static bool UnsavedChanges(int _stageIndex)
	{
		if (m_index == -1 || m_data.tempStage.state != _stageIndex + 1)
		{
			return false;
		}
		for (int i = 0; i < m_data.stages[_stageIndex].zones.Length; i++)
		{
			if (m_data.stages[_stageIndex].zones[i].items.Length != m_data.tempStage.zones[i].items.Length)
			{
				return true;
			}
			saveDataItem[] items = m_data.stages[_stageIndex].zones[i].items;
			saveDataItem[] items2 = m_data.tempStage.zones[i].items;
			for (int j = 0; j < items.Length; j++)
			{
				bool flag = false;
				for (int k = 0; k < items2.Length; k++)
				{
					if (items[j].type == items2[k].type && items[j].variant == items2[k].variant && items[j].grid == items2[k].grid && items[j].state == items2[k].state && items[j].stackOrder == items2[k].stackOrder)
					{
						flag = true;
						break;
					}
				}
				if (!flag)
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool DarkStarValid(int _stageIndex = 8)
	{
		if (m_index == -1 || _stageIndex < 1)
		{
			return true;
		}
		for (int i = 0; i < _stageIndex; i++)
		{
			if (m_data.stages[i].state != 3)
			{
				return false;
			}
		}
		return true;
	}

	public static bool DarkStarClear()
	{
		if (m_index == -1)
		{
			return false;
		}
		return m_data.stagesComplete == 10;
	}

	public static void NewSave(string _name, int _color)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < m_main.saves.Length; i++)
		{
			list.Add(m_main.saves[i]);
		}
		int j;
		for (j = 0; list.Contains(j); j++)
		{
		}
		m_index = j;
		list.Insert(0, m_index);
		m_data = new saveDataGame(_name, _color);
		SaveAlbumToDisk();
		List<saveScrape> obj = ((m_scrape == null) ? new List<saveScrape>() : new List<saveScrape>(m_scrape));
		obj.Insert(0, new saveScrape(m_data));
		m_scrape = obj.ToArray();
		SaveMain(list.ToArray());
	}

	public static int CloneSave(string _name, int _color)
	{
		List<int> list = new List<int>(m_main.saves);
		int i;
		for (i = 0; list.Contains(i); i++)
		{
		}
		m_index = i;
		list.Insert(0, m_index);
		m_data.name = FormatName(_name);
		m_data.color = _color;
		SaveAlbumToDisk();
		List<saveScrape> list2 = new List<saveScrape>(m_scrape);
		list2.Insert(0, new saveScrape(m_data));
		m_scrape = list2.ToArray();
		SaveMain(list.ToArray());
		return m_index;
	}

	public static void LoadMain()
	{
		s_savesApplied = false;
		string text = Application.persistentDataPath + "/main.sav";
		if (File.Exists(text))
		{
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			FileStream fileStream = new FileStream(text, FileMode.Open);
			GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Decompress);
			try
			{
				m_main = binaryFormatter.Deserialize(gZipStream) as saveDataMain;
				gZipStream.Close();
				fileStream.Close();
				if (m_main.ver < 2)
				{
					Debug.LogWarning("old save, discarding");
					m_main = new saveDataMain();
					MatchGameSaves();
				}
				else
				{
					Debug.Log(text + " loaded successfully");
					MatchGameSaves();
				}
				return;
			}
			catch (Exception ex)
			{
				gZipStream.Close();
				fileStream.Close();
				Debug.LogWarning("LoadMain : " + ex.Message);
			}
		}
		else
		{
			Debug.LogWarning(text + " not found");
		}
		m_main = new saveDataMain();
		MatchGameSaves();
	}

	private static void MatchGameSaves()
	{
		List<int> list = new List<int>();
		Dictionary<int, saveScrape> dictionary = new Dictionary<int, saveScrape>();
		string[] files = Directory.GetFiles(Application.persistentDataPath, "save?.sav");
		foreach (string text in files)
		{
			if (!int.TryParse(text.Substring(text.Length - 5, 1), out var result))
			{
				continue;
			}
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			FileStream fileStream = new FileStream(text, FileMode.Open);
			GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Decompress);
			try
			{
				saveDataGame saveDataGame2 = binaryFormatter.Deserialize(gZipStream) as saveDataGame;
				gZipStream.Close();
				fileStream.Close();
				if (saveDataGame2.ver < 2)
				{
					Debug.LogWarning("old save, ignoring");
					continue;
				}
				list.Add(result);
				dictionary.Add(result, new saveScrape(saveDataGame2));
			}
			catch (Exception ex)
			{
				gZipStream.Close();
				fileStream.Close();
				Debug.LogWarning("MatchGameSaves : " + ex.Message);
			}
		}
		ApplySaves(list, dictionary);
	}

	private static void ApplySaves(List<int> foundSaves, Dictionary<int, saveScrape> scrapeSet)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < m_main.saves.Length; i++)
		{
			if (foundSaves.Contains(m_main.saves[i]))
			{
				list.Add(m_main.saves[i]);
			}
		}
		for (int j = 0; j < foundSaves.Count; j++)
		{
			if (!list.Contains(foundSaves[j]))
			{
				list.Add(foundSaves[j]);
			}
		}
		m_main.saves = list.ToArray();
		m_scrape = new saveScrape[m_main.saves.Length];
		for (int k = 0; k < m_main.saves.Length; k++)
		{
			m_scrape[k] = scrapeSet[m_main.saves[k]];
		}
		if (m_main.stickers == null)
		{
			m_main.stickers = new bool[0];
		}
		if (m_main.unlocks == null)
		{
			m_main.unlocks = new bool[0];
		}
		s_savesApplied = true;
	}

	private static bool SaveMain(int[] _saves)
	{
		if (m_main.saves.SequenceEqual(_saves))
		{
			return true;
		}
		m_main.saves = _saves;
		m_main.resume = -1;
		return SaveMainToDisk();
	}

	public static bool SetResume(int _currentStage)
	{
		return SaveMain(_currentStage);
	}

	public static bool ClearResume()
	{
		return SaveMain(-1);
	}

	public static bool HasStickers()
	{
		if (m_main.stickers != null)
		{
			return m_main.stickers.Length != 0;
		}
		return false;
	}

	public static bool StickerUnlocked(int _index)
	{
		if (m_main == null || m_main.stickers == null || m_main.stickers.Length <= _index)
		{
			return false;
		}
		return m_main.stickers[_index];
	}

	public static bool UnlockSticker(int _index)
	{
		if (m_main == null || m_main.stickers == null || (m_main.stickers.Length > _index && m_main.stickers[_index]))
		{
			return false;
		}
		if (m_main.stickers.Length <= _index)
		{
			bool[] array = new bool[_index + 1];
			m_main.stickers.CopyTo(array, 0);
			m_main.stickers = array;
		}
		m_main.stickers[_index] = true;
		return SaveMainToDisk();
	}

	public static bool UnlockSticker(int[] _indexes)
	{
		if (m_main == null || m_main.stickers == null)
		{
			return false;
		}
		bool flag = false;
		if (m_main.stickers.Length <= Mathf.Max(_indexes))
		{
			bool[] array = new bool[Mathf.Max(_indexes) + 1];
			m_main.stickers.CopyTo(array, 0);
			m_main.stickers = array;
			flag = true;
		}
		else
		{
			int[] array2 = _indexes;
			foreach (int num in array2)
			{
				flag |= !m_main.stickers[num];
			}
		}
		if (flag)
		{
			int[] array2 = _indexes;
			foreach (int num2 in array2)
			{
				m_main.stickers[num2] = true;
			}
			return SaveMainToDisk();
		}
		return false;
	}

	public static bool CheckMainUnlock(int _index)
	{
		if (m_main == null || m_main.unlocks == null || m_main.unlocks.Length <= _index)
		{
			return false;
		}
		return m_main.unlocks[_index];
	}

	public static bool SetMainUnlock(int _index)
	{
		if (m_main == null || (m_main.unlocks != null && m_main.unlocks.Length > _index && m_main.unlocks[_index]))
		{
			return false;
		}
		if (m_main.unlocks == null)
		{
			m_main.unlocks = new bool[_index + 1];
		}
		else if (m_main.unlocks.Length <= _index)
		{
			bool[] array = new bool[_index + 1];
			m_main.unlocks.CopyTo(array, 0);
			m_main.unlocks = array;
		}
		m_main.unlocks[_index] = true;
		return SaveMainToDisk();
	}

	public static bool CheckUnlock(int _index)
	{
		if (m_data == null || m_data.unlocks == null || m_data.unlocks.Length <= _index)
		{
			return false;
		}
		return m_data.unlocks[_index];
	}

	public static bool CheckUnlock(int[] _indexes)
	{
		if (m_data == null || m_data.unlocks == null || m_data.unlocks.Length <= Mathf.Max(_indexes))
		{
			return false;
		}
		for (int i = 0; i < _indexes.Length; i++)
		{
			if (!m_data.unlocks[_indexes[i]])
			{
				return false;
			}
		}
		return true;
	}

	public static bool SetUnlock(int _index, bool _value = true)
	{
		if (m_data == null || (m_data.unlocks != null && m_data.unlocks.Length > _index && m_data.unlocks[_index] == _value))
		{
			return false;
		}
		if (m_data.unlocks == null)
		{
			if (!_value)
			{
				return false;
			}
			m_data.unlocks = new bool[_index + 1];
		}
		else if (m_data.unlocks.Length <= _index)
		{
			if (!_value)
			{
				return false;
			}
			bool[] array = new bool[_index + 1];
			m_data.unlocks.CopyTo(array, 0);
			m_data.unlocks = array;
		}
		m_data.unlocks[_index] = _value;
		gameStateScript.SaveNeeded();
		return true;
	}

	private static bool SaveMain(int _resume)
	{
		if (m_main == null)
		{
			return false;
		}
		if (m_main.resume == _resume)
		{
			return true;
		}
		m_main.resume = _resume;
		return SaveMainToDisk();
	}

	public static bool SaveMainToDisk()
	{
		if (m_main == null)
		{
			return false;
		}
		string text = Application.persistentDataPath + "/main.sav";
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		FileStream fileStream = new FileStream(text, FileMode.Create);
		GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Compress);
		try
		{
			binaryFormatter.Serialize(gZipStream, m_main);
			gZipStream.Close();
			fileStream.Close();
			Debug.Log(text + " saved successfully");
			return true;
		}
		catch (Exception ex)
		{
			fileStream.Close();
			Debug.LogWarning("SaveMainToDisk : " + ex.Message);
		}
		return false;
	}

	public static bool SaveAlbumToDisk()
	{
		if (m_data == null)
		{
			return false;
		}
		string text = Application.persistentDataPath + "/save" + m_index + ".sav";
		BinaryFormatter binaryFormatter = new BinaryFormatter();
		FileStream fileStream = new FileStream(text, FileMode.Create);
		GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Compress);
		try
		{
			binaryFormatter.Serialize(gZipStream, m_data);
			gZipStream.Close();
			fileStream.Close();
			Debug.Log(text + " saved successfully");
			return true;
		}
		catch (Exception ex)
		{
			fileStream.Close();
			Debug.LogWarning("SaveAlbumToDisk : " + ex.Message);
		}
		return false;
	}

	public static bool LoadFirstSave()
	{
		if (m_main == null || m_main.saves.Length == 0)
		{
			return false;
		}
		return Load(m_main.saves[0]);
	}

	public static bool Load(int _index)
	{
		if (_index == m_index)
		{
			return true;
		}
		gameStateScript.DiskSaveNow();
		m_index = _index;
		m_data = null;
		string text = Application.persistentDataPath + "/save" + m_index + ".sav";
		if (File.Exists(text))
		{
			BinaryFormatter binaryFormatter = new BinaryFormatter();
			FileStream fileStream = new FileStream(text, FileMode.Open);
			GZipStream gZipStream = new GZipStream(fileStream, CompressionMode.Decompress);
			try
			{
				m_data = binaryFormatter.Deserialize(gZipStream) as saveDataGame;
				gZipStream.Close();
				fileStream.Close();
				Debug.Log(text + " loaded successfully");
			}
			catch (Exception ex)
			{
				gZipStream.Close();
				fileStream.Close();
				Debug.LogWarning("Load : " + ex.Message);
			}
		}
		else
		{
			Debug.LogWarning(text + " not found");
		}
		if (m_data == null)
		{
			m_data = new saveDataGame();
			return false;
		}
		m_data.name = FormatName(m_data.name);
		return SyncScrape();
	}

	private static bool SyncScrape()
	{
		if (m_main.saves[0] != m_index)
		{
			List<int> list = new List<int>();
			List<saveScrape> list2 = new List<saveScrape>();
			list.Add(m_index);
			list2.Add(new saveScrape(m_data));
			for (int i = 0; i < m_main.saves.Length; i++)
			{
				if (!list.Contains(m_main.saves[i]))
				{
					list.Add(m_main.saves[i]);
					list2.Add(m_scrape[i]);
				}
			}
			m_scrape = list2.ToArray();
			return SaveMain(list.ToArray());
		}
		return true;
	}

	private static string FormatName(string _name)
	{
		if (_name.Length < 32)
		{
			return _name;
		}
		return _name.Substring(0, 32);
	}

	public static void Save(string _name)
	{
		m_data.name = FormatName(_name);
		m_scrape[0] = new saveScrape(m_data);
		gameStateScript.SaveNeeded();
	}

	public static bool SaveComplete(bool _darkstar)
	{
		if (m_index == -1 || m_data == null || m_data.stagesComplete != 8)
		{
			return false;
		}
		m_data.stagesComplete = (_darkstar ? 10 : 9);
		m_scrape[0] = new saveScrape(m_data);
		return SaveAlbumToDisk();
	}

	public static void Save(saveDataStage _stage, int _stageIndex, bool _complete)
	{
		if (m_index != -1 && m_data != null)
		{
			m_data.stages[_stageIndex] = _stage;
			if (_complete)
			{
				m_data.stagesComplete = Mathf.Max(m_data.stagesComplete, _stageIndex + 1);
				m_data.tempStage = default(saveDataStage);
			}
			m_scrape[0] = new saveScrape(m_data);
			gameStateScript.SaveNeeded();
		}
	}

	public static void SaveTemp(saveDataStage _stage)
	{
		if (m_data != null)
		{
			m_data.tempStage = _stage;
			gameStateScript.SaveNeeded();
		}
	}

	public static bool DiscardTemp()
	{
		if (m_data == null)
		{
			return false;
		}
		if (m_data.tempStage.state > 0)
		{
			Debug.Log("Deleting Temp Stage " + m_data.tempStage.state);
			m_data.tempStage = default(saveDataStage);
			Debug.Log("Temp Stage is now " + m_data.tempStage.state);
			gameStateScript.SaveNeeded();
			return true;
		}
		return false;
	}

	public static int RemoveMissingSave(int _index)
	{
		int color = m_scrape[_index].color;
		List<int> list = new List<int>(m_main.saves);
		List<saveScrape> list2 = new List<saveScrape>(m_scrape);
		list.RemoveAt(_index);
		list2.RemoveAt(_index);
		SaveMain(list.ToArray());
		m_scrape = list2.ToArray();
		return color;
	}

	public static bool Delete()
	{
		string path = Application.persistentDataPath + "/save" + m_index + ".sav";
		if (File.Exists(path))
		{
			File.Delete(path);
			List<int> list = new List<int>();
			List<saveScrape> list2 = new List<saveScrape>();
			for (int i = 0; i < m_main.saves.Length; i++)
			{
				if (m_main.saves[i] != m_index)
				{
					list.Add(m_main.saves[i]);
					list2.Add(m_scrape[i]);
				}
			}
			m_scrape = list2.ToArray();
			SaveMain(list.ToArray());
			m_index = -1;
			m_data = null;
			return true;
		}
		return false;
	}

	public static bool DeleteAllData()
	{
		for (int i = 0; i < m_main.saves.Length; i++)
		{
			string text = Application.persistentDataPath + "/save" + i + ".sav";
			if (File.Exists(text))
			{
				Debug.Log("deleting " + text);
				File.Delete(text);
			}
		}
		string text2 = Application.persistentDataPath + "/main.sav";
		if (File.Exists(text2))
		{
			Debug.Log("deleting " + text2);
			File.Delete(text2);
		}
		m_index = -1;
		m_data = null;
		m_main = new saveDataMain();
		m_scrape = new saveScrape[0];
		LoadMain();
		m_index = -1;
		m_data = null;
		return false;
	}

	public static saveScrape[] LoadScrape()
	{
		if (m_main.saves.Length == 0)
		{
			return new saveScrape[0];
		}
		return m_scrape;
	}

	public static saveScrape GetAlbumInfo()
	{
		return new saveScrape(m_data.name, m_data.color, m_data.stagesComplete, GetLastStage());
	}

	public static int GetAlbumColor()
	{
		if (m_data != null)
		{
			return m_data.color;
		}
		return 0;
	}

	public static bool CheckStageComplete(int _stageIndex)
	{
		if (m_data != null && m_data.stages[_stageIndex].state > 1)
		{
			return true;
		}
		return false;
	}

	public static saveDataStage GetStage(int _stageIndex)
	{
		return m_data.stages[_stageIndex];
	}

	public static int GetLastStage()
	{
		return GetLastStage(m_data);
	}

	private static int GetLastStage(saveDataGame _data)
	{
		if (_data == null)
		{
			return -1;
		}
		for (int i = 0; i < _data.stages.Length; i++)
		{
			if (_data.stages[i].state == 0)
			{
				return i - 1;
			}
		}
		return _data.stages.Length - 1;
	}

	public static int GetFirstUnfinishedStage()
	{
		if (m_data == null)
		{
			return -1;
		}
		for (int i = 0; i < m_data.stages.Length; i++)
		{
			if (m_data.stages[i].state < 2)
			{
				return i;
			}
		}
		return -1;
	}

	public static saveDataStage GetTempStage()
	{
		return m_data.tempStage;
	}

	public static bool GetStageInProgress(int _stageIndex)
	{
		if (m_data != null && m_data.stages.Length > _stageIndex && m_data.stages[_stageIndex].zones != null)
		{
			return m_data.stages[_stageIndex].zones.Length != 0;
		}
		return false;
	}

	public static bool CompareChecksums(int _stageIndex, string _checksumZone, string _checksumItem, bool _strict)
	{
		if (string.IsNullOrEmpty(_checksumZone) || string.IsNullOrEmpty(_checksumItem) || m_data == null || m_data.stages.Length <= _stageIndex)
		{
			return true;
		}
		if (m_data.stages[_stageIndex].checksumZone != _checksumZone)
		{
			Debug.LogWarning("stage " + _stageIndex + " checksumZone mismatch\nzone : " + _checksumZone + "\nsave : " + m_data.stages[_stageIndex].checksumZone);
			return false;
		}
		bool flag = false;
		if (!_strict)
		{
			for (int i = 0; i < m_data.stages[_stageIndex].zones.Length; i++)
			{
				for (int j = 0; j < m_data.stages[_stageIndex].zones[i].boxes.Length; j++)
				{
					if (m_data.stages[_stageIndex].zones[i].boxes[j].next != -1)
					{
						flag = true;
						break;
					}
				}
				if (flag)
				{
					break;
				}
			}
		}
		if ((_strict || flag) && m_data.stages[_stageIndex].checksumItem != _checksumItem)
		{
			Debug.LogWarning("stage " + _stageIndex + " checksumItem mismatch\nitem : " + _checksumItem + "\nsave : " + m_data.stages[_stageIndex].checksumItem);
			return false;
		}
		return true;
	}

	public static int GetResume()
	{
		return m_main.resume;
	}

	public static bool CheckResume()
	{
		if (m_main == null)
		{
			return false;
		}
		if (m_main.saves.Length == 0)
		{
			return false;
		}
		if (m_main.resume > -1)
		{
			return true;
		}
		if (Load(m_main.saves[0]))
		{
			if (m_data.stagesComplete < 9)
			{
				return true;
			}
			for (int i = 0; i < m_data.stages.Length; i++)
			{
				if (m_data.stages[i].state < 2)
				{
					return true;
				}
			}
		}
		return false;
	}

	public static int GetFileIndex(int _index)
	{
		return m_main.saves[_index];
	}
}
