using System;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.UI;

public class albumScript : MonoBehaviour
{
	private enum panType
	{
		none = 0,
		panIn = 1,
		panOut = 2,
		panLeft = 3,
		photoPlace = 4
	}

	private enum confirmType
	{
		none = 0,
		deleteAlbum = 1,
		restartStage = 2,
		record = 3,
		saveError = 4
	}

	[Serializable]
	public struct frameCover
	{
		public GameObject[] m_elements;

		public RectTransform[] m_loop;

		public Vector2Int m_loopLerp;

		public RectTransform m_label;

		public Vector4 m_labelLerp;

		public float m_angle;
	}

	private enum pageSound
	{
		albumOpen = 0,
		albumClose = 1,
		pageTurnLeft = 2,
		pageTurnRight = 3
	}

	private albumManagerScript m_manager;

	private int m_stage;

	private string m_name = "";

	private int m_completedStage;

	private bool m_newAlbum;

	private bool m_cloneAlbum;

	private int m_albumColorIndex;

	private Texture2D m_stagePreviewTex;

	public Image[] m_albumColor;

	public GameObject m_albumCover1;

	public GameObject m_albumCover2;

	public Button[] m_albumButtonColor;

	public Button[] m_floatingButtonColor;

	public RectTransform[] m_scaleNodes;

	public RectTransform[] m_backCoverOffset;

	public GameObject[] m_flippedPages;

	public RectTransform[] m_ringFronts;

	public RectTransform m_pageBack;

	public RectTransform[] m_ringBackMasks;

	public RectTransform[] m_ringBacks;

	public RectTransform m_albumCoverSticker;

	public GameObject m_albumCover;

	public TMP_InputField m_albumCoverName;

	public GameObject m_albumCoverPencil;

	public GameObject m_albumCoverTick;

	public RawImage m_stagePreview;

	public Image m_stagePreviewCredits;

	public Sprite[] m_stagePreviewCreditsArt;

	public stringIdScript m_stageMonthYear;

	public stringIdScript m_stageDesc;

	public GameObject m_buttonNext;

	public GameObject m_buttonPrev;

	public GameObject m_buttonPlay;

	public Sprite[] m_buttonArrowFrames;

	private float m_buttonNextLerp;

	private float m_buttonNextLerpTarget;

	private float m_buttonPrevLerp;

	private float m_buttonPrevLerpTarget;

	public uiAlbumAdvanceScript m_buttonStart;

	public GameObject m_buttonDelete;

	public GameObject m_buttonClone;

	public GameObject m_buttonStartOver;

	public GameObject m_buttonVideo;

	private Image m_videoImage;

	private bool m_videoPulse;

	private float m_videoPulseValue;

	private bool m_videoPulseAnimate = true;

	public GameObject m_buttonStickers;

	private bool m_stickersAppear;

	public Gradient m_stickersAppearEffect;

	private float m_stickersAppearLerp;

	private panType m_pan;

	private bool m_panReverse;

	private float m_panValue;

	private float m_panValueAlt;

	private int m_panPhase;

	private bool m_panSticker;

	public RectTransform m_panRoot;

	public AnimationCurve m_panCurve;

	[Header("Floating HUD")]
	public RectTransform m_hudFloating;

	[Header("Photo Add")]
	public GameObject m_photoAddNode;

	private Vector2 m_photoAddPhotoStart = Vector2.zero;

	private Vector2 m_photoAddPhotoGoal = Vector2.zero;

	public RectTransform[] m_photoAddScaleNodes;

	public RawImage m_photoAddPhoto;

	public GameObject m_photoAddShadowNode;

	public Image m_photoAddFrame;

	public Sprite[] m_photoAddFrameArt;

	public PostProcessVolume m_photoAddPostFX;

	public AnimationCurve m_photoAddCurve;

	public AnimationCurve m_photoAddMoveCurve;

	public AnimationCurve m_photoAddRaisedCurve;

	public AnimationCurve m_photoAddStickerDelayCurve;

	[Header("Confirm")]
	public GameObject m_confirmDelete;

	public CanvasGroup m_confirmDeleteDim;

	public RectTransform m_confirmDeletePanel;

	public stringIdScript m_confirmText;

	public AnimationCurve m_confirmDeleteCurve;

	public RectTransform m_confirmRecordPanel;

	private confirmType m_confirmType;

	private float m_confirmDeleteLerp;

	public Transform m_checkerboard;

	public frameCover[] m_frameCover;

	public frameCover[] m_framePage;

	public Image m_pageShadow;

	private Color m_pageShadowColor;

	public RectTransform m_pageRoot;

	public RectTransform[] m_coverRoots;

	public GameObject[] m_pageRenderTexture;

	public RectTransform m_pageRenderTexturePivot;

	public RectTransform[] m_pageRenderTextureScaleNodes;

	private Texture2D m_pageRenderTextureSource;

	public RawImage m_pageRenderTexturePhoto;

	public stringIdScript[] m_pageRenderTextureText;

	public TextMeshProUGUI m_coverRenderTextureText;

	public GameObject[] m_RenderTextureNodes;

	public Image[] m_RenderTextureCoverButtons;

	private float m_seekPage = -1f;

	private int m_seekPageTarget = -1;

	private bool m_deselectingTextField;

	private bool m_albumBackout;

	private void Awake()
	{
		m_manager = base.transform.parent.GetComponent<albumManagerScript>();
		m_albumCover.SetActive(value: false);
		m_albumCover1.SetActive(value: true);
		m_albumCover2.SetActive(value: false);
		m_stagePreviewTex = new Texture2D(584, 330, TextureFormat.RGB24, mipChain: false);
		m_stagePreviewTex.filterMode = FilterMode.Point;
		m_pageRenderTextureSource = new Texture2D(584, 330, TextureFormat.RGB24, mipChain: false);
		m_pageRenderTextureSource.filterMode = FilterMode.Point;
		m_pageShadowColor = m_pageShadow.color;
	}

	private void OnEnable()
	{
		m_videoPulseAnimate = gameStateScript.PulseAnimate;
		SetResolution(Screen.width, Screen.height);
		gameStateScript.GetCursor().Behaviour = uiCursor.CursorBehaviour.Default;
		GameState.Set("album", "entered");
		SetNameIcon(0);
	}

	private void OnDisable()
	{
		GameState.Remove("album");
		GameState.Remove("photo");
		inputHandler.Instance.OnInputFieldExited(m_albumCoverName);
	}

