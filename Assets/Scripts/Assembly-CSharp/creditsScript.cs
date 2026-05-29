using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class creditsScript : MonoBehaviour
{
	private enum state
	{
		plate = 0,
		plateSwap = 1,
		scroll = 2,
		end = 3
	}

	[Serializable]
	public class creditPlate
	{
		public string m_desc;

		public Color m_color;

		public Transform m_root;

		public float m_length;

		public int m_imageStage;

		private Texture2D m_texture;

		public Texture2D SetImage(byte[] _bytes)
		{
			m_texture = new Texture2D(584, 330, TextureFormat.RGB24, mipChain: false);
			m_texture.filterMode = FilterMode.Point;
			m_texture.LoadImage(_bytes);
			return m_texture;
		}
	}

	private Camera m_camera;

	private Transform m_background;

	public float m_songDelay = 1.875f;

	private float m_timer;

	public creditsSubtitleScript m_subtitles;

	private bool m_dark;

	private bool m_returnAlbum;

	private state m_state;

	[Header("WWise Events")]
	public string m_audioShowMenu;

	public string m_audioResume;

	public string m_audioMainMenuReturn;

	[Space(10f)]
	public float m_scrollerTime = 10f;

	public float m_scrollerTimeDark = 10f;

	[Space(20f)]
	public AnimationCurve m_plateCurve;

	public AnimationCurve m_plateCurveIn;

	public AnimationCurve m_plateCurveOut;

	private bool m_plateFade;

	private const float m_plateOffset = 600f;

	public CanvasGroup m_plateGroup;

	public creditPlate[] m_plates;

	private int m_plateCurrent;

	public RectTransform m_scroller;

	public Color m_scrollerColor;

	public RectTransform m_scrollerTarget;

	private float m_scrollMax;

	private float m_pixelScale = 2f;

	private float m_pixelScaleDiv = 0.5f;

	private float m_backgroundScroll = -5f;

	private float m_backgroundScrollRate;

	public GameObject m_end;

	public float m_endTime = 10f;

	public Animator[] m_animators;

	public Color[] m_albumColors;

	public SpriteRenderer m_albumCover;

	public TextMeshPro m_albumName;

	public TextMeshPro m_albumDate;

	public GameObject m_skipMenu;

	private bool m_skipMenuActive;

	private float m_skipMenuLerp;

	private bool m_paused;

	public SpriteRenderer m_starSticker;

	public Sprite m_starStickerDark;

	public void SetResolution(int _width, int _height)
	{
		int num = Mathf.Max(1, Mathf.Min(_width / 800, _height / 400));
		if (num == 1 && _width >= 1280 && _height >= 720)
		{
			num = 2;
		}
		m_subtitles.SetResolution(_height / num);
		m_pixelScale = num;
		m_pixelScaleDiv = 1f / (float)num;
	}

	private void Start()
	{
		AkSoundEngine.SetState("Music_State", "None");
		gameStateScript.SetGameClear();
		m_dark = saveData.DarkStarClear();
		m_plateFade = gameStateScript.GetAccessSetting(gameStateScript.accessSetting.zonefade) > 0;
		if (saveData.DarkStarClear())
		{
			m_starSticker.sprite = m_starStickerDark;
		}
		uiCursor cursor = gameStateScript.GetCursor();
		cursor.Behaviour = uiCursor.CursorBehaviour.Custom;
		cursor.ShowCursor(_value: false);
		m_camera = Camera.main;
		m_background = GameObject.Find("background").transform;
		if (gameStateScript.IsLoadStage())
		{
			m_returnAlbum = true;
		}
		if (!saveData.SaveActive)
		{
			saveData.LoadFirstSave();
		}
		for (int i = 0; i < m_plates.Length; i++)
		{
			if (m_plates[i].m_imageStage > 0)
			{
				m_plates[i].m_root.GetComponentInChildren<RawImage>().texture = m_plates[i].SetImage(saveData.GetStage(m_plates[i].m_imageStage - 1).image);
			}
		}
		float scaleFactor = GetComponent<CanvasScaler>().scaleFactor;
		m_scrollMax = (m_scroller.position.y - m_scrollerTarget.position.y) / scaleFactor + GetComponent<RectTransform>().sizeDelta.y;
		m_backgroundScrollRate = m_scrollMax / (m_dark ? m_scrollerTimeDark : m_scrollerTime) * scaleFactor * 0.5f;
		m_scroller.gameObject.SetActive(value: false);
		m_plates[0].m_root.gameObject.SetActive(value: true);
		m_camera.backgroundColor = m_plates[0].m_color;
		saveData.saveScrape albumInfo = saveData.GetAlbumInfo();
		m_albumCover.color = m_albumColors[albumInfo.color];
		m_albumName.text = albumInfo.name;
		m_albumDate.font = gameStateScript.GetFont(stringIdScript.fontStyle.small);
		m_albumDate.text = gameStateScript.GetString("album_childroom_year") + "-\n" + gameStateScript.GetString("album_house_year");
		SetResolution(Screen.width, Screen.height);
		m_subtitles.SetGradientColor(Color.black);
	}

	public void Resume()
	{
		if (!string.IsNullOrEmpty(m_audioResume))
		{
			AkSoundEngine.PostEvent(m_audioResume, base.gameObject);
		}
		m_skipMenuActive = false;
		m_skipMenu.SendMessage("ControlsActive", false, SendMessageOptions.DontRequireReceiver);
		uiCursor cursor = gameStateScript.GetCursor();
		cursor.Behaviour = uiCursor.CursorBehaviour.Custom;
		cursor.ShowCursor(_value: false);
		Pause(_pause: false);
	}

	public void Skip()
	{
		if (!string.IsNullOrEmpty(m_audioMainMenuReturn))
		{
			AkSoundEngine.PostEvent(m_audioMainMenuReturn, base.gameObject);
		}
		AkSoundEngine.SetState("Music_State", "None");
		AkSoundEngine.PostEvent("Resume_music", base.gameObject);
		ReturnToMenu();
	}

	public void Pause(bool _pause)
	{
		if (m_paused != _pause && (_pause || !m_skipMenuActive))
		{
			m_paused = _pause;
			AkSoundEngine.PostEvent(_pause ? "Pause_music" : "Resume_music", base.gameObject);
			m_subtitles.Pause(m_paused);
			if (m_plateCurrent == 0)
			{
				m_plates[0].m_root.GetComponentInChildren<Animator>().speed = (_pause ? 0f : 1f);
			}
		}
	}

	private void Update()
	{
		if (!m_skipMenuActive && inputHandler.IsPressed(InputAction.Gameplay_Menu))
		{
			if (!string.IsNullOrEmpty(m_audioShowMenu))
			{
				AkSoundEngine.PostEvent(m_audioShowMenu, base.gameObject);
			}
			m_skipMenuActive = true;
			m_skipMenu.SetActive(value: true);
			m_skipMenu.SendMessage("ControlsActive", false, SendMessageOptions.DontRequireReceiver);
			gameStateScript.GetCursor().Behaviour = uiCursor.CursorBehaviour.Default;
			Pause(_pause: true);
		}
		else if (m_skipMenuActive && inputHandler.IsPressed(InputAction.Menu_Back))
		{
			Resume();
		}
		if (m_skipMenuActive && m_skipMenuLerp < 1f)
		{
			m_skipMenuLerp += Time.deltaTime * 4f;
			if (m_skipMenuLerp >= 1f)
			{
				m_skipMenu.SendMessage("Lerp", 1f, SendMessageOptions.DontRequireReceiver);
				m_skipMenu.SendMessage("ControlsActive", true, SendMessageOptions.DontRequireReceiver);
			}
			else
			{
				m_skipMenu.SendMessage("Lerp", m_skipMenuLerp, SendMessageOptions.DontRequireReceiver);
			}
		}
		else if (!m_skipMenuActive && m_skipMenuLerp > 0f)
		{
			m_skipMenuLerp -= Time.deltaTime * 4f;
			if (m_skipMenuLerp <= 0f)
			{
				m_skipMenu.SetActive(value: false);
			}
			else
			{
				m_skipMenu.SendMessage("Lerp", m_skipMenuLerp, SendMessageOptions.DontRequireReceiver);
			}
		}
		if (m_paused)
		{
			return;
		}
		float num = 1f;
		float num2 = Time.deltaTime * num;
		if (m_songDelay > 0f)
		{
			m_songDelay -= num2;
			if (m_songDelay <= 0f)
			{
				AkSoundEngine.SetState("Music_State", m_dark ? "credits_darkstar" : "credits");
				if (PlayerPrefs.GetFloat("volume_master", 1f) * PlayerPrefs.GetFloat("volume_music", 1f) > 0f)
				{
					m_subtitles.Play(m_dark);
				}
			}
		}
		bool flag = true;
		m_backgroundScroll += num2 * m_backgroundScrollRate;
		if (m_state == state.plate)
		{
			m_timer += num2;
			if (m_timer >= m_plates[m_plateCurrent].m_length)
			{
				m_timer -= m_plates[m_plateCurrent].m_length;
				PlateSwap();
			}
		}
		else if (m_state == state.plateSwap)
		{
			float timer = m_timer;
			m_timer += num2;
			float timer2 = m_timer;
			if (m_plateFade)
			{
				if (timer < 0.5f)
				{
					m_plateGroup.alpha = Mathf.Lerp(0f, 1f, Mathf.InverseLerp(0.5f, 0f, m_timer));
					if (m_timer >= 0.5f)
					{
						m_plates[m_plateCurrent - 1].m_root.gameObject.SetActive(value: false);
						if (m_plateCurrent < m_plates.Length)
						{
							m_plates[m_plateCurrent].m_root.gameObject.SetActive(value: true);
						}
					}
				}
				else
				{
					if (m_plateCurrent < m_plates.Length)
					{
						m_plateGroup.alpha = Mathf.Lerp(0f, 1f, Mathf.InverseLerp(0.5f, 1f, m_timer));
					}
					if (m_timer >= 1f)
					{
						if (m_plateCurrent < m_plates.Length)
						{
							m_state = state.plate;
						}
						else
						{
							m_plateGroup.gameObject.SetActive(value: false);
							m_state = state.scroll;
							m_scroller.gameObject.SetActive(value: true);
						}
						m_timer -= 1f;
					}
				}
			}
			else
			{
				float num3 = (m_plateCurve.Evaluate(m_timer) - m_plateCurve.Evaluate(timer)) * 600f;
				m_backgroundScroll += num3;
				if (m_timer >= 1f)
				{
					m_plates[m_plateCurrent - 1].m_root.gameObject.SetActive(value: false);
					if (m_plateCurrent < m_plates.Length)
					{
						m_plates[m_plateCurrent].m_root.GetComponent<RectTransform>().anchoredPosition = Vector3.zero;
						m_state = state.plate;
					}
					else
					{
						m_plateGroup.gameObject.SetActive(value: false);
						m_state = state.scroll;
						m_scroller.gameObject.SetActive(value: true);
					}
					m_timer -= 1f;
				}
				else
				{
					m_plates[m_plateCurrent - 1].m_root.GetComponent<RectTransform>().anchoredPosition = Vector2.up * Mathf.Round(m_plateCurveOut.Evaluate(m_timer) * 600f * m_pixelScale) * m_pixelScaleDiv;
					if (m_plateCurrent < m_plates.Length)
					{
						m_plates[m_plateCurrent].m_root.GetComponent<RectTransform>().anchoredPosition = Vector2.up * (Mathf.Round(m_plateCurveIn.Evaluate(m_timer) * 600f * m_pixelScale) * m_pixelScaleDiv - 600f);
					}
				}
			}
			if (m_plateCurrent < m_plates.Length)
			{
				m_camera.backgroundColor = Color.Lerp(m_plates[m_plateCurrent - 1].m_color, m_plates[m_plateCurrent].m_color, timer2);
			}
			else
			{
				m_camera.backgroundColor = Color.Lerp(m_plates[m_plateCurrent - 1].m_color, m_scrollerColor, timer2);
			}
			m_subtitles.SetGradientColor(m_camera.backgroundColor);
		}
		else if (m_state == state.scroll)
		{
			m_timer += num2;
			Mathf.FloorToInt(m_scroller.anchoredPosition.y);
			m_scroller.anchoredPosition = Vector2.up * Mathf.Round(Mathf.Lerp(0f, m_scrollMax, m_timer / (m_dark ? m_scrollerTimeDark : m_scrollerTime)) * m_pixelScale) * m_pixelScaleDiv;
			flag = true;
			if (m_timer >= (m_dark ? m_scrollerTimeDark : m_scrollerTime))
			{
				m_state = state.end;
				m_scroller.gameObject.SetActive(value: false);
				m_end.SetActive(value: true);
				m_timer = 0f;
				m_subtitles.EnableGradient(_value: false);
			}
		}
		else if (m_state == state.end)
		{
			m_timer += num2;
			if (m_albumName.gameObject.activeInHierarchy)
			{
				m_albumName.ForceMeshUpdate();
			}
			if (m_timer >= m_endTime)
			{
				ReturnToMenu();
			}
		}
		for (int i = 0; i < m_animators.Length; i++)
		{
			m_animators[i].speed = num;
		}
		if (flag)
		{
			m_background.localPosition = new Vector3(0f, Mathf.Repeat(Mathf.Round(m_backgroundScroll * 0.5f * m_pixelScale) * m_pixelScaleDiv * 0.01f, 0.64f), 15f);
		}
	}

	private void PlateSwap()
	{
		m_plateCurrent++;
		m_state = state.plateSwap;
		if (!m_plateFade && m_plateCurrent < m_plates.Length)
		{
			m_plates[m_plateCurrent].m_root.gameObject.SetActive(value: true);
			m_plates[m_plateCurrent].m_root.GetComponent<RectTransform>().anchoredPosition = Vector2.up * -600f;
		}
		else
		{
			m_subtitles.EnableGradient(_value: true);
		}
	}

	private void ReturnToMenu()
	{
		if (m_returnAlbum)
		{
			gameStateScript.albumPage = 8;
			gameStateScript.SetAlbumLoadGame();
			gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
		}
		else
		{
			gameStateScript.LoadSceneFade("title", 0.25f);
		}
		base.enabled = false;
	}
}
