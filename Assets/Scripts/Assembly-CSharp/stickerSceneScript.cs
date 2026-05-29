using UnityEngine;
using UnityEngine.UI;

public class stickerSceneScript : MonoBehaviour
{
	private enum noteState
	{
		none = 0,
		visible = 1,
		showing = 2,
		hiding = 3
	}

	[Header("WWise Events")]
	public string m_audioPostitSlideIn;

	public string m_audioPostitSlideOut;

	public string m_audioStickerHighlight;

	public string m_audioMainMenuReturn;

	public string m_audioAlbumReturn;

	[Space(20f)]
	public stickerData m_stickerData;

	public Transform m_stickerPrefab;

	public Material[] m_stickerMats;

	public RectTransform[] m_stickerSheets;

	public GameObject[] m_returnButtons;

	public RectTransform m_root;

	public Button[] m_scrollButtons;

	public Sprite[] m_buttonArrowFrames;

	private float m_buttonNextLerp;

	private float m_buttonNextLerpTarget;

	private float m_buttonPrevLerp;

	private float m_buttonPrevLerpTarget;

	private float m_scroll;

	private float m_scrollTarget;

	public RectTransform m_note;

	public stringIdScript m_noteText;

	private float m_noteTarget = 110f;

	private int m_noteId = -1;

	private float m_notePosition;

	private float m_noteLerp;

	public AnimationCurve m_noteCurve;

	private int m_noteNextId = -1;

	private float m_noteNextPosition;

	public CanvasGroup m_canvasGroup;

	private noteState m_noteState;

	private uiSceneControllerInputHandler sceneController;

	private void Start()
	{
		AkSoundEngine.SetState("Music_State", "stickers");
		if (gameStateScript.CheckAlbumLoad())
		{
			m_returnButtons[0].SetActive(value: false);
			m_returnButtons[1].SetActive(value: true);
		}
		for (int i = 0; i < m_stickerSheets.Length; i++)
		{
			for (int j = 0; j < m_stickerData.stickers.Length; j++)
			{
				if (m_stickerData.stickers[j].page == i)
				{
					RectTransform rectTransform = Object.Instantiate(m_stickerPrefab, m_stickerSheets[i]) as RectTransform;
					Vector2 position = m_stickerData.stickers[j].position;
					position.y *= -1f;
					rectTransform.anchoredPosition = position;
					rectTransform.GetComponent<Image>().sprite = m_stickerData.stickers[j].sprite;
					rectTransform.GetComponent<Image>().SetNativeSize();
					rectTransform.gameObject.AddComponent<uiStickerSheetItem>().Register(this, j);
					if (!saveData.StickerUnlocked(j))
					{
						rectTransform.GetComponent<Image>().material = m_stickerMats[1];
					}
				}
			}
		}
		SetResolution(Screen.width, Screen.height);
		sceneController = Object.FindObjectOfType<uiSceneControllerInputHandler>();
	}

	private void OnEnable()
	{
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
		OnControllerInputTypeChanged();
	}

	private void OnDisable()
	{
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
	}

	private void OnControllerInputTypeChanged()
	{
		gameStateScript.GetCursor()?.ShowCursor(inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard);
	}

	private void Update()
	{
		if (m_noteState == noteState.none && m_noteNextId > -1)
		{
			AkSoundEngine.PostEvent(m_audioPostitSlideIn, m_note.gameObject);
			m_noteState = noteState.showing;
			m_noteId = m_noteNextId;
			m_notePosition = m_noteNextPosition;
			m_note.anchoredPosition = new Vector2(m_notePosition, 0f);
			if (gameStateScript.language == languageData.languageId.tr_TR)
			{
				m_noteText.SetSpacing((m_noteNextId == 25) ? (-4f) : 0f);
			}
			m_noteText.SetString(m_stickerData.stickers[m_noteNextId].id);
			m_note.gameObject.SetActive(value: true);
		}
		else if (m_noteState != noteState.none && m_noteState != noteState.hiding && m_noteNextId != m_noteId)
		{
			AkSoundEngine.PostEvent(m_audioPostitSlideOut, m_note.gameObject);
			m_noteState = noteState.hiding;
		}
		if (m_noteState == noteState.showing)
		{
			m_noteLerp = Mathf.MoveTowards(m_noteLerp, 1f, Time.deltaTime * 6f);
			if (Mathf.Approximately(m_noteLerp, 1f))
			{
				m_noteState = noteState.visible;
			}
			m_note.anchoredPosition = new Vector2(m_notePosition, Mathf.Lerp(0f, m_noteTarget, m_noteCurve.Evaluate(m_noteLerp)));
		}
		else if (m_noteState == noteState.hiding)
		{
			m_noteLerp = Mathf.MoveTowards(m_noteLerp, 0f, Time.deltaTime * 5f);
			if (Mathf.Approximately(m_noteLerp, 0f))
			{
				m_noteState = noteState.none;
				m_note.gameObject.SetActive(value: false);
				m_noteId = -1;
			}
			m_note.anchoredPosition = new Vector2(m_notePosition, Mathf.Lerp(0f, m_noteTarget, m_noteCurve.Evaluate(m_noteLerp)));
		}
		if (!Mathf.Approximately(m_buttonNextLerp, m_buttonNextLerpTarget))
		{
			m_buttonNextLerp = Mathf.MoveTowards(m_buttonNextLerp, m_buttonNextLerpTarget, Time.deltaTime * 3f);
			SetButton(m_scrollButtons[1], m_buttonNextLerp);
		}
		if (!Mathf.Approximately(m_buttonPrevLerp, m_buttonPrevLerpTarget))
		{
			m_buttonPrevLerp = Mathf.MoveTowards(m_buttonPrevLerp, m_buttonPrevLerpTarget, Time.deltaTime * 3f);
			SetButton(m_scrollButtons[0], m_buttonPrevLerp);
		}
		if (!Mathf.Approximately(m_scroll, m_scrollTarget))
		{
			m_scroll = Mathf.Lerp(m_scroll, m_scrollTarget, Time.deltaTime * 4f);
			m_root.anchoredPosition = Vector2.right * Mathf.Round(m_scroll);
		}
		if (m_scrollTarget != 0f && sceneController != null && sceneController.currentGamepadSelectedUIElement != null)
		{
			Vector3 position = sceneController.currentGamepadSelectedUIElement.transform.position;
			if (position.x > 2f && m_scrollTarget > 0f)
			{
				SlideRight();
			}
			else if (position.x < -2f && m_scrollTarget < 0f)
			{
				SlideLeft();
			}
		}
	}