	public void SetResolution(int _width, int _height)
	{
		int num = Mathf.Max(1, Mathf.Min(_width / 800, _height / 400));
		if (num == 1 && _width >= 1280 && _height >= 720)
		{
			num = 2;
		}
		float t = Mathf.Min(Mathf.InverseLerp(640f, 960f, _width / num), Mathf.InverseLerp(360f, 540f, _height / num));
		Vector2 sizeDelta = Vector2.Lerp(new Vector2(539f, 307f), new Vector2(788f, 451f), t);
		sizeDelta.x = Mathf.Round(sizeDelta.x);
		sizeDelta.y = Mathf.Round(sizeDelta.y);
		m_scaleNodes[0].sizeDelta = sizeDelta;
		m_scaleNodes[1].sizeDelta = sizeDelta;
		m_photoAddScaleNodes[0].sizeDelta = sizeDelta;
		m_RenderTextureNodes[1].GetComponent<RectTransform>().sizeDelta = sizeDelta;
		Vector2 vector = Vector2.Lerp(new Vector2(385f, 216f), new Vector2(584f, 330f), t);
		vector.x = Mathf.Round(vector.x);
		vector.y = Mathf.Round(vector.y);
		m_scaleNodes[2].sizeDelta = vector;
		m_photoAddScaleNodes[1].sizeDelta = vector;
		m_photoAddScaleNodes[2].sizeDelta = vector + Vector2.one * 12f;
		m_pageRenderTextureScaleNodes[0].sizeDelta = vector;
		Vector2 anchoredPosition = Vector2.Lerp(new Vector2(1f, 8f), new Vector2(0f, 6f), t);
		anchoredPosition.x = Mathf.Round(anchoredPosition.x) + ((sizeDelta.x % 2f == 0f) ? 0f : 0.5f);
		anchoredPosition.y = Mathf.Round(anchoredPosition.y) + ((sizeDelta.y % 2f == 0f) ? 0f : 0.5f);
		m_scaleNodes[0].anchoredPosition = anchoredPosition;
		m_scaleNodes[1].anchoredPosition = anchoredPosition;
		m_photoAddScaleNodes[0].anchoredPosition = anchoredPosition;
		Vector2 vector2 = Vector2.Lerp(new Vector2(96f, -34f), new Vector2(120f, -44f), t);
		vector2.x = Mathf.Round(vector2.x);
		vector2.y = Mathf.Round(vector2.y);
		m_scaleNodes[2].anchoredPosition = vector2;
		m_photoAddPhotoGoal = vector2;
		m_photoAddPhotoStart = new Vector2(Mathf.Round(sizeDelta.x * 0.5f - vector.x * 0.5f + anchoredPosition.x + 6f), 0f - Mathf.Round(sizeDelta.y * 0.5f - vector.y * 0.5f + anchoredPosition.y + 6f));
		Vector2 anchoredPosition2 = Vector2.Lerp(new Vector2(1f, -35f), new Vector2(1f, -48f), t);
		anchoredPosition2.x = Mathf.Round(anchoredPosition2.x);
		anchoredPosition2.y = Mathf.Round(anchoredPosition2.y);
		m_scaleNodes[3].anchoredPosition = anchoredPosition2;
		m_pageRenderTextureScaleNodes[1].anchoredPosition = anchoredPosition2;
		Vector2 anchoredPosition3 = Vector2.Lerp(new Vector2(114f, -90f), new Vector2(238f, -158f), t);
		anchoredPosition3.x = Mathf.Round(anchoredPosition3.x);
		anchoredPosition3.y = Mathf.Round(anchoredPosition3.y);
		m_albumCoverSticker.anchoredPosition = anchoredPosition3;
		frameCover[] array = m_frameCover;
		for (int i = 0; i < array.Length; i++)
		{
			frameCover frameCover2 = array[i];
			if (frameCover2.m_loop.Length != 0)
			{
				Vector2Int loopLerp = frameCover2.m_loopLerp;
				float a = loopLerp.y;
				loopLerp = frameCover2.m_loopLerp;
				int num2 = Mathf.RoundToInt(Mathf.Lerp(a, loopLerp.x, t));
				for (int j = 0; j < frameCover2.m_loop.Length - 1; j++)
				{
					frameCover2.m_loop[j].gameObject.SetActive(j < num2);
				}
				frameCover2.m_loop[frameCover2.m_loop.Length - 1].SetParent(frameCover2.m_loop[num2 - 1], worldPositionStays: false);
			}
			if (frameCover2.m_label != null)
			{
				frameCover2.m_label.anchoredPosition = new Vector2(Mathf.Round(Mathf.Lerp(frameCover2.m_labelLerp.z, frameCover2.m_labelLerp.x, t)), Mathf.Round(Mathf.Lerp(frameCover2.m_labelLerp.w, frameCover2.m_labelLerp.y, t)));
			}
		}
		array = m_framePage;
		for (int i = 0; i < array.Length; i++)
		{
			frameCover frameCover3 = array[i];
			if (frameCover3.m_loop.Length != 0)
			{
				Vector2Int loopLerp = frameCover3.m_loopLerp;
				float a2 = loopLerp.y;
				loopLerp = frameCover3.m_loopLerp;
				int num3 = Mathf.RoundToInt(Mathf.Lerp(a2, loopLerp.x, t));
				for (int k = 0; k < frameCover3.m_loop.Length - 1; k++)
				{
					frameCover3.m_loop[k].gameObject.SetActive(k < num3);
				}
				frameCover3.m_loop[frameCover3.m_loop.Length - 1].SetParent(frameCover3.m_loop[num3 - 1], worldPositionStays: false);
			}
			if (frameCover3.m_label != null)
			{
				frameCover3.m_label.anchoredPosition = new Vector2(Mathf.Round(Mathf.Lerp(frameCover3.m_labelLerp.z, frameCover3.m_labelLerp.x, t)), Mathf.Round(Mathf.Lerp(frameCover3.m_labelLerp.w, frameCover3.m_labelLerp.y, t)));
			}
		}
	}

	public void Show()
	{
		EndVideoPulse();
		base.gameObject.SetActive(value: true);
		GetComponent<CanvasGroup>().interactable = true;
		GetComponent<CanvasGroup>().blocksRaycasts = true;
		m_checkerboard.localPosition = new Vector3(0f, Mathf.Repeat(Mathf.Round(-150f) / 100f, 0.64f), 15f);
	}

	public void PanIn(bool _reverse = false)
	{
		m_pan = panType.panIn;
		m_panValue = 0f;
		m_panReverse = _reverse;
		GetComponent<CanvasGroup>().interactable = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_hudFloating.sizeDelta = Vector2.one * 60f * 2f;
		m_panRoot.localPosition = Vector2.up * -600f + AlbumOffset();
		HidePrevNextButtons(_instant: true);
		EvaulateVideoPulse();
	}

	public void PanOut(bool _reverse = false)
	{
		m_pan = panType.panOut;
		m_panReverse = _reverse;
		m_panValue = 0f;
		GetComponent<CanvasGroup>().interactable = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_hudFloating.sizeDelta = Vector2.one;
		m_panRoot.localPosition = Vector2.up * 0f + AlbumOffset();
		HidePrevNextButtons();
		EvalStartButton(_hide: true);
	}

	public void PanLeft()
	{
		m_pan = panType.panLeft;
		m_panValue = 0f;
		m_panRoot.localPosition = Vector2.right * 0f + AlbumOffset();
		HidePrevNextButtons();
		EvalStartButton(_hide: true);
	}

	public void PanNone()
	{
		m_panRoot.localPosition = AlbumOffset();
		EvaulateVideoPulse();
	}

	public void PhotoPlace(int _albumPage, bool _stickerUnlock)
	{
		Show();
		m_pan = panType.photoPlace;
		m_panValue = 0f;
		GetComponent<CanvasGroup>().interactable = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_panRoot.localPosition = Vector2.up * -600f + AlbumOffset();
		ConfigureAlbum(_albumPage);
		m_buttonStart.Active(uiAlbumAdvanceScript.type.none);
		m_photoAddPhoto.texture = m_stagePreviewTex;
		m_photoAddNode.SetActive(value: true);
		m_photoAddShadowNode.SetActive(value: true);
		m_photoAddFrame.sprite = m_photoAddFrameArt[1];
		m_stagePreview.gameObject.SetActive(value: false);
		m_checkerboard.localPosition = new Vector3(0f, Mathf.Repeat(Mathf.Round(-300f) / 100f, 0.64f), 15f);
		m_hudFloating.sizeDelta = Vector2.one * 60f * 2f;
		m_photoAddPostFX.enabled = true;
		m_panSticker = _stickerUnlock;
		m_panValueAlt = (m_panSticker ? 0f : 1f);
		HidePrevNextButtons(_instant: true);
	}

	public void NewAlbum(int _albumColor, bool _clone = false)
	{
		if (_clone)
		{
			m_newAlbum = false;
			m_cloneAlbum = true;
		}
		else
		{
			m_newAlbum = true;
			m_cloneAlbum = false;
		}
		m_buttonStickers.SetActive(value: false);
		m_name = "";
		m_albumCoverName.text = m_name;
		m_coverRenderTextureText.text = m_name;
		GameState.Set("album", "new_name");
		SetNameIcon(0);
		albumManagerScript component = base.transform.parent.GetComponent<albumManagerScript>();
		AlbumColor(component.Color(_albumColor), component.BgColor(_albumColor));
		m_albumColorIndex = _albumColor;
		SnapSeek(-1);
		EvaulateVideoPulse();
	}

	public void ConfigureAlbum()
	{
		if (saveData.GetAlbumInfo().stageComplete > 8)
		{
			if (!gameStateScript.albumFirstClear)
			{
				gameStateScript.albumFirstClear = true;
				ConfigureAlbum(8);
			}
			else
			{
				ConfigureAlbum(saveData.GetFirstUnfinishedStage());
			}
		}
		else
		{
			ConfigureAlbum(saveData.GetLastStage());
		}
	}

