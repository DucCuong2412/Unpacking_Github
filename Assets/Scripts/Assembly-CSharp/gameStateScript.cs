using System;
using System.Collections.Generic;
using System.IO;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class gameStateScript : MonoBehaviour
{
	[Serializable]
	public class fontSet
	{
		public string m_name;

		public TMP_FontAsset m_font18;

		public TMP_FontAsset m_font32;

		public TMP_FontAsset m_fontOutline;

		public TMP_FontAsset m_font35;

		public TMP_FontAsset m_font18alt;

		public languageData.languageId[] m_languages;
	}

	private enum fadeState
	{
		none = 0,
		loading = 1,
		fadeInOnly = 2,
		fadeIn = 3,
		fadeOut = 4
	}

	public enum albumLoadState
	{
		none = 0,
		game = 1,
		complete = 2,
		saveError = 3
	}

	public enum accessSetting
	{
		zonefade = 0,
		iconsize = 1,
		placementhints = 2,
		itemsanywhere = 3,
		inputcooldown = 4,
		invalidhighlight = 5
	}

	private const float c_saveDelay = 5f;

	private const float c_saveDelayMin = 1f;

	public languageData.languageId m_language;

	private Dictionary<string, string> m_strings;

	private string[] m_languageNames;

	public fontSet[] m_fontSet;

	private int m_fontSetCurrent;

	public Color[] m_validationColors;

	public GameObject m_loadScreen;

	public Image m_loadBackground;

	private fadeState m_fade;

	private float m_fadeLerp;

	private float m_fadeRate = 1f;

	public uiCursor m_cursor;

	public controlPromptScript m_controlPrompt;

	public stickerData m_stickerData;

	private bool m_saveNeeded;

	private float m_saveTimer;

	private bool m_prefSaveNeeded;

	private static gameStateScript s_instance;

	private bool m_fromStage;

	private bool m_loadStage;

	private int m_playbackStage;

	private Sprite m_stickerUnlock;

	private bool m_quickTitleReturn;

	private albumLoadState m_albumLoad;

	private int m_albumPage;

	private const int m_tutorialTurnUnlock = 6;

	private const int m_tutorialZoneChangeUnlock = 7;

	private const int m_tutorialFloorplanUnlock = 8;

	private const int m_albumFirstClearUnlock = 9;

	private const int m_tutorialPlaybackUnlock = 10;

	private const int m_stateGameClear = 0;

	private const int m_stateGameClearNotify = 1;

	private bool m_pulseAnimate = true;

	public checksumData m_checksums;

	private static bool s_fullscreenExclusive;

	private AsyncOperation m_sceneLoad;

	public static bool fullscreenExclusive => s_fullscreenExclusive;

	public static languageData.languageId language
	{
		get
		{
			return s_instance.m_language;
		}
		set
		{
			s_instance.ChangeLanguage(value);
		}
	}

	protected bool fromStage
	{
		get
		{
			return m_fromStage;
		}
		set
		{
			m_fromStage = value;
		}
	}

	protected bool loadStage
	{
		get
		{
			return m_loadStage;
		}
		set
		{
			m_loadStage = value;
		}
	}

	protected int playbackStage
	{
		get
		{
			return m_playbackStage;
		}
		set
		{
			m_playbackStage = value;
		}
	}

	protected Sprite stickerUnlock
	{
		get
		{
			return m_stickerUnlock;
		}
		set
		{
			m_stickerUnlock = value;
		}
	}

	protected bool quickTitleReturn
	{
		get
		{
			return m_quickTitleReturn;
		}
		set
		{
			m_quickTitleReturn = value;
		}
	}

	public static int albumPage
	{
		get
		{
			return s_instance.m_albumPage;
		}
		set
		{
			s_instance.m_albumPage = value;
		}
	}

	protected albumLoadState albumLoad
	{
		get
		{
			return m_albumLoad;
		}
		set
		{
			m_albumLoad = value;
		}
	}

	public static bool tutorialTurn
	{
		get
		{
			return saveData.CheckUnlock(6);
		}
		set
		{
			saveData.SetUnlock(6, value);
		}
	}

	public static bool tutorialZoneChange
	{
		get
		{
			return saveData.CheckUnlock(7);
		}
		set
		{
			saveData.SetUnlock(7, value);
		}
	}

	public static bool tutorialFloorplan
	{
		get
		{
			return saveData.CheckUnlock(8);
		}
		set
		{
			saveData.SetUnlock(8, value);
		}
	}

	public static bool albumFirstClear
	{
		get
		{
			return saveData.CheckUnlock(9);
		}
		set
		{
			saveData.SetUnlock(9, value);
		}
	}

	public static bool tutorialPlayback
	{
		get
		{
			return saveData.CheckUnlock(10);
		}
		set
		{
			saveData.SetUnlock(10, value);
		}
	}

	public static int playbackSpeed
	{
		get
		{
			return PlayerPrefs.GetInt("playback_speed", 2);
		}
		set
		{
			PlayerPrefs.SetInt("playback_speed", value);
		}
	}

	public static bool AudioShuffle
	{
		get
		{
			return PlayerPrefs.GetInt("audio_shuffle", 0) > 0;
		}
		set
		{
			if (!value)
			{
				PlayerPrefs.DeleteKey("audio_shuffle");
			}
			else
			{
				PlayerPrefs.SetInt("audio_shuffle", 1);
			}
			PrefSaveDirty();
		}
	}

	public static bool ConstrainCursor
	{
		get
		{
			return PlayerPrefs.GetInt("cursor_constrain", 1) > 0;
		}
		set
		{
			PlayerPrefs.SetInt("cursor_constrain", value ? 1 : 0);
			Debug.Log("setting constraincursor to " + value.ToString() + " | player prefs is now " + PlayerPrefs.GetInt("cursor_constrain", 1));
			PrefSaveDirty();
			s_instance.m_cursor.confineInGame = value;
		}
	}

	public static bool PulseAnimate
	{
		get
		{
			return s_instance.m_pulseAnimate;
		}
		set
		{
			s_instance.m_pulseAnimate = value;
		}
	}

	public static bool CompareChecksums(int _stage, bool _strict = false)
	{
		if (saveData.CompareChecksums(_stage, s_instance.m_checksums.zone(_stage), s_instance.m_checksums.item(_stage), _strict))
		{
			return true;
		}
		string[] array = s_instance.m_checksums.zoneOverride(_stage);
		for (int i = 0; i < array.Length; i++)
		{
			if (saveData.CompareChecksums(_stage, array[i], s_instance.m_checksums.item(_stage), _strict))
			{
				return true;
			}
		}
		return false;
	}

	public static string GetChecksumZone(int _stage)
	{
		return s_instance.m_checksums.zone(_stage);
	}

	public static string GetChecksumItem(int _stage)
	{
		return s_instance.m_checksums.item(_stage);
	}

	private void Awake()
	{
		s_instance = this;
		string[] commandLineArgs = Environment.GetCommandLineArgs();
		foreach (string text in commandLineArgs)
		{
			if (text.ToLower().EndsWith("exclusive"))
			{
				s_fullscreenExclusive = true;
			}
			else if (text.ToLower().EndsWith("nopulse"))
			{
				m_pulseAnimate = false;
			}
			else if (text.ToLower().EndsWith("resetcontrols"))
			{
				inputHandler.Instance.RevertToDefaultBindings(currentSchemeOnly: false);
			}
		}
	}

	private void Start()
	{
		if (UnityEngine.Object.FindObjectOfType<GogGalaxyManager>() == null)
		{
			base.gameObject.AddComponent<GogGalaxyManager>();
		}
		languageData.languageId systemLanguage = GetSystemLanguage();
		if (PlayerPrefs.GetInt("systemLanguage", (int)systemLanguage) != (int)systemLanguage)
		{
			PlayerPrefs.DeleteKey("language");
		}
		PlayerPrefs.SetInt("systemLanguage", (int)systemLanguage);
		m_language = (languageData.languageId)PlayerPrefs.GetInt("language", (int)systemLanguage);
		GetLanguageNames();
		LoadStrings(m_language);
		AkSoundEngine.SetRTPCValue("volume_master", PlayerPrefs.GetFloat("volume_master", 1f));
		AkSoundEngine.SetRTPCValue("volume_sfx", PlayerPrefs.GetFloat("volume_sfx", 1f));
		AkSoundEngine.SetRTPCValue("volume_music", PlayerPrefs.GetFloat("volume_music", 1f));
		AkSoundEngine.SetRTPCValue("volume_controller", PlayerPrefs.GetFloat("volume_controller", 1f));
		AkSoundEngine.SetState("Recording_State", "False");
		inputHandler.Instance.RegisterCursor(m_cursor);
		m_cursor.confineInGame = ConstrainCursor;
		base.gameObject.AddComponent<statsScript>();
		saveData.LoadMain();
	}

	private languageData.languageId GetSystemLanguage()
	{
		string currentGameLanguage = GogGalaxyManager.Instance.GetCurrentGameLanguage();
		if (!string.IsNullOrEmpty(currentGameLanguage))
		{
			switch (currentGameLanguage)
			{
			case "german":
				return languageData.languageId.de_DE;
			case "latam":
				return languageData.languageId.es_LATAM;
			case "french":
				return languageData.languageId.fr_FR;
			case "japanese":
				return languageData.languageId.ja_JP;
			case "koreana":
				return languageData.languageId.ko_KR;
			case "polish":
				return languageData.languageId.pl_PL;
			case "brazilian":
				return languageData.languageId.pt_BR;
			case "russian":
				return languageData.languageId.ru_RU;
			case "schinese":
				return languageData.languageId.zh_CN;
			case "tchinese":
				return languageData.languageId.zh_TW;
			case "filipino":
				return languageData.languageId.fil_PH;
			case "indonesian":
				return languageData.languageId.id_ID;
			case "italian":
				return languageData.languageId.it_IT;
			case "malay":
				return languageData.languageId.ms_MY;
			case "turkish":
				return languageData.languageId.tr_TR;
			default:
				return languageData.languageId.en_US;
			}
		}
		switch (Application.systemLanguage)
		{
		case SystemLanguage.German:
			return languageData.languageId.de_DE;
		case SystemLanguage.Spanish:
			return languageData.languageId.es_LATAM;
		case SystemLanguage.French:
			return languageData.languageId.fr_FR;
		case SystemLanguage.Japanese:
			return languageData.languageId.ja_JP;
		case SystemLanguage.Korean:
			return languageData.languageId.ko_KR;
		case SystemLanguage.Polish:
			return languageData.languageId.pl_PL;
		case SystemLanguage.Portuguese:
			return languageData.languageId.pt_BR;
		case SystemLanguage.Russian:
			return languageData.languageId.ru_RU;
		case SystemLanguage.ChineseSimplified:
			return languageData.languageId.zh_CN;
		case SystemLanguage.ChineseTraditional:
			return languageData.languageId.zh_TW;
		case SystemLanguage.Indonesian:
			return languageData.languageId.id_ID;
		case SystemLanguage.Italian:
			return languageData.languageId.it_IT;
		case SystemLanguage.Turkish:
			return languageData.languageId.tr_TR;
		default:
			return languageData.languageId.en_US;
		}
	}

	private void GetLanguageNames()
	{
		string[] names = Enum.GetNames(typeof(languageData.languageId));
		m_languageNames = new string[names.Length];
		for (int i = 0; i < names.Length; i++)
		{
			languageData languageData2 = Resources.Load<languageData>(names[i]);
			if (languageData2 != null && languageData2.stringList != null)
			{
				for (int j = 0; j < languageData2.stringList.Length; j++)
				{
					if (languageData2.stringList[j].id.Equals("language"))
					{
						m_languageNames[i] = languageData2.stringList[j].text;
						break;
					}
				}
			}
			Resources.UnloadAsset(languageData2);
			if (string.IsNullOrEmpty(m_languageNames[i]))
			{
				m_languageNames[i] = "[" + names[i] + "]";
			}
		}
	}

	private void LoadStrings(languageData.languageId _language)
	{
		languageData languageData2 = Resources.Load<languageData>(_language.ToString());
		m_strings = new Dictionary<string, string>();
		if (languageData2 != null && languageData2.stringList != null)
		{
			for (int i = 0; i < languageData2.stringList.Length; i++)
			{
				m_strings.Add(languageData2.stringList[i].id, languageData2.stringList[i].text);
			}
		}
		Resources.UnloadAsset(languageData2);
		languageData2 = Resources.Load<languageData>("en_US");
		if (languageData2 != null && languageData2.stringList != null)
		{
			for (int j = 0; j < languageData2.stringList.Length; j++)
			{
				if (!m_strings.ContainsKey(languageData2.stringList[j].id))
				{
					m_strings.Add(languageData2.stringList[j].id, languageData2.stringList[j].text);
				}
			}
		}
		Resources.UnloadAsset(languageData2);
		for (int k = 0; k < m_fontSet.Length; k++)
		{
			for (int l = 0; l < m_fontSet[k].m_languages.Length; l++)
			{
				if (m_fontSet[k].m_languages[l].Equals(_language))
				{
					m_fontSetCurrent = k;
					Debug.Log("language is " + _language.ToString() + " choosing " + m_fontSetCurrent + " (" + m_fontSet[m_fontSetCurrent].m_name + ")");
					return;
				}
			}
		}
	}

	private void ChangeLanguage(languageData.languageId _language, bool _savePref = true)
	{
		m_language = _language;
		if (_savePref)
		{
			PlayerPrefs.SetInt("language", (int)m_language);
		}
		LoadStrings(m_language);
		GameObject[] rootGameObjects = SceneManager.GetActiveScene().GetRootGameObjects();
		for (int i = 0; i < rootGameObjects.Length; i++)
		{
			stringIdScript[] componentsInChildren = rootGameObjects[i].GetComponentsInChildren<stringIdScript>(includeInactive: true);
			for (int j = 0; j < componentsInChildren.Length; j++)
			{
				componentsInChildren[j].SetStyle();
				componentsInChildren[j].SetString();
			}
			locArtScript[] componentsInChildren2 = rootGameObjects[i].GetComponentsInChildren<locArtScript>(includeInactive: true);
			for (int k = 0; k < componentsInChildren2.Length; k++)
			{
				componentsInChildren2[k].Set();
			}
		}
	}

	public static string GetString(string _id)
	{
		if (!s_instance.m_strings.ContainsKey(_id))
		{
			return "[" + _id + "]";
		}
		return s_instance.m_strings[_id].Replace("\\n", "\n");
	}

	private TMP_FontAsset GetFontFromStyle(stringIdScript.fontStyle _style)
	{
		switch (_style)
		{
		case stringIdScript.fontStyle.small:
			return m_fontSet[m_fontSetCurrent].m_font18;
		case stringIdScript.fontStyle.large:
			return m_fontSet[m_fontSetCurrent].m_font32;
		case stringIdScript.fontStyle.outline:
			return m_fontSet[m_fontSetCurrent].m_fontOutline;
		case stringIdScript.fontStyle.cover:
			return m_fontSet[m_fontSetCurrent].m_font35;
		case stringIdScript.fontStyle.smallAlt:
			return m_fontSet[m_fontSetCurrent].m_font18alt;
		default:
			return null;
		}
	}

	public static TMP_FontAsset GetFont(stringIdScript.fontStyle _style)
	{
		return s_instance.GetFontFromStyle(_style);
	}

	public static TMP_FontAsset GetFont(stringIdScript.fontStyle _style, languageData.languageId _language)
	{
		for (int i = 0; i < s_instance.m_fontSet.Length; i++)
		{
			for (int j = 0; j < s_instance.m_fontSet[i].m_languages.Length; j++)
			{
				if (s_instance.m_fontSet[i].m_languages[j].Equals(_language))
				{
					switch (_style)
					{
					case stringIdScript.fontStyle.small:
						return s_instance.m_fontSet[i].m_font18;
					case stringIdScript.fontStyle.large:
						return s_instance.m_fontSet[i].m_font32;
					case stringIdScript.fontStyle.outline:
						return s_instance.m_fontSet[i].m_fontOutline;
					case stringIdScript.fontStyle.cover:
						return s_instance.m_fontSet[i].m_font35;
					case stringIdScript.fontStyle.smallAlt:
						return s_instance.m_fontSet[i].m_font18alt;
					}
				}
			}
		}
		return null;
	}

	public static string GetLanguageName(int _language)
	{
		return s_instance.m_languageNames[_language];
	}

	public static int GetValidationColorCount()
	{
		return s_instance.m_validationColors.Length;
	}

	public static Color GetValidationColor()
	{
		return s_instance.m_validationColors[GetAccessSetting(accessSetting.invalidhighlight)];
	}

	public static Color GetValidationColor(int _index)
	{
		return s_instance.m_validationColors[_index];
	}

	public static void SetPathScreenshot(string _path = "")
	{
		if (string.IsNullOrEmpty(_path))
		{
			PlayerPrefs.DeleteKey("pathScreenshot");
			return;
		}
		if (!_path[_path.Length - 1].Equals(Path.DirectorySeparatorChar))
		{
			_path += Path.DirectorySeparatorChar;
		}
		PlayerPrefs.SetString("pathScreenshot", _path);
	}

	public static void SetPathVideo(string _path = "")
	{
		if (string.IsNullOrEmpty(_path))
		{
			PlayerPrefs.DeleteKey("pathVideo");
			return;
		}
		if (!_path[_path.Length - 1].Equals(Path.DirectorySeparatorChar))
		{
			_path += Path.DirectorySeparatorChar;
		}
		PlayerPrefs.SetString("pathVideo", _path);
	}

	public static void SetPathGif(string _path = "")
	{
		if (string.IsNullOrEmpty(_path))
		{
			PlayerPrefs.DeleteKey("pathGif");
			return;
		}
		if (!_path[_path.Length - 1].Equals(Path.DirectorySeparatorChar))
		{
			_path += Path.DirectorySeparatorChar;
		}
		PlayerPrefs.SetString("pathGif", _path);
	}

	public static string GetPathScreenshot()
	{
		string text = PlayerPrefs.GetString("pathScreenshot", "");
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		return Environment.GetFolderPath(Environment.SpecialFolder.MyPictures) + Path.DirectorySeparatorChar + "Unpacking" + Path.DirectorySeparatorChar;
	}

	public static string GetPathVideo()
	{
		string text = PlayerPrefs.GetString("pathVideo", "");
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		return Environment.GetFolderPath(Environment.SpecialFolder.MyVideos) + Path.DirectorySeparatorChar + "Unpacking" + Path.DirectorySeparatorChar;
	}

	public static string GetPathGif()
	{
		string text = PlayerPrefs.GetString("pathGif", "");
		if (!string.IsNullOrEmpty(text))
		{
			return text;
		}
		return Environment.GetFolderPath(Environment.SpecialFolder.MyPictures) + Path.DirectorySeparatorChar + "Unpacking" + Path.DirectorySeparatorChar + "gifs" + Path.DirectorySeparatorChar;
	}

	private void Update()
	{
		if (m_fade == fadeState.fadeIn || m_fade == fadeState.fadeInOnly)
		{
			m_fadeLerp += Time.deltaTime * m_fadeRate;
			m_loadScreen.GetComponent<CanvasGroup>().alpha = m_fadeLerp;
			if (m_fadeLerp >= 1f)
			{
				m_fadeLerp = 1f;
				m_fade = ((m_fade == fadeState.fadeIn) ? fadeState.loading : fadeState.none);
				SceneLoadAdvance();
			}
		}
		else if (m_fade == fadeState.fadeOut)
		{
			m_fadeLerp -= Time.deltaTime * m_fadeRate;
			m_loadScreen.GetComponent<CanvasGroup>().alpha = m_fadeLerp;
			if (m_fadeLerp <= 0f)
			{
				m_fade = fadeState.none;
				m_loadScreen.SetActive(value: false);
			}
		}
		if (m_saveNeeded)
		{
			m_saveTimer += Time.deltaTime;
			if (m_saveTimer > 5f)
			{
				m_saveTimer = 0f;
				m_saveNeeded = false;
				saveData.SaveAlbumToDisk();
			}
		}
	}

	private void OnApplicationQuit()
	{
		DiskSaveNow();
	}

	public static void SetFromStage()
	{
		s_instance.fromStage = true;
	}

	public static bool IsFromStage()
	{
		bool result = s_instance.fromStage;
		s_instance.fromStage = false;
		return result;
	}

	public static void SetLoadStage()
	{
		s_instance.loadStage = true;
	}

	public static bool IsLoadStage()
	{
		bool result = s_instance.loadStage;
		s_instance.loadStage = false;
		return result;
	}

	public static void SetPlaybackStage(int _value)
	{
		s_instance.playbackStage = _value;
	}

	public static int IsPlaybackStage()
	{
		int result = s_instance.playbackStage;
		s_instance.playbackStage = 0;
		return result;
	}

	public static void SetStickerUnlock(Sprite _sticker)
	{
		s_instance.stickerUnlock = _sticker;
	}

	public static Sprite GetStickerUnlock()
	{
		Sprite result = s_instance.stickerUnlock;
		s_instance.stickerUnlock = null;
		return result;
	}

	public static void SetQuickTitleReturn()
	{
		s_instance.quickTitleReturn = true;
	}

	public static bool IsQuickTitleReturn()
	{
		bool result = s_instance.quickTitleReturn;
		s_instance.quickTitleReturn = false;
		return result;
	}

	public static void SetAlbumLoadGame()
	{
		s_instance.albumLoad = albumLoadState.game;
	}

	public static void SetAlbumSaveError()
	{
		s_instance.albumLoad = albumLoadState.saveError;
	}

	public static void SetAlbumLoadComplete()
	{
		s_instance.albumLoad = albumLoadState.complete;
	}

	public static bool CheckAlbumLoad()
	{
		return s_instance.albumLoad == albumLoadState.game;
	}

	public static albumLoadState GetAlbumLoad()
	{
		albumLoadState result = s_instance.albumLoad;
		s_instance.albumLoad = albumLoadState.none;
		return result;
	}

	public static void ResetTutorials()
	{
		saveData.SetUnlock(6, _value: false);
		saveData.SetUnlock(7, _value: false);
		saveData.SetUnlock(8, _value: false);
		saveData.SetUnlock(10, _value: false);
	}

	public static void ResetGameClear()
	{
	}

	public static bool GameClear()
	{
		return saveData.CheckMainUnlock(0);
	}

	public static bool SetGameClear()
	{
		return saveData.SetMainUnlock(0);
	}

	public static bool ShowGameClearNotify()
	{
		if (!saveData.CheckMainUnlock(1) && saveData.CheckMainUnlock(0))
		{
			saveData.SetMainUnlock(1);
			return true;
		}
		return false;
	}

	protected void SceneLoad(string _sceneName, bool _instant, bool _black)
	{
		if (m_sceneLoad == null)
		{ 
			m_loadBackground.color = (_black ? Color.black : Color.white);
			Debug.Log("scene load: " + _sceneName );
			m_sceneLoad = SceneManager.LoadSceneAsync(_sceneName);
			if (_instant)
			{
				SceneLoadAdvance();
			}
			else
			{
				m_sceneLoad.allowSceneActivation = false;
			}
		}
	}

	protected void SceneLoadAdvance()
	{
		if (m_sceneLoad != null)
		{
			m_sceneLoad.allowSceneActivation = true;
			m_sceneLoad.completed += OperationOnCompleted;
			m_loadScreen.SetActive(value: true);
		}
	}

	protected void SceneLoadFade(string _sceneName, float _time, bool _black, bool _fadeUp)
	{
		if (_time == 0f)
		{
			SceneLoad(_sceneName, _instant: true, _black);
		}
		else if (m_sceneLoad == null)
		{
			SceneLoad(_sceneName, _instant: false, _black);
			m_fade = (_fadeUp ? fadeState.fadeIn : fadeState.fadeInOnly);
			m_fadeLerp = 0f;
			m_fadeRate = 1f / _time;
			m_loadScreen.GetComponent<CanvasGroup>().alpha = 0f;
			m_loadScreen.SetActive(value: true);
		}
	}

	private void OperationOnCompleted(AsyncOperation obj)
	{
		DiskSaveNow();
		if (m_fade == fadeState.loading)
		{
			m_fade = fadeState.fadeOut;
		}
		else
		{
			m_loadScreen.SetActive(value: false);
		}
		m_sceneLoad = null;
	}

	public static void LoadScene(string _sceneName)
	{
		LoadScene(_sceneName, _black: true);
	}

	public static void LoadScene(string _sceneName, bool _black)
	{
		s_instance.SceneLoad(_sceneName, _instant: true, _black);
	}

	public static void LoadSceneStart(string _sceneName)
	{
		LoadSceneStart(_sceneName, _black: true);
	}

	public static void LoadSceneStart(string _sceneName, bool _black)
	{
		s_instance.SceneLoad(_sceneName, _instant: false, _black);
	}

	public static void LoadSceneAdvance()
	{
		s_instance.SceneLoadAdvance();
	}

	public static void LoadSceneFade(string _sceneName, float _time)
	{
		s_instance.SceneLoadFade(_sceneName, _time, _black: true, _fadeUp: false);
	}

	public static void LoadSceneFade(string _sceneName, float _time, bool _fadeUp)
	{
		s_instance.SceneLoadFade(_sceneName, _time, _black: true, _fadeUp);
	}

	public static uiCursor GetCursor()
	{
		if (!(s_instance == null))
		{
			return s_instance.m_cursor;
		}
		return null;
	}

	public static void SaveNeeded()
	{
		s_instance.m_saveNeeded = true;
	}

	public static void GameAction()
	{
		s_instance.m_saveTimer = Mathf.Min(s_instance.m_saveTimer, 4f);
	}

	public static void DiskSaveNow()
	{
		if (s_instance.m_saveNeeded)
		{
			s_instance.m_saveTimer = 0f;
			s_instance.m_saveNeeded = false;
			saveData.SaveAlbumToDisk();
		}
	}

	public static void PrefSaveDirty()
	{
		s_instance.m_prefSaveNeeded = true;
	}

	public static void PrefSaveNow()
	{
		if (s_instance.m_prefSaveNeeded)
		{
			PlayerPrefs.Save();
		}
	}

	public static void SetResolution(int _width, int _height)
	{
		screenScaleScript[] array = UnityEngine.Object.FindObjectsOfType<screenScaleScript>();
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetResolution(_width, _height);
		}
		gameScript gameScript2 = UnityEngine.Object.FindObjectOfType<gameScript>();
		if (gameScript2 != null)
		{
			gameScript2.SetResolution(_width, _height);
		}
		frontendUIScript frontendUIScript2 = UnityEngine.Object.FindObjectOfType<frontendUIScript>();
		if (frontendUIScript2 != null)
		{
			frontendUIScript2.SetResolution(_width, _height);
		}
		albumScript albumScript2 = UnityEngine.Object.FindObjectOfType<albumScript>();
		if (albumScript2 != null)
		{
			albumScript2.SetResolution(_width, _height);
		}
		stickerSceneScript stickerSceneScript2 = UnityEngine.Object.FindObjectOfType<stickerSceneScript>();
		if (stickerSceneScript2 != null)
		{
			stickerSceneScript2.SetResolution(_width, _height);
		}
		creditsScript creditsScript2 = UnityEngine.Object.FindObjectOfType<creditsScript>();
		if (creditsScript2 != null)
		{
			creditsScript2.SetResolution(_width, _height);
		}
		inputHandler.SetResolution(_width, _height);
	}

	public static int GetAccessSetting(accessSetting _setting)
	{
		return PlayerPrefs.GetInt("access_" + _setting, 0);
	}

	public static void SetAccessSetting(accessSetting _setting, int _value)
	{
		string key = "access_" + _setting;
		if (_value == 0)
		{
			PlayerPrefs.DeleteKey(key);
		}
		else
		{
			PlayerPrefs.SetInt(key, _value);
		}
		PrefSaveDirty();
	}

	public static void ResetAccessSetting(accessSetting _setting)
	{
		PlayerPrefs.DeleteKey("access_" + _setting);
		PrefSaveDirty();
	}
}