	public void SetResolution(int _width, int _height)
	{
		_ = (float)_height / 200f;
		int num = Mathf.Max(1, Mathf.Min(_width / 800, _height / 400));
		if (num == 1 && _width >= 1280 && _height >= 720)
		{
			num = 2;
		}
		float t = Mathf.InverseLerp(360f, 540f, (float)_height / (float)num);
		m_noteTarget = Mathf.Ceil(Mathf.Lerp(50f, 110f, t));
		m_noteText.GetComponent<RectTransform>().anchoredPosition = new Vector2(Mathf.Round(Mathf.Lerp(-3f, -5f, t)), Mathf.Ceil(Mathf.Lerp(34f, 4f, t)));
		float t2 = Mathf.InverseLerp(640f, 960f, (float)_width / (float)num);
		m_scrollTarget = Mathf.Round(Mathf.Lerp(155f, 0f, t2)) * ((m_scroll < 0f) ? (-1f) : 1f);
		SetButtons();
		if (m_noteState == noteState.visible)
		{
			m_noteState = noteState.showing;
		}
	}

	public void ShowText(int _id, int _position)
	{
		if (m_noteId != _id && m_noteNextId != _id)
		{
			AkSoundEngine.PostEvent(m_audioStickerHighlight, base.gameObject);
		}
		m_noteNextId = _id;
		m_noteNextPosition = (float)_position + 4f;
	}

	public void HideText()
	{
		m_noteNextId = -1;
	}

	public void SlideLeft()
	{
		m_scrollTarget = Mathf.Abs(m_scrollTarget);
		SetButtons();
	}

	public void SlideRight()
	{
		m_scrollTarget = 0f - Mathf.Abs(m_scrollTarget);
		SetButtons();
	}

	private void SetButton(Button _button, float _lerp)
	{
		Image component = _button.GetComponent<Image>();
		if (_lerp <= 0f)
		{
			component.enabled = false;
			return;
		}
		component.enabled = true;
		component.sprite = m_buttonArrowFrames[Mathf.RoundToInt(_lerp * 4f)];
	}

	private void SetButtons()
	{
		if (m_scrollTarget == 0f)
		{
			m_buttonNextLerpTarget = 0f;
			m_buttonPrevLerpTarget = 0f;
			m_scrollButtons[1].interactable = false;
			m_scrollButtons[1].GetComponent<Image>().raycastTarget = false;
			m_scrollButtons[0].interactable = false;
			m_scrollButtons[0].GetComponent<Image>().raycastTarget = false;
		}
		else if (m_scrollTarget > 0f)
		{
			m_buttonNextLerpTarget = 1f;
			m_buttonPrevLerpTarget = 0f;
			m_scrollButtons[1].interactable = true;
			m_scrollButtons[1].GetComponent<Image>().raycastTarget = true;
			m_scrollButtons[0].interactable = false;
			m_scrollButtons[0].GetComponent<Image>().raycastTarget = false;
		}
		else
		{
			m_buttonNextLerpTarget = 0f;
			m_buttonPrevLerpTarget = 1f;
			m_scrollButtons[1].interactable = false;
			m_scrollButtons[1].GetComponent<Image>().raycastTarget = false;
			m_scrollButtons[0].interactable = true;
			m_scrollButtons[0].GetComponent<Image>().raycastTarget = true;
		}
	}

	public void ReturnToTitle()
	{
		m_canvasGroup.interactable = false;
		AkSoundEngine.PostEvent(m_audioMainMenuReturn, base.gameObject);
		gameStateScript.SetQuickTitleReturn();
		gameStateScript.LoadSceneFade("title", 0.25f);
	}

	public void ToAlbum()
	{
		m_canvasGroup.interactable = false;
		if (!string.IsNullOrEmpty(m_audioAlbumReturn))
		{
			AkSoundEngine.PostEvent(m_audioAlbumReturn, base.gameObject);
		}
		gameStateScript.LoadSceneFade("album", 0.25f, _fadeUp: true);
	}
}