	public void ConfigureAlbum(int _albumPage)
	{
		saveData.DiscardTemp();
		m_newAlbum = false;
		m_buttonStickers.SetActive(saveData.HasStickers());
		saveData.saveScrape albumInfo = saveData.GetAlbumInfo();
		m_name = albumInfo.name;
		m_albumCoverName.text = m_name;
		m_coverRenderTextureText.text = m_name;
		GameState.Set("album", "existing_name");
		SetNameIcon(0);
		m_completedStage = Mathf.Min(albumInfo.stageComplete, 9);
		albumManagerScript component = base.transform.parent.GetComponent<albumManagerScript>();
		AlbumColor(component.Color(albumInfo.color), component.BgColor(albumInfo.color));
		SnapSeek(_albumPage);
	}

	private void AlbumColor(Color _color, Color _bgColor)
	{
		_color *= 0.8f;
		_color.a = 1f;
		Image[] albumColor = m_albumColor;
		for (int i = 0; i < albumColor.Length; i++)
		{
			albumColor[i].color = _color;
		}
		Color color = new Color32(139, 128, 119, byte.MaxValue);
		color *= _color;
		Color color2 = color;
		color2.a = 0.5f;
		Button[] albumButtonColor = m_albumButtonColor;
		foreach (Button obj in albumButtonColor)
		{
			ColorBlock colors = obj.colors;
			colors.normalColor = color;
			colors.disabledColor = color2;
			obj.colors = colors;
		}
		albumColor = m_RenderTextureCoverButtons;
		for (int i = 0; i < albumColor.Length; i++)
		{
			albumColor[i].color = color2;
		}
		Camera.main.backgroundColor = _bgColor;
		Color color3 = _bgColor + new Color(0.25f, 0.25f, 0.25f);
		for (int j = 0; j < m_floatingButtonColor.Length; j++)
		{
			ColorBlock colors2 = m_floatingButtonColor[j].colors;
			colors2.normalColor = color3;
			Color disabledColor = color3;
			disabledColor.a = colors2.disabledColor.a;
			colors2.disabledColor = disabledColor;
			m_floatingButtonColor[j].colors = colors2;
		}
		m_buttonStart.m_starSpawner.m_colors[2] = color3;
	}

	private void SetNameIcon(int _value)
	{
		switch (_value)
		{
		case 0:
			m_albumCoverPencil.SetActive(value: true);
			m_albumCoverTick.SetActive(value: false);
			break;
		case 1:
			m_albumCoverPencil.SetActive(value: false);
			m_albumCoverTick.SetActive(value: true);
			break;
		default:
			m_albumCoverPencil.SetActive(value: true);
			m_albumCoverTick.SetActive(value: false);
			break;
		}
	}

	public void OnStartSettingName()
	{
		string text = ((EventSystem.current.currentSelectedGameObject == null) ? "[null]" : EventSystem.current.currentSelectedGameObject.name);
		Debug.Log("Hello " + Time.time + " | m_deselectingTextField : " + m_deselectingTextField.ToString() + " : " + text + " : " + EventSystem.current.alreadySelecting.ToString());
		if (!m_deselectingTextField)
		{
			m_albumCoverName.caretPosition = m_albumCoverName.text.Length;
			if (!string.IsNullOrEmpty(m_manager.m_audioAlbumNameEntryStart))
			{
				AkSoundEngine.PostEvent(m_manager.m_audioAlbumNameEntryStart, m_manager.gameObject);
			}
			GameState.Set("album", (m_name.Length > 0) ? "editing_name_valid" : "editing_name");
			SetNameIcon((m_name.Length > 0) ? 1 : (-1));
			EvalStartButton(_hide: true);
			HidePrevNextButtons();
			inputHandler.Instance.OnInputFieldEntered(m_albumCoverName);
		}
	}

	private IEnumerator DeselectTextfield()
	{
		yield return new WaitUntil(() => !EventSystem.current.alreadySelecting);
		m_deselectingTextField = true;
		EventSystem.current.SetSelectedGameObject(null);
	}

	public void TextDeselect()
	{
	}

	public void SetName()
	{
		m_name = m_albumCoverName.text;
		if (inputHandler.IsPressed(InputAction.Menu_Accept, ignoreInputHandled: true) && string.IsNullOrWhiteSpace(m_name))
		{
			m_name = "Sadie";
			m_albumCoverName.text = m_name;
		}
		m_coverRenderTextureText.text = m_name;
		if (m_newAlbum)
		{
			if (!string.IsNullOrWhiteSpace(m_name) && !m_albumBackout)
			{
				EvalStartButton();
			}
		}
		else
		{
			if (!string.IsNullOrEmpty(m_name))
			{
				if (saveData.GetStageInProgress(0))
				{
					SetPrevNextButtons();
				}
				else
				{
					EvalStartButton();
				}
			}
			if (m_cloneAlbum)
			{
				if (!string.IsNullOrWhiteSpace(m_name) && !m_albumBackout)
				{
					saveData.CloneSave(m_name, m_albumColorIndex);
					m_cloneAlbum = false;
				}
			}
			else
			{
				saveData.Save(m_name);
			}
		}
		inputHandler.Instance.OnInputFieldExited(m_albumCoverName);
		if ((m_newAlbum || m_cloneAlbum) && string.IsNullOrWhiteSpace(m_name))
		{
			GameState.Set("album", "new_name");
			SetNameIcon(-1);
			return;
		}
		GameState.Set("album", "existing_name");
		SetNameIcon(0);
		if (!string.IsNullOrEmpty(m_manager.m_audioAlbumNameEntrySuccess))
		{
			AkSoundEngine.PostEvent(m_manager.m_audioAlbumNameEntrySuccess, m_manager.gameObject);
		}
	}

	public void NameStringChange()
	{
		string text = m_albumCoverName.text;
		bool flag = false;
		while (m_albumCoverName.textComponent.GetPreferredValues(text).x > 210f || text.EndsWith("  "))
		{
			flag = true;
			text = text.Substring(0, text.Length - 1);
		}
		if (flag)
		{
			m_albumCoverName.text = text;
		}
		GameState.Set("album", (text.Length > 0) ? "editing_name_valid" : "editing_name");
		SetNameIcon((text.Length > 0) ? 1 : (-1));
	}

	private Vector2 AlbumOffset()
	{
		return Vector2.right * ((m_stage == -1) ? 11f : 0f);
	}

	private void Update()
	{
		if (m_stickersAppear)
		{
			m_stickersAppearLerp += Time.deltaTime * 0.5f;
			m_buttonStickers.GetComponent<Image>().color = m_stickersAppearEffect.Evaluate(m_stickersAppearLerp);
			if (m_stickersAppearLerp >= 1f)
			{
				m_stickersAppear = false;
			}
		}
		if (m_pan != panType.none)
		{
			m_panValue += Time.deltaTime;
			if (m_pan == panType.panIn)
			{
				float f = m_panCurve.Evaluate(Mathf.InverseLerp(1f, 0.35f, m_panValue)) * (m_panReverse ? 600f : (-600f));
				m_panRoot.localPosition = Vector2.up * Mathf.Round(f) + AlbumOffset();
				float num = Mathf.InverseLerp(1f, 0.5f, m_panValue);
				num *= num;
				m_hudFloating.sizeDelta = Vector2.one * Mathf.Round(60f * num) * 2f;
				if (m_panValue >= 1f)
				{
					GetComponent<CanvasGroup>().interactable = true;
					GetComponent<CanvasGroup>().blocksRaycasts = true;
					m_pan = panType.none;
					if (!m_newAlbum)
					{
						SetPrevNextButtons();
						EvalStartButton();
					}
				}
			}
			else if (m_pan == panType.panOut)
			{
				float f2 = m_panCurve.Evaluate(Mathf.InverseLerp(0f, 0.4f, m_panValue)) * (m_panReverse ? 600f : (-600f));
				m_panRoot.localPosition = Vector2.up * Mathf.Round(f2) + AlbumOffset();
				float num2 = Mathf.InverseLerp(0f, 0.5f, m_panValue);
				num2 *= num2;
				m_hudFloating.sizeDelta = Vector2.one * Mathf.Round(60f * num2) * 2f;
				if (m_panValue >= 1f)
				{
					base.gameObject.SetActive(value: false);
				}
			}
			else if (m_pan == panType.panLeft)
			{
				float num3 = Mathf.Pow(m_panValue, 2f) * -3000f;
				m_panRoot.localPosition = Vector2.right * Mathf.Round(num3) + AlbumOffset();
				m_checkerboard.localPosition = new Vector3(Mathf.Repeat(Mathf.Round(num3 * 0.0025f * 100f) / 100f, 0.64f), Mathf.Repeat(Mathf.Round(-150f) / 100f, 0.64f), 15f);
			}
			else if (m_pan == panType.photoPlace)
			{
				if (m_panPhase == 0)
				{
					m_stageDesc.Fade(0f);
					m_photoAddPostFX.weight = Mathf.Pow(Mathf.InverseLerp(1f, 0f, m_panValue), 2f);
					m_panValueAlt += Time.deltaTime * (m_panSticker ? (1f - m_photoAddStickerDelayCurve.Evaluate(m_panValueAlt)) : 1f);
					float time = Mathf.InverseLerp(3.5f, 0f, m_panValueAlt);
					float num4 = m_photoAddCurve.Evaluate(time) * (m_panSticker ? (-1600f) : (-900f));
					m_panRoot.localPosition = Vector2.up * Mathf.Round(num4) + AlbumOffset();
					m_checkerboard.localPosition = new Vector3(0f, Mathf.Repeat(Mathf.Round((num4 * 0.0025f + -1.5f) * 100f) / 100f, 0.64f), 15f);
					float num5 = Mathf.Round(m_photoAddRaisedCurve.Evaluate(time) * 6f);
					Vector2 vector = Vector2.Lerp(m_photoAddPhotoGoal, m_photoAddPhotoStart, m_photoAddMoveCurve.Evaluate(time));
					vector.x = Mathf.Round(vector.x);
					vector.y = Mathf.Round(vector.y);
					m_photoAddScaleNodes[1].anchoredPosition = vector + new Vector2(0f - num5, num5);
					vector.y -= Mathf.Round(num4);
					m_photoAddScaleNodes[2].anchoredPosition = vector + new Vector2(-6f, 6f);
					if (m_panValueAlt >= 3.5f)
					{
						m_photoAddNode.SetActive(value: false);
						m_photoAddShadowNode.SetActive(value: false);
						m_photoAddFrame.sprite = m_photoAddFrameArt[0];
						m_stagePreview.gameObject.SetActive(value: true);
						m_photoAddPostFX.enabled = false;
						m_panValue = 0f;
						m_panValueAlt = 0f;
						m_panPhase++;
					}
				}
				else if (m_panPhase == 1)
				{
					if (m_panValue >= 0.75f)
					{
						AkSoundEngine.PostEvent(m_manager.m_audioPhotoCaption, m_manager.gameObject);
						m_panValue = 0f;
						m_panPhase++;
					}
				}
				else if (m_panPhase == 2)
				{
					m_stageDesc.Fade(Mathf.InverseLerp(0f, 1.5f, m_panValue));
					if (m_panValue >= 1.5f)
					{
						SnapSeek(m_stage);
						GetComponent<CanvasGroup>().interactable = true;
						GetComponent<CanvasGroup>().blocksRaycasts = true;
						m_stageDesc.SetString();
						m_panValue = 0f;
						m_panPhase++;
						statsScript.StickerAwardEffect();
					}
				}
				else
				{
					float num6 = Mathf.InverseLerp(0.5f, 0f, m_panValue);
					num6 *= num6;
					m_hudFloating.sizeDelta = Vector2.one * Mathf.Round(60f * num6) * 2f;
					if (m_panValue >= 0.5f)
					{
						m_pan = panType.none;
						SetPrevNextButtons();
						EvalStartButton();
						m_buttonStickers.GetComponent<RectTransform>().SetParent(m_hudFloating, worldPositionStays: false);
						EvaulateVideoPulse(1f);
					}
				}
			}
		}
		if (!Mathf.Approximately(m_seekPage, m_seekPageTarget))
		{
			int num7 = Mathf.FloorToInt(m_seekPage);
			float value = Mathf.Abs(m_seekPage - (float)m_seekPageTarget);
			m_seekPage = Mathf.MoveTowards(m_seekPage, m_seekPageTarget, Time.deltaTime * Mathf.Lerp(1.5f, 3f, Mathf.InverseLerp(1f, 2f, value)));
			if (Mathf.Abs(m_seekPage - (float)m_seekPageTarget) < 0.01f)
			{
				m_seekPage = m_seekPageTarget;
				EvalStartButton();
			}
			else if (num7 < Mathf.FloorToInt(m_seekPage))
			{
				PlayPageSound((!(m_seekPage < 0f)) ? pageSound.pageTurnLeft : pageSound.albumOpen);
				SetupRenderTexture(num7 + 1);
			}
			else if (num7 > Mathf.FloorToInt(m_seekPage))
			{
				PlayPageSound((m_seekPage < 0f) ? pageSound.albumClose : pageSound.pageTurnRight);
				SetupRenderTexture(num7 - 1);
			}
			int num8 = Mathf.RoundToInt((m_seekPage + 1f) % 1f * 9f);
			if (m_seekPage < 0f)
			{
				if (num8 == 0)
				{
					m_stage = -1;
					SetStage(-1);
					CoverFrame(-1);
					m_pageShadow.enabled = false;
				}
				else
				{
					CoverFrame(9 - num8);
					float num9 = m_seekPage % 1f;
					if (num9 < -0.4f)
					{
						m_pageShadowColor.a = 0.4f * Mathf.InverseLerp(-0.2f, -0.9f, num9);
						m_pageShadow.color = m_pageShadowColor;
						m_pageShadow.enabled = true;
					}
					else
					{
						m_pageShadow.enabled = false;
					}
				}
				if (m_pan == panType.none)
				{
					int num10 = Mathf.RoundToInt(Mathf.InverseLerp(-0f, -1f, m_seekPage) * 11f);
					m_panRoot.localPosition = new Vector2(num10, 0f);
					int num11 = 0;
					switch (num8)
					{
					case 0:
						num11 = 11;
						break;
					case 1:
						num11 = 9;
						break;
					case 2:
						num11 = 6;
						break;
					case 3:
						num11 = 3;
						break;
					}
					RectTransform[] coverRoots = m_coverRoots;
					for (int i = 0; i < coverRoots.Length; i++)
					{
						coverRoots[i].anchoredPosition = Vector2.right * (num11 - num10);
					}
				}
			}
			else if (num8 == 0)
			{
				SetStage((int)m_seekPage);
				if (m_stage == 0)
				{
					CoverFrame(-1);
				}
				PageFrame(-1);
				m_pageShadow.enabled = false;
				if (m_pan == panType.none)
				{
					m_panRoot.localPosition = Vector3.zero;
				}
			}
			else
			{
				SetStage(Mathf.CeilToInt(m_seekPage));
				PageFrame(num8 - 1);
				float num12 = m_seekPage % 1f;
				if (num12 < 0.6f)
				{
					m_pageShadowColor.a = 0.3f * Mathf.InverseLerp(0.5f, 0.1f, num12);
					m_pageShadow.color = m_pageShadowColor;
					m_pageShadow.enabled = true;
				}
				else
				{
					m_pageShadow.enabled = false;
				}
				if (m_pan == panType.none)
				{
					int num13 = ((num8 < 2) ? 2 : ((num8 < 4) ? 1 : 0));
					m_panRoot.localPosition = new Vector2(num13, -num13);
				}
			}
		}
		if (m_pan == panType.none && Mathf.Approximately(m_seekPage, -1f) && Input.inputString.Length > 0 && m_albumCoverName.IsInteractable() && !m_albumCoverName.isFocused)
		{
			m_albumCoverName.text += Input.inputString;
			m_albumCoverName.Select();
		}
		if (m_videoPulse)
		{
			m_videoPulseValue += Time.deltaTime * 6f;
			float num14 = ((!m_videoPulseAnimate) ? 0.8f : ((m_videoPulseValue < 0f) ? 0.5f : (0.75f + Mathf.Cos(m_videoPulseValue) * -0.25f)));
			m_videoImage.color = new Color(num14, num14, num14);
		}
		if (!Mathf.Approximately(m_buttonNextLerp, m_buttonNextLerpTarget))
		{
			m_buttonNextLerp = Mathf.MoveTowards(m_buttonNextLerp, m_buttonNextLerpTarget, Time.deltaTime * 3f);
			SetButton(m_buttonNext, m_buttonNextLerp, Mathf.Approximately(m_buttonNextLerp, m_buttonNextLerpTarget));
		}
		if (!Mathf.Approximately(m_buttonPrevLerp, m_buttonPrevLerpTarget))
		{
			m_buttonPrevLerp = Mathf.MoveTowards(m_buttonPrevLerp, m_buttonPrevLerpTarget, Time.deltaTime * 3f);
			SetButton(m_buttonPrev, m_buttonPrevLerp, Mathf.Approximately(m_buttonPrevLerp, m_buttonPrevLerpTarget));
		}
		if ((m_confirmType != confirmType.none && m_confirmDeleteLerp < 1f) || (m_confirmType == confirmType.none && m_confirmDeleteLerp > 0f))
		{
			m_confirmDeleteLerp = Mathf.MoveTowards(m_confirmDeleteLerp, (m_confirmType != confirmType.none) ? 1f : 0f, Time.deltaTime * 4f);
			m_confirmDeleteDim.alpha = m_confirmDeleteLerp;
			if (m_confirmType == confirmType.record || (m_confirmType == confirmType.none && m_confirmRecordPanel.gameObject.activeSelf))
			{
				m_confirmRecordPanel.anchoredPosition = Vector2.up * Mathf.Round(Mathf.LerpUnclamped(-500f, 20f, m_confirmDeleteCurve.Evaluate(m_confirmDeleteLerp)));
			}
			else
			{
				m_confirmDeletePanel.anchoredPosition = Vector2.up * Mathf.Round(Mathf.LerpUnclamped(-500f, 20f, m_confirmDeleteCurve.Evaluate(m_confirmDeleteLerp)));
			}
			if (m_confirmType != confirmType.none && Mathf.Approximately(m_confirmDeleteLerp, 1f))
			{
				m_confirmDelete.GetComponent<CanvasGroup>().interactable = true;
				m_confirmDelete.GetComponent<CanvasGroup>().blocksRaycasts = true;
			}
			else if (m_confirmType == confirmType.none && Mathf.Approximately(m_confirmDeleteLerp, 0f))
			{
				m_confirmDelete.SetActive(value: false);
				GetComponent<CanvasGroup>().interactable = true;
				GetComponent<CanvasGroup>().blocksRaycasts = true;
			}
		}
		m_deselectingTextField = false;
	}

	private void EvaulateVideoPulse(float _offset = -0.2f)
	{
		if (gameStateScript.tutorialPlayback)
		{
			EndVideoPulse();
			return;
		}
		m_videoImage = m_buttonVideo.GetComponent<Image>();
		m_videoPulse = true;
		m_videoPulseValue = (0f - _offset) * 6f;
	}

	private void EndVideoPulse()
	{
		if (m_videoPulse)
		{
			m_videoImage.color = Color.grey;
			m_videoPulse = false;
			m_videoPulseValue = 0f;
		}
	}

	private void SetButton(GameObject _button, float _lerp, bool _finish)
	{
		Image component = _button.GetComponent<Image>();
		if (_lerp < 0f)
		{
			component.enabled = false;
		}
		else
		{
			component.enabled = true;
			component.sprite = m_buttonArrowFrames[Mathf.RoundToInt(_lerp * 4f)];
		}
		if (_finish)
		{
			if (_lerp > 0.5f)
			{
				component.raycastTarget = true;
				_button.GetComponent<Button>().interactable = true;
			}
			else
			{
				_button.SetActive(value: false);
			}
		}
	}

	public void AlbumSelect()
	{
		m_albumBackout = true;
		inputHandler.Instance.OnInputFieldExited(m_albumCoverName);
		m_buttonStart.Active(uiAlbumAdvanceScript.type.none);
		gameStateScript.DiskSaveNow();
		if (!string.IsNullOrEmpty(m_manager.m_audioAlbumReturnAction))
		{
			AkSoundEngine.PostEvent(m_manager.m_audioAlbumReturnAction, m_manager.gameObject);
		}
		if (m_newAlbum)
		{
			m_manager.AlbumSelect(albumStackScript.panInType.cancel);
		}
		else if (m_cloneAlbum)
		{
			m_manager.AlbumSelect(albumStackScript.panInType.cancelNoReturn);
		}
		else
		{
			m_manager.AlbumSelect(albumStackScript.panInType.bookDrop);
		}
		m_albumBackout = false;
	}

	public void StickerSheets()
	{
		inputHandler.Instance.OnInputFieldExited(m_albumCoverName);
		if (!string.IsNullOrEmpty(m_manager.m_audioShowStickers))
		{
			AkSoundEngine.PostEvent(m_manager.m_audioShowStickers, m_manager.gameObject);
		}
		GetComponent<CanvasGroup>().interactable = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_buttonStart.Active(uiAlbumAdvanceScript.type.none, _silent: true);
		gameStateScript.albumPage = m_stage;
		gameStateScript.SetAlbumLoadGame();
		gameStateScript.LoadSceneFade("stickers", 0.25f, _fadeUp: true);
	}

	public void PulseStickerButton()
	{
		m_stickersAppear = true;
		m_stickersAppearLerp = 0f;
		m_buttonStickers.GetComponent<Image>().color = Color.clear;
		Vector2 vector = m_buttonStickers.GetComponent<RectTransform>().sizeDelta * 0.5f;
		vector.y *= -1f;
		m_buttonStart.m_starSpawner.Burst(m_buttonStickers.GetComponent<RectTransform>().localPosition - m_buttonStart.m_starSpawner.GetComponent<RectTransform>().localPosition + (Vector3)vector);
	}

	private void CoverFrame(int _frame)
	{
		GameObject[] elements;
		for (int i = 0; i < m_frameCover.Length; i++)
		{
			elements = m_frameCover[i].m_elements;
			for (int j = 0; j < elements.Length; j++)
			{
				elements[j].SetActive(i == _frame);
			}
		}
		m_RenderTextureNodes[0].SetActive(value: false);
		m_RenderTextureNodes[1].SetActive(value: true);
		bool flag = _frame > -1 && m_frameCover[_frame].m_label != null;
		elements = m_pageRenderTexture;
		for (int j = 0; j < elements.Length; j++)
		{
			elements[j].SetActive(flag);
		}
		if (_frame != -1)
		{
			if (flag)
			{
				m_pageRenderTexturePivot.localRotation = Quaternion.AngleAxis(m_frameCover[_frame].m_angle, Vector3.up);
			}
			if (m_stage != 0)
			{
				SetStage(0);
			}
			m_albumCover1.SetActive(value: false);
		}
	}

	private void PageFrame(int _frame)
	{
		GameObject[] elements;
		for (int i = 0; i < m_framePage.Length; i++)
		{
			elements = m_framePage[i].m_elements;
			for (int j = 0; j < elements.Length; j++)
			{
				elements[j].SetActive(i == _frame);
			}
		}
		m_RenderTextureNodes[0].SetActive(value: true);
		m_RenderTextureNodes[1].SetActive(value: false);
		bool flag = _frame > -1 && m_framePage[_frame].m_label != null;
		elements = m_pageRenderTexture;
		for (int j = 0; j < elements.Length; j++)
		{
			elements[j].SetActive(flag);
		}
		if (_frame != -1)
		{
			if (flag)
			{
				m_pageRenderTexturePivot.localRotation = Quaternion.AngleAxis(m_framePage[_frame].m_angle, Vector3.up);
			}
			m_flippedPages[m_stage - 1].SetActive(value: false);
			Vector2 vector = ((m_stage > 1) ? (m_flippedPages[m_stage - 2].GetComponent<RectTransform>().anchoredPosition - m_flippedPages[0].GetComponent<RectTransform>().anchoredPosition) : Vector2.zero);
			RectTransform[] ringBackMasks = m_ringBackMasks;
			for (int j = 0; j < ringBackMasks.Length; j++)
			{
				ringBackMasks[j].anchoredPosition = vector;
			}
			ringBackMasks = m_ringBacks;
			for (int j = 0; j < ringBackMasks.Length; j++)
			{
				ringBackMasks[j].anchoredPosition = -vector;
			}
		}
	}

	public void ChangeStage(int _offset)
	{
		if (!GetComponent<CanvasGroup>().interactable)
		{
			return;
		}
		inputHandler.Instance.OnInputFieldExited(m_albumCoverName);
		int max = (m_newAlbum ? (-1) : Mathf.Max(m_completedStage - 1, saveData.GetLastStage()));
		int seekPageTarget = Mathf.Clamp(m_seekPageTarget + _offset, -1, max);
		if (Mathf.Approximately(m_seekPage, m_seekPageTarget) && Mathf.Abs(_offset) > 0)
		{
			if (m_stage == 0 && _offset < 0)
			{
				PlayPageSound(pageSound.albumClose);
			}
			else if (m_stage == -1 && _offset > 0)
			{
				PlayPageSound(pageSound.albumOpen);
			}
			else if (_offset > 0)
			{
				PlayPageSound(pageSound.pageTurnLeft);
				SetupRenderTexture(m_stage);
			}
		}
		m_seekPageTarget = seekPageTarget;
		if (m_seekPage != (float)m_seekPageTarget)
		{
			GameState.Set("photo", "page_turn_or_new");
			EvalStartButton(_hide: true);
		}
		SetPrevNextButtons();
	}

	private void PlayPageSound(pageSound _value)
	{
		switch (_value)
		{
		case pageSound.albumOpen:
			AkSoundEngine.PostEvent(m_manager.m_audioAlbumOpen, m_manager.gameObject);
			vibrationScript.Trigger(vibrationScript.moment.albumOpen);
			break;
		case pageSound.albumClose:
			AkSoundEngine.PostEvent(m_manager.m_audioAlbumClose, m_manager.gameObject);
			vibrationScript.Trigger(vibrationScript.moment.albumClose);
			break;
		default:
			AkSoundEngine.PostEvent(m_manager.m_audioAlbumPageTurn, m_manager.gameObject);
			vibrationScript.Trigger((_value == pageSound.pageTurnLeft) ? vibrationScript.moment.albumPageLeft : vibrationScript.moment.albumPageRight);
			break;
		}
	}

	private void SnapSeek(int _stage)
	{
		m_seekPageTarget = _stage;
		m_seekPage = _stage;
		SetStage(_stage);
	}

	private void HidePrevNextButtons(bool _instant = false)
	{
		m_buttonPrevLerpTarget = 0f;
		if (_instant)
		{
			m_buttonPrevLerp = m_buttonPrevLerpTarget;
			SetButton(m_buttonPrev, m_buttonPrevLerp, _finish: true);
		}
		m_buttonNextLerpTarget = 0f;
		if (_instant)
		{
			m_buttonNextLerp = m_buttonNextLerpTarget;
			SetButton(m_buttonNext, m_buttonNextLerp, _finish: true);
		}
	}

	public void EvalPrevNextButtons()
	{
		SetPrevNextButtons(_instant: true);
		EvalStartButton();
	}

	private void EvalStartButton(bool _hide = false)
	{
		if (!_hide && (m_newAlbum || (m_completedStage < 9 && m_stage == m_completedStage - 1 && !saveData.GetStageInProgress(m_stage + 1))))
		{
			m_buttonStart.Active((m_stage < 7) ? uiAlbumAdvanceScript.type.advance : (saveData.DarkStarValid() ? uiAlbumAdvanceScript.type.darkstar : uiAlbumAdvanceScript.type.star));
			return;
		}
		m_buttonStart.Active(uiAlbumAdvanceScript.type.none);
		if (!_hide)
		{
			GameState.Set("photo", "no_new_stage");
		}
	}

	private void SetPrevNextButtons(bool _instant = false)
	{
		bool flag = m_seekPageTarget > -1;
		m_buttonPrevLerpTarget = (flag ? 1f : 0f);
		if (_instant)
		{
			m_buttonPrevLerp = m_buttonPrevLerpTarget;
			SetButton(m_buttonPrev, m_buttonPrevLerp, _finish: true);
		}
		else if (flag)
		{
			m_buttonPrev.SetActive(value: true);
		}
		bool flag2 = m_seekPageTarget < m_completedStage - 1 || saveData.GetStageInProgress(m_seekPageTarget + 1);
		m_buttonNextLerpTarget = (flag2 ? 1f : 0f);
		if (_instant)
		{
			m_buttonNextLerp = m_buttonNextLerpTarget;
			SetButton(m_buttonNext, m_buttonNextLerp, _finish: true);
			return;
		}
		float delay = m_buttonStart.delay;
		if (delay > 0f)
		{
			m_buttonNextLerp = delay * -3f - 1f;
		}
		if (flag2)
		{
			m_buttonNext.SetActive(value: true);
		}
	}

	private void SetStage(int _stage)
	{
		if (_stage != m_stage)
		{
			m_videoPulseValue = Mathf.Min(m_videoPulseValue, ((float)_stage < 0f) ? 0f : (-4f));
		}
		RectTransform[] backCoverOffset;
		if (_stage == -1)
		{
			m_albumCover.SetActive(value: true);
			m_albumCover1.SetActive(value: false);
			m_albumCover2.SetActive(value: true);
			m_stage = -1;
			if (m_newAlbum || string.IsNullOrEmpty(m_name))
			{
				m_buttonDelete.SetActive(value: false);
				m_buttonClone.SetActive(value: false);
			}
			else
			{
				m_buttonDelete.SetActive(value: true);
				m_buttonClone.SetActive(value: true);
				m_buttonClone.GetComponent<Button>().interactable = saveData.SaveCount < 5;
			}
			m_buttonPlay.SetActive(value: false);
			m_buttonStartOver.SetActive(value: false);
			m_buttonVideo.SetActive(value: false);
			backCoverOffset = m_backCoverOffset;
			for (int i = 0; i < backCoverOffset.Length; i++)
			{
				backCoverOffset[i].localPosition = Vector2.zero;
			}
			for (int j = 0; j < m_ringFronts.Length; j++)
			{
				m_ringFronts[j].localPosition = new Vector2(21f, -16f);
			}
			m_pageBack.localPosition = Vector2.zero;
			backCoverOffset = m_ringBackMasks;
			for (int i = 0; i < backCoverOffset.Length; i++)
			{
				backCoverOffset[i].anchoredPosition = Vector2.zero;
			}
			for (int k = 0; k < m_flippedPages.Length; k++)
			{
				m_flippedPages[k].SetActive(value: false);
			}
			return;
		}
		if (m_completedStage < _stage)
		{
			Debug.LogWarning("stage " + _stage + " hasn't been reached yet");
			return;
		}
		m_albumCover.SetActive(value: false);
		m_albumCover1.SetActive(value: true);
		m_albumCover2.SetActive(value: false);
		m_buttonDelete.SetActive(value: false);
		m_buttonClone.SetActive(value: false);
		m_buttonPlay.SetActive(value: true);
		backCoverOffset = m_backCoverOffset;
		for (int i = 0; i < backCoverOffset.Length; i++)
		{
			backCoverOffset[i].localPosition = new Vector2((float)_stage * -2f, (float)_stage * 2f);
		}
		for (int l = 0; l < m_ringFronts.Length; l++)
		{
			m_ringFronts[l].localPosition = new Vector2(21f + (float)_stage * -2f, -16f + (float)_stage * 2f);
		}
		m_pageBack.anchoredPosition = new Vector2((float)_stage * -2f, (float)_stage * 2f);
		m_pageRoot.anchoredPosition = new Vector2((float)_stage * -2f, (float)_stage * 2f);
		Vector2 vector = ((_stage > 1) ? (m_flippedPages[_stage - 1].GetComponent<RectTransform>().anchoredPosition - m_flippedPages[0].GetComponent<RectTransform>().anchoredPosition) : Vector2.zero);
		backCoverOffset = m_ringBackMasks;
		for (int i = 0; i < backCoverOffset.Length; i++)
		{
			backCoverOffset[i].anchoredPosition = vector;
		}
		backCoverOffset = m_ringBacks;
		for (int i = 0; i < backCoverOffset.Length; i++)
		{
			backCoverOffset[i].anchoredPosition = -vector;
		}
		for (int m = 0; m < m_flippedPages.Length; m++)
		{
			m_flippedPages[m].SetActive(m < _stage);
		}
		if (_stage > 7)
		{
			m_stage = 8;
			m_stagePreview.gameObject.SetActive(value: false);
			m_stagePreviewCredits.sprite = m_stagePreviewCreditsArt[0];
			m_stagePreviewCredits.gameObject.SetActive(value: true);
			m_buttonStartOver.SetActive(value: false);
			m_buttonVideo.SetActive(value: false);
			m_stageMonthYear.SetString("");
			m_stageDesc.SetString(saveData.DarkStarClear() ? "album_credits_darkstar" : "album_credits");
			return;
		}
		saveData.saveDataStage stage = saveData.GetStage(_stage);
		if (stage.zones == null || stage.zones.Length == 0)
		{
			Debug.LogWarning("no data found for stage " + _stage);
			return;
		}
		m_stage = _stage;
		m_stagePreviewCredits.gameObject.SetActive(value: false);
		m_stagePreviewTex.LoadImage(stage.image);
		m_stagePreview.texture = m_stagePreviewTex;
		m_stagePreview.color = Color.white;
		m_stagePreview.gameObject.SetActive(value: true);
		m_buttonStartOver.SetActive(value: true);
		m_buttonVideo.SetActive(stage.history != null && stage.history.Length > 5 && gameStateScript.CompareChecksums(_stage, _strict: true));
		m_stageMonthYear.SetString((new string[8] { "album_childroom_date", "album_studioapt_date", "album_sharehouse_date", "album_boyfriendapt_date", "album_parenthouse_date", "album_soloapt_date", "album_partnerapt_date", "album_house_date" })[m_stage]);
		if (stage.state == 1)
		{
			m_stageDesc.SetString("");
		}
		else if (stage.state == 2)
		{
			switch (m_stage)
			{
			case 0:
				m_stageDesc.SetString("album_childroom_bedroom");
				break;
			case 1:
				m_stageDesc.SetString("album_studioapt_" + (new string[3] { "bedroom", "bathroom", "kitchenette" })[stage.zone]);
				break;
			case 2:
				m_stageDesc.SetString("album_sharehouse_" + (new string[5] { "livingroom", "kitchen", "bathroom", "bedroom", "diningroom" })[stage.zone]);
				break;
			case 3:
				m_stageDesc.SetString("album_boyfriendapt_" + (new string[4] { "livingroom", "bedroom", "bathroom", "kitchen" })[stage.zone]);
				break;
			case 4:
				m_stageDesc.SetString("album_parenthouse_" + (new string[2] { "bedroom", "bathroom" })[stage.zone]);
				break;
			case 5:
				m_stageDesc.SetString("album_soloapt_" + (new string[5] { "livingroom", "bathroom", "bedroom", "office", "kitchen" })[stage.zone]);
				break;
			case 6:
				m_stageDesc.SetString("album_partnerapt_" + (new string[5] { "livingroom", "bathroom", "bedroom", "office", "kitchen" })[stage.zone]);
				break;
			case 7:
				m_stageDesc.SetString("album_house_" + (new string[10] { "foyer", "bathroom", "closet", "bedroom", "nursery", "toilet", "office", "diningroom", "kitchen", "livingroom" })[stage.zone]);
				break;
			}
		}
		else if (stage.state == 3)
		{
			switch (m_stage)
			{
			case 0:
				m_stageDesc.SetString("album_childroom_darkstar");
				break;
			case 1:
				m_stageDesc.SetString("album_studioapt_darkstar");
				break;
			case 2:
				m_stageDesc.SetString("album_sharehouse_darkstar");
				break;
			case 3:
				m_stageDesc.SetString("album_boyfriendapt_darkstar");
				break;
			case 4:
				m_stageDesc.SetString("album_parenthouse_darkstar");
				break;
			case 5:
				m_stageDesc.SetString("album_soloapt_darkstar");
				break;
			case 6:
				m_stageDesc.SetString("album_partnerapt_darkstar");
				break;
			case 7:
				m_stageDesc.SetString("album_house_darkstar");
				break;
			}
		}
	}

	private void SetupRenderTexture(int _stage)
	{
		if (_stage < 0)
		{
			return;
		}
		saveData.saveDataStage stage = saveData.GetStage(_stage);
		m_pageRenderTextureSource.LoadImage(stage.image);
		m_pageRenderTexturePhoto.texture = m_pageRenderTextureSource;
		m_pageRenderTextureText[0].SetString((new string[8] { "album_childroom_date", "album_studioapt_date", "album_sharehouse_date", "album_boyfriendapt_date", "album_parenthouse_date", "album_soloapt_date", "album_partnerapt_date", "album_house_date" })[_stage]);
		if (stage.state == 1)
		{
			m_pageRenderTextureText[1].SetString("");
		}
		else if (stage.state == 2)
		{
			switch (_stage)
			{
			case 0:
				m_pageRenderTextureText[1].SetString("album_childroom_bedroom");
				break;
			case 1:
				m_pageRenderTextureText[1].SetString("album_studioapt_" + (new string[3] { "bedroom", "bathroom", "kitchenette" })[stage.zone]);
				break;
			case 2:
				m_pageRenderTextureText[1].SetString("album_sharehouse_" + (new string[5] { "livingroom", "kitchen", "bathroom", "bedroom", "diningroom" })[stage.zone]);
				break;
			case 3:
				m_pageRenderTextureText[1].SetString("album_boyfriendapt_" + (new string[4] { "livingroom", "bedroom", "bathroom", "kitchen" })[stage.zone]);
				break;
			case 4:
				m_pageRenderTextureText[1].SetString("album_parenthouse_" + (new string[2] { "bedroom", "bathroom" })[stage.zone]);
				break;
			case 5:
				m_pageRenderTextureText[1].SetString("album_soloapt_" + (new string[5] { "livingroom", "bathroom", "bedroom", "office", "kitchen" })[stage.zone]);
				break;
			case 6:
				m_pageRenderTextureText[1].SetString("album_partnerapt_" + (new string[5] { "livingroom", "bathroom", "bedroom", "office", "kitchen" })[stage.zone]);
				break;
			case 7:
				m_pageRenderTextureText[1].SetString("album_house_" + (new string[10] { "foyer", "bathroom", "closet", "bedroom", "nursery", "toilet", "office", "diningroom", "kitchen", "livingroom" })[stage.zone]);
				break;
			}
		}
		else if (stage.state == 3)
		{
			switch (_stage)
			{
			case 0:
				m_pageRenderTextureText[1].SetString("album_childroom_darkstar");
				break;
			case 1:
				m_pageRenderTextureText[1].SetString("album_studioapt_darkstar");
				break;
			case 2:
				m_pageRenderTextureText[1].SetString("album_sharehouse_darkstar");
				break;
			case 3:
				m_pageRenderTextureText[1].SetString("album_boyfriendapt_darkstar");
				break;
			case 4:
				m_pageRenderTextureText[1].SetString("album_parenthouse_darkstar");
				break;
			case 5:
				m_pageRenderTextureText[1].SetString("album_soloapt_darkstar");
				break;
			case 6:
				m_pageRenderTextureText[1].SetString("album_partnerapt_darkstar");
				break;
			case 7:
				m_pageRenderTextureText[1].SetString("album_house_darkstar");
				break;
			}
		}
	}

	private bool PageTurning()
	{
		return !Mathf.Approximately(m_seekPage, m_seekPageTarget);
	}

	public void StartStage()
	{
		if (!PageTurning())
		{
			string text = ((m_stage < 7) ? m_manager.m_audioStageStart : (saveData.DarkStarValid() ? m_manager.m_audioDarkStarStart : m_manager.m_audioStarStart));
			if (!string.IsNullOrEmpty(text))
			{
				AkSoundEngine.PostEvent(text, m_manager.gameObject);
			}
			m_buttonStart.Active(uiAlbumAdvanceScript.type.none, _silent: true);
			vibrationScript.Trigger(vibrationScript.moment.stageBeginAction);
			if (m_newAlbum)
			{
				saveData.NewSave(m_name, m_albumColorIndex);
			}
			else if (m_stage == 7)
			{
				saveData.SaveComplete(saveData.DarkStarValid());
			}
			string[] obj = new string[9] { "1_childRoom", "2_studioApt", "3_shareHouse", "4_boyfriendApt", "5_parentHouse", "6_soloApt", "7_partnerApt", "8_house", "9_credits" };
			PanLeft();
			base.transform.parent.GetComponent<CanvasGroup>().interactable = false;
			gameStateScript.LoadSceneFade(obj[m_stage + 1], 0.5f);
		}
	}

	public void LoadStage()
	{
		if (!PageTurning())
		{
			m_buttonStart.Active(uiAlbumAdvanceScript.type.none, _silent: true);
			if (m_stage < 8 && !gameStateScript.CompareChecksums(m_stage))
			{
				SaveError();
				return;
			}
			AkSoundEngine.PostEvent(m_manager.m_audioStageLoad, m_manager.gameObject);
			gameStateScript.SetLoadStage();
			string[] obj = new string[9] { "1_childRoom", "2_studioApt", "3_shareHouse", "4_boyfriendApt", "5_parentHouse", "6_soloApt", "7_partnerApt", "8_house", "9_credits" };
			base.transform.parent.GetComponent<CanvasGroup>().interactable = false;
			gameStateScript.LoadSceneFade(obj[m_stage], 0.25f);
		}
	}

	public void DeleteAlbum()
	{
		GetComponent<CanvasGroup>().interactable = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		inputHandler.Instance.OnInputFieldExited(m_albumCoverName);
		AkSoundEngine.PostEvent(m_manager.m_audioDialogShow, m_manager.gameObject);
		m_confirmType = confirmType.deleteAlbum;
		m_confirmDeletePanel.gameObject.SetActive(value: true);
		m_confirmRecordPanel.gameObject.SetActive(value: false);
		float num = m_confirmText.SetString("menu_album_delete_prompt");
		Vector2 sizeDelta = m_confirmDeletePanel.sizeDelta;
		sizeDelta.x = Mathf.Max(500f, num + 20f);
		m_confirmDeletePanel.sizeDelta = sizeDelta;
		if (!m_confirmDelete.activeSelf)
		{
			m_confirmDeleteDim.alpha = 0f;
			m_confirmDeletePanel.anchoredPosition = Vector2.up * -500f;
			m_confirmDelete.SetActive(value: true);
		}
	}

	public void StartOver()
	{
		if (!PageTurning())
		{
			GetComponent<CanvasGroup>().interactable = false;
			GetComponent<CanvasGroup>().blocksRaycasts = false;
			AkSoundEngine.PostEvent(m_manager.m_audioDialogShow, m_manager.gameObject);
			m_confirmType = confirmType.restartStage;
			m_confirmDeletePanel.gameObject.SetActive(value: true);
			m_confirmRecordPanel.gameObject.SetActive(value: false);
			float num = m_confirmText.SetString("menu_startover_prompt");
			Vector2 sizeDelta = m_confirmDeletePanel.sizeDelta;
			sizeDelta.x = Mathf.Max(500f, num + 20f);
			m_confirmDeletePanel.sizeDelta = sizeDelta;
			if (!m_confirmDelete.activeSelf)
			{
				m_confirmDeleteDim.alpha = 0f;
				m_confirmDeletePanel.anchoredPosition = Vector2.up * -500f;
				m_confirmDelete.SetActive(value: true);
			}
		}
	}

	public void SaveError()
	{
		GetComponent<CanvasGroup>().interactable = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		AkSoundEngine.PostEvent(m_manager.m_audioDialogShow, m_manager.gameObject);
		m_confirmType = confirmType.saveError;
		m_confirmDeletePanel.gameObject.SetActive(value: true);
		m_confirmRecordPanel.gameObject.SetActive(value: false);
		float num = m_confirmText.SetString("menu_saveerror_prompt");
		Vector2 sizeDelta = m_confirmDeletePanel.sizeDelta;
		sizeDelta.x = Mathf.Max(500f, num + 20f);
		m_confirmDeletePanel.sizeDelta = sizeDelta;
		if (!m_confirmDelete.activeSelf)
		{
			m_confirmDeleteDim.alpha = 0f;
			m_confirmDeletePanel.anchoredPosition = Vector2.up * -500f;
			m_confirmDelete.SetActive(value: true);
		}
	}

	public void ConfirmAction(bool _value)
	{
		m_confirmDelete.GetComponent<CanvasGroup>().interactable = false;
		m_confirmDelete.GetComponent<CanvasGroup>().blocksRaycasts = false;
		if (_value)
		{
			AkSoundEngine.PostEvent(m_manager.m_audioDialogYes, base.gameObject);
			if (m_confirmType == confirmType.deleteAlbum)
			{
				saveData.Delete();
				base.transform.parent.GetComponent<albumManagerScript>().AlbumSelect(albumStackScript.panInType.delete);
				GetComponent<CanvasGroup>().interactable = true;
				GetComponent<CanvasGroup>().blocksRaycasts = true;
			}
			else if (m_confirmType == confirmType.restartStage || m_confirmType == confirmType.saveError)
			{
				string[] obj = new string[8] { "1_childRoom", "2_studioApt", "3_shareHouse", "4_boyfriendApt", "5_parentHouse", "6_soloApt", "7_partnerApt", "8_house" };
				base.transform.parent.GetComponent<CanvasGroup>().interactable = false;
				gameStateScript.LoadSceneFade(obj[m_stage], 0.25f);
			}
		}
		else
		{
			AkSoundEngine.PostEvent(m_manager.m_audioDialogNo, base.gameObject);
		}
		m_confirmType = confirmType.none;
	}

	public void Playback()
	{
		if (!PageTurning())
		{
			gameStateScript.tutorialPlayback = true;
			EndVideoPulse();
			GetComponent<CanvasGroup>().interactable = false;
			GetComponent<CanvasGroup>().blocksRaycasts = false;
			if (!string.IsNullOrEmpty(m_manager.m_audioPlaybackDialogShow))
			{
				AkSoundEngine.PostEvent(m_manager.m_audioPlaybackDialogShow, m_manager.gameObject);
			}
			m_confirmType = confirmType.record;
			m_confirmDeletePanel.gameObject.SetActive(value: false);
			m_confirmRecordPanel.gameObject.SetActive(value: true);
			if (!m_confirmDelete.activeSelf)
			{
				m_confirmDeleteDim.alpha = 0f;
				m_confirmRecordPanel.anchoredPosition = Vector2.up * -500f;
				m_confirmDelete.SetActive(value: true);
			}
		}
	}

	public void PlaybackAction(int _result)
	{
		if (_result > 0)
		{
			m_buttonStart.Active(uiAlbumAdvanceScript.type.none, _silent: true);
			if (!string.IsNullOrEmpty(m_manager.m_audioPlaybackDialogStart))
			{
				AkSoundEngine.PostEvent(m_manager.m_audioPlaybackDialogStart, base.gameObject);
			}
			string[] obj = new string[8] { "1_childRoom", "2_studioApt", "3_shareHouse", "4_boyfriendApt", "5_parentHouse", "6_soloApt", "7_partnerApt", "8_house" };
			gameStateScript.SetPlaybackStage(Mathf.Clamp(_result, 1, 3));
			AkSoundEngine.SetState("Music_State", "None");
			base.transform.parent.GetComponent<CanvasGroup>().interactable = false;
			gameStateScript.LoadSceneFade(obj[m_stage], 0.25f);
		}
		else if (!string.IsNullOrEmpty(m_manager.m_audioPlaybackDialogClose))
		{
			AkSoundEngine.PostEvent(m_manager.m_audioPlaybackDialogClose, base.gameObject);
		}
		m_confirmType = confirmType.none;
	}
}
