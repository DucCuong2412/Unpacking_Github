using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.UI;

public class photoModeScript : MonoBehaviour
{
	private enum state
	{
		normal = 0,
		hiddenHud = 1,
		borderMode = 2,
		filterMode = 3,
		stickerMode = 4,
		stickerPlace = 5
	}

	private enum tabState
	{
		none = 0,
		showing = 1,
		expanding = 2,
		retracting = 3
	}

	private bool m_menuVisible = true;

	private bool m_menuWasVisible;

	private state m_state;

	private state m_stateNext;

	private state m_lastActiveMode;

	public photoModeData m_data;

	public stickerData m_stickerData;

	public Material[] m_stickerMats;

	private int[] m_stickerSheetPages = new int[0];

	private int m_stickerSheetCurrent;

	private Button[] m_stickerSheet;

	private int[] m_stickerSheetIDs;

	public Transform m_stickerPrefab;

	private Transform m_currentSticker;

	private Vector2 m_currentOffset;

	private List<Transform> m_currentStickers = new List<Transform>();

	private bool m_currentFrame;

	private bool m_wasTouchOverUI;

	private bool m_ignoreCursorPress;

	[Range(0f, 1f)]
	public float m_touchStickerHoldDuration = 0.5f;

	private float m_touchStickerHoldTimer;

	[Range(0f, 100f)]
	public float m_touchStickerHoldRadius = 1f;

	private Vector2 m_touchStickerHoldStartPos = Vector2.zero;

	private bool m_stickerWaitingForTouch;

	private bool m_stickerPointerWasPressedOverUI;

	public gameUIScript m_uiScript;

	public CanvasGroup m_hud;

	public CanvasGroup m_controlsBack;

	private float m_controlsBackFade;

	private float m_controlsBackFadeTarget;

	public CanvasGroup m_controls;

	private float m_controlsCrossfade;

	private float m_controlsCrossfadeTarget;

	public Button[] m_controlsZoom;

	public RectTransform m_tab;

	public RectTransform[] m_tabs;

	public RectTransform m_tabUnder;

	public RectTransform m_tabOver;

	private tabState m_tabState;

	private float m_tabLerp;

	private float m_tabTarget = 187f;

	public AnimationCurve m_tabAnimOut;

	public AnimationCurve m_tabAnimIn;

	public Transform m_tabOptionPrefab;

	public RectTransform m_tabSelect;

	public Transform m_tabStickerPrefab;

	public RectTransform m_tabStickers;

	public RectTransform m_tabStickerLayer;

	public RectTransform m_tabStickersSheet;

	private int m_tabStickersSheetAction;

	private float m_tabStickersSheetLerp;

	private GameObject[] m_tabStickersToDelete;

	public AnimationCurve m_tabStickersSheetAnim;

	public Graphic m_tabStickersSheetShadow;

	public Button[] m_tabStickersPageChange;

	public CanvasGroup m_tabStickersMode;

	public CanvasGroup m_tabStickersPlace;

	private bool m_tabStickerModifiersHover;

	private bool m_ignoreStickerDestroyThisFrame;

	private float m_tabHide;

	private float m_tabHideTarget;

	public RectTransform m_tabBorders;

	private int m_currentBorder;

	public RectTransform m_tabFilters;

	private int m_currentFilter;

	public Animation m_flash;

	public SpriteRenderer m_pixelMesh;

	public uiSliderGeneric m_sliderFilter;

	public PostProcessVolume m_filter;

	private bool m_filterHideGradient;

	private float m_filterMeshStrength;

	private Material m_filterMat;

	public Transform m_border;

	private Transform m_activeBorder;

	public Transform m_stickers;

	private Vector2 m_pan = Vector2.zero;

	private bool m_panActive;

	private float m_panCooldown;

	private int m_panHorizontal;

	private int m_panVertical;

	private float m_panSpeed = 2f;

	private float m_zoom = 1f;

	private float m_zoomTarget = 1f;

	public GameObject m_exitConfirm;

	private bool m_exitConfirmActive;

	private float m_exitConfirmLerp;

	private bool m_controlsActive = true;

	private CanvasScaler m_canvasScaler;

	public RectTransform m_screenshotTextHolder;

	public TextMeshProUGUI m_screenshotText;

	private float m_screenshotTextTimer;

	private List<Graphic> m_queuedPlacedStickers = new List<Graphic>();

	private bool IsCursorVisible
	{
		get
		{
			switch (inputHandler.CurrentControllerInputType)
			{
			case inputHandler.ControllerInputType.Keyboard:
				return true;
			case inputHandler.ControllerInputType.Gamepad:
				return !m_exitConfirmActive;
			case inputHandler.ControllerInputType.Touch:
				return false;
			default:
				return true;
			}
		}
	}

	private void Start()
	{
		m_pixelMesh.transform.parent = null;
		m_pixelMesh.transform.localPosition = Vector3.zero;
		m_sliderFilter.SetSlide(0f, this);
		m_sliderFilter.Enable(_value: false);
		for (int i = 0; i < m_data.m_borders.Length; i++)
		{
			RectTransform obj = UnityEngine.Object.Instantiate(m_tabOptionPrefab, m_tabBorders) as RectTransform;
			int num = 9 + i % 3 * 60;
			int num2 = -56 - i / 3 * 60;
			int index = i;
			obj.anchoredPosition = new Vector2(num, num2);
			obj.GetComponent<Image>().sprite = m_data.m_borders[i].icon;
			obj.GetComponent<Button>().onClick.AddListener(delegate
			{
				SetSelect(0, index);
			});
		}
		for (int num3 = 0; num3 < m_data.m_filters.Length; num3++)
		{
			RectTransform obj2 = UnityEngine.Object.Instantiate(m_tabOptionPrefab, m_tabFilters) as RectTransform;
			int num4 = 9 + num3 % 3 * 60;
			int num5 = -56 - num3 / 3 * 60;
			int index2 = num3;
			obj2.anchoredPosition = new Vector2(num4, num5);
			obj2.GetComponent<Image>().sprite = m_data.m_filters[num3].icon;
			obj2.GetComponent<Button>().onClick.AddListener(delegate
			{
				SetSelect(1, index2);
			});
		}
		MeshRenderer component = m_uiScript.m_game.transform.Find("grad").GetComponent<MeshRenderer>();
		m_filterMat = component.material;
		component.material = m_filterMat;
	}

	public void AdvanceStickerPage(int _direction)
	{
		if (m_tabStickersSheetAction != 0 || m_stickerSheetPages.Length <= 1)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < m_stickerSheetPages.Length; i++)
		{
			if (m_stickerSheetPages[i] == m_stickerSheetCurrent)
			{
				num = i;
				break;
			}
		}
		num += _direction;
		if (num >= m_stickerSheetPages.Length)
		{
			num = 0;
		}
		else if (num < 0)
		{
			num = m_stickerSheetPages.Length - 1;
		}
		m_stickerSheetCurrent = m_stickerSheetPages[num];
		m_tabStickersSheetShadow.enabled = true;
		m_tabStickersSheetShadow.color = ((_direction > 0) ? (Color.black * 0.2f) : Color.clear);
		m_tabStickersSheet.gameObject.SetActive(value: true);
		m_tabStickersSheet.localPosition = Vector2.zero;
		m_tabStickersToDelete = new GameObject[m_stickerSheet.Length];
		for (int j = 0; j < m_stickerSheet.Length; j++)
		{
			m_stickerSheet[j].interactable = false;
			m_tabStickersToDelete[j] = m_stickerSheet[j].gameObject;
			if (_direction > 0)
			{
				m_stickerSheet[j].GetComponent<RectTransform>().SetParent(m_tabStickersSheet);
			}
		}
		PrepareStickerPage(m_stickerSheetCurrent);
		RefreshStickerUINavigation(_direction < 0);
		if (_direction < 0)
		{
			for (int k = 0; k < m_stickerSheet.Length; k++)
			{
				m_stickerSheet[k].GetComponent<RectTransform>().SetParent(m_tabStickersSheet);
			}
			m_tabStickersSheet.localPosition = Vector2.right * -190f;
		}
		m_tabStickersSheetAction = _direction;
		m_tabStickersSheetLerp = 0f;
		AkSoundEngine.PostEvent((_direction > 0) ? m_uiScript.m_audioStickerPageForward : m_uiScript.m_audioStickerPageBackward, m_tabStickersSheet.gameObject);
	}

	private void PrepareStickerPage(int _page)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < m_stickerData.stickers.Length; i++)
		{
			if (m_stickerData.stickers[i].page == _page)
			{
				list.Add(i);
			}
		}
		m_stickerSheet = new Button[list.Count];
		for (int j = 0; j < list.Count; j++)
		{
			RectTransform rectTransform = UnityEngine.Object.Instantiate(m_tabStickerPrefab, m_tabStickersMode.GetComponent<RectTransform>()) as RectTransform;
			Vector2 position = m_stickerData.stickers[list[j]].position;
			position.y *= -1f;
			position.y -= 27f;
			rectTransform.anchoredPosition = position;
			rectTransform.GetComponent<Image>().sprite = m_stickerData.stickers[list[j]].sprite;
			rectTransform.GetComponent<Image>().SetNativeSize();
			int id = j;
			m_stickerSheet[j] = rectTransform.GetComponent<Button>();
			m_stickerSheet[j].onClick.AddListener(delegate
			{
				PickSticker(id);
			});
			if (!saveData.StickerUnlocked(list[j]))
			{
				m_stickerSheet[j].interactable = false;
				m_stickerSheet[j].GetComponent<Image>().material = m_stickerMats[1];
			}
		}
		m_stickerSheetIDs = list.ToArray();
	}

	private void RefreshStickerUINavigation(bool selectLast)
	{
		uiGamepadNavigationGroup component = m_tabStickersMode.GetComponent<uiGamepadNavigationGroup>();
		if (component == null)
		{
			return;
		}
		component.Refresh();
		if (inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Gamepad)
		{
			return;
		}
		uiGamepadNavigationElement uiGamepadNavigationElement2 = null;
		List<uiGamepadNavigationElement> list = new List<uiGamepadNavigationElement>(component.GetComponentsInChildren<uiGamepadNavigationElement>());
		if (selectLast)
		{
			list.Reverse();
		}
		foreach (uiGamepadNavigationElement item in list)
		{
			if (!item.denyAutoSelect && !(item.Selectable == null) && item.Selectable.IsInteractable() && item.Selectable.navigation.mode != Navigation.Mode.None && uiGamepadNavigationElement2 == null)
			{
				uiGamepadNavigationElement2 = item;
				break;
			}
		}
		if (uiGamepadNavigationElement2 != null)
		{
			uiGamepadNavigationElement2.Select();
		}
	}

	private void EvaluateStickerPages()
	{
		List<int> list = new List<int>();
		for (int i = 0; i < m_stickerData.stickers.Length; i++)
		{
			if (!list.Contains(m_stickerData.stickers[i].page) && saveData.StickerUnlocked(i))
			{
				list.Add(m_stickerData.stickers[i].page);
			}
		}
		m_stickerSheetPages = list.ToArray();
		for (int j = 0; j < m_tabStickersPageChange.Length; j++)
		{
			m_tabStickersPageChange[j].interactable = m_stickerSheetPages.Length > 1;
		}
	}

	private void RefreshStickers()
	{
		int num = -1;
		if (m_currentSticker != null)
		{
			Sprite sprite = m_currentSticker.GetComponent<Image>().sprite;
			for (int i = 0; i < m_stickerData.stickers.Length; i++)
			{
				if (m_stickerData.stickers[i].sprite == sprite)
				{
					num = i;
					break;
				}
			}
		}
		for (int j = 0; j < m_stickerSheet.Length; j++)
		{
			bool flag = saveData.StickerUnlocked(m_stickerSheetIDs[j]);
			if (m_stickerSheetIDs[j] == num || !flag)
			{
				m_stickerSheet[j].GetComponent<Graphic>().material = m_stickerMats[1];
			}
			else
			{
				m_stickerSheet[j].GetComponent<Graphic>().material = m_stickerMats[0];
			}
			m_stickerSheet[j].interactable = flag && m_state != state.stickerPlace;
		}
	}

	public void ClickSticker()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoTabClick, base.gameObject);
		if (m_state != state.stickerMode)
		{
			ChangeState(state.stickerMode);
		}
		else
		{
			ChangeState(state.normal);
		}
	}

	public void ClickBorder()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoTabClick, base.gameObject);
		if (m_state != state.borderMode)
		{
			ChangeState(state.borderMode);
		}
		else
		{
			ChangeState(state.normal);
		}
	}

	public void ClickFilter()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoTabClick, base.gameObject);
		if (m_state != state.filterMode)
		{
			ChangeState(state.filterMode);
		}
		else
		{
			ChangeState(state.normal);
		}
	}

	private void ChangeState(state _newState)
	{
		Debug.Log("CHANGE STATE : currently " + m_state.ToString() + " changing to " + _newState);
		m_stateNext = _newState;
		switch (_newState)
		{
		case state.borderMode:
		case state.filterMode:
		case state.stickerMode:
			m_lastActiveMode = _newState;
			ShowControlBack(_show: false);
			break;
		case state.normal:
			EventSystem.current.SetSelectedGameObject(null);
			ShowControlBack(_show: true);
			break;
		}
	}

	private void SetState(state _newState)
	{
		if (_newState == state.stickerMode)
		{
			m_tabStickersMode.interactable = true;
			m_tabStickersMode.blocksRaycasts = true;
		}
		else
		{
			m_tabStickersMode.interactable = false;
			m_tabStickersMode.blocksRaycasts = false;
		}
		if (_newState == state.stickerPlace)
		{
			if (m_state == state.normal || m_state == state.stickerMode)
			{
				SetTab(0);
				m_tabHideTarget = 1f;
			}
			else
			{
				TabRetract();
			}
		}
		else
		{
			m_tabHideTarget = 0f;
		}
		m_controls.blocksRaycasts = _newState != state.stickerPlace;
		m_tabStickersPlace.blocksRaycasts = _newState == state.stickerPlace;
		m_controlsCrossfadeTarget = ((_newState == state.stickerPlace) ? 1f : 0f);
		m_controlsZoom[0].interactable = _newState != state.stickerPlace;
		m_controlsZoom[1].interactable = _newState != state.stickerPlace;
		ShowControlBack(_newState == state.normal);
		m_stickers.GetComponent<CanvasGroup>().blocksRaycasts = _newState != state.stickerPlace;
		m_state = _newState;
		m_stateNext = _newState;
		if (m_state == state.stickerPlace || m_state == state.stickerMode)
		{
			RefreshStickers();
			uiGamepadNavigationGroup component = m_tabStickersMode.GetComponent<uiGamepadNavigationGroup>();
			if (component != null)
			{
				component.enabled = _newState == state.stickerMode;
			}
		}
		gameStateScript.GetCursor()?.ShowCursor(IsCursorVisible);
		GameState.Set("photoMode", m_state.ToString());
	}

	private void SetTab(int _index)
	{
		switch (_index)
		{
		case 0:
			m_tabs[0].SetParent(m_tabOver);
			m_tabs[1].SetParent(m_tabUnder);
			m_tabs[2].SetParent(m_tabUnder);
			m_tabBorders.gameObject.SetActive(value: false);
			m_tabFilters.gameObject.SetActive(value: false);
			m_tabStickers.gameObject.SetActive(value: true);
			m_tabSelect.gameObject.SetActive(value: false);
			break;
		case 1:
			m_tabs[0].SetParent(m_tabUnder);
			m_tabs[1].SetParent(m_tabOver);
			m_tabs[2].SetParent(m_tabUnder);
			m_tabStickers.gameObject.SetActive(value: false);
			m_tabFilters.gameObject.SetActive(value: false);
			m_tabBorders.gameObject.SetActive(value: true);
			SetSelect(m_currentBorder);
			m_tabSelect.gameObject.SetActive(value: true);
			break;
		case 2:
			m_tabs[0].SetParent(m_tabUnder);
			m_tabs[1].SetParent(m_tabUnder);
			m_tabs[2].SetParent(m_tabOver);
			m_tabStickers.gameObject.SetActive(value: false);
			m_tabBorders.gameObject.SetActive(value: false);
			m_tabFilters.gameObject.SetActive(value: true);
			SetSelect(m_currentFilter);
			m_tabSelect.gameObject.SetActive(value: true);
			break;
		}
		for (int i = 0; i < m_tabs.Length; i++)
		{
			m_tabs[i].anchoredPosition = Vector2.zero;
		}
	}

	private void SetSelect(int _index)
	{
		int num = 17 + _index % 3 * 60;
		int num2 = -51 - _index / 3 * 60;
		m_tabSelect.anchoredPosition = new Vector2(num, num2);
	}

	public void PickSticker(int _id)
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioStickerLiftSheet, base.gameObject);
		m_stickers.GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_currentSticker = UnityEngine.Object.Instantiate(m_stickerPrefab, m_tabStickerLayer);
		Transform stickerTransform = m_currentSticker;
		m_currentSticker.GetComponent<Button>().onClick.AddListener(delegate
		{
			PickSticker(stickerTransform);
		});
		Image component = m_currentSticker.GetComponent<Image>();
		component.sprite = m_stickerData.stickers[m_stickerSheetIDs[_id]].sprite;
		component.SetNativeSize();
		Vector2 sizeDelta = m_currentSticker.GetComponent<RectTransform>().sizeDelta;
		if (sizeDelta.x % 2f != 0f || sizeDelta.y % 2f != 0f)
		{
			m_currentSticker.GetComponent<RectTransform>().pivot = new Vector2(Mathf.Floor(sizeDelta.x / 2f) / sizeDelta.x, Mathf.Ceil(sizeDelta.y / 2f) / sizeDelta.y);
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(m_tabStickerLayer, inputHandler.CursorPosition, null, out var localPoint);
		m_currentOffset = (Vector2)m_tabStickerLayer.InverseTransformPoint(m_stickerSheet[_id].transform.position) - localPoint + new Vector2((int)sizeDelta.x / 2, -(int)sizeDelta.y / 2);
		localPoint += m_currentOffset;
		localPoint.x = Mathf.Round(localPoint.x);
		localPoint.y = Mathf.Round(localPoint.y);
		m_currentSticker.localPosition = localPoint;
		m_touchStickerHoldStartPos = inputHandler.CursorPosition;
		m_touchStickerHoldTimer = m_touchStickerHoldDuration;
		SetState(state.stickerPlace);
		m_ignoreCursorPress = true;
		EvaulateStickerScale();
	}

	public void PickSticker(Transform _sticker)
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioStickerLiftScreen, base.gameObject);
		SetState(state.stickerPlace);
		m_stickers.GetComponent<CanvasGroup>().blocksRaycasts = false;
		m_currentSticker = _sticker;
		m_currentStickers.Remove(m_currentSticker);
		m_currentSticker.SetParent(m_tabStickerLayer);
		m_currentSticker.GetComponent<Graphic>().material = m_stickerMats[2];
		m_currentSticker.GetComponent<Graphic>().raycastTarget = false;
		RectTransformUtility.ScreenPointToLocalPointInRectangle(m_tabStickerLayer.GetComponent<RectTransform>(), inputHandler.CursorPosition, null, out var localPoint);
		m_currentOffset = (Vector2)m_tabStickerLayer.GetComponent<RectTransform>().InverseTransformPoint(m_currentSticker.transform.position) - localPoint;
		m_touchStickerHoldStartPos = inputHandler.CursorPosition;
		m_touchStickerHoldTimer = m_touchStickerHoldDuration;
		m_currentFrame = true;
		EvaulateStickerScale();
	}

	private void Update()
	{
		if (m_screenshotTextTimer > 0f)
		{
			m_screenshotTextTimer -= Time.deltaTime;
			if (m_screenshotTextTimer < 1f)
			{
				m_screenshotTextHolder.anchoredPosition = Vector2.up * Mathf.RoundToInt((1f - Mathf.Pow(m_screenshotTextTimer, 2f)) * m_screenshotTextHolder.sizeDelta.y);
				if (m_screenshotTextTimer <= 0f)
				{
					m_screenshotTextHolder.gameObject.SetActive(value: false);
				}
			}
		}
		if (m_queuedPlacedStickers.Count > 0)
		{
			foreach (Graphic queuedPlacedSticker in m_queuedPlacedStickers)
			{
				if (queuedPlacedSticker != null)
				{
					queuedPlacedSticker.raycastTarget = true;
				}
			}
			m_queuedPlacedStickers.Clear();
		}
		if (m_controlsActive)
		{
			if (m_menuWasVisible != m_menuVisible)
			{
				m_menuWasVisible = m_menuVisible;
			}
			else if (!m_menuVisible && (inputHandler.IsAnyKeyOrButtonPressed || inputHandler.TouchCount > 0))
			{
				ToggleMenuVisibility();
			}
			if (m_state != state.stickerPlace && !m_exitConfirm.activeSelf && m_menuVisible)
			{
				Vector2 pan = m_pan;
				if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad)
				{
					Vector2 axis2DRaw = inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove);
					if (axis2DRaw.sqrMagnitude > 0f)
					{
						Vector2 vector = axis2DRaw;
						vector *= vector.magnitude * Time.deltaTime * 60f * 0.05f;
						m_pan = m_uiScript.m_game.PanCamera(m_pan + vector);
					}
					else if (m_panHorizontal != 0 || m_panVertical != 0)
					{
						m_pan.x += (float)m_panHorizontal * m_panSpeed * Time.deltaTime;
						m_pan.y += (float)m_panVertical * m_panSpeed * Time.deltaTime;
						m_pan = m_uiScript.m_game.PanCamera(m_pan);
					}
				}
				else if (m_panHorizontal != 0 || m_panVertical != 0)
				{
					m_pan.x += (float)m_panHorizontal * m_panSpeed * Time.deltaTime;
					m_pan.y += (float)m_panVertical * m_panSpeed * Time.deltaTime;
					m_pan = m_uiScript.m_game.PanCamera(m_pan);
				}
				else
				{
					Vector2 vector2 = inputHandler.GetAxis2DRaw(InputAction.Gameplay_ScreenPanMove) * Time.deltaTime * 60f * 0.25f;
					if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
					{
						vector2 += inputHandler.Instance.mouseScrollDelta / (m_uiScript.m_game.GetPixelSize() * m_zoom * 2f);
					}
					m_pan += vector2;
					m_pan = m_uiScript.m_game.PanCamera(m_pan);
				}
				if (inputHandler.IsDown(InputAction.Gameplay_ScreenPan))
				{
					if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
					{
						m_pan -= inputHandler.GetAxis2DRaw(InputAction.Gameplay_CursorMove) / (m_uiScript.m_game.GetPixelSize() * m_zoom);
					}
					else
					{
						m_pan -= inputHandler.CursorDelta / (m_uiScript.m_game.GetPixelSize() * m_zoom * 100f);
					}
					m_pan = m_uiScript.m_game.PanCamera(m_pan);
				}
				bool num = !pan.Equals(m_pan);
				if (num)
				{
					m_panCooldown = 0.05f;
				}
				if (m_panCooldown > 0f)
				{
					if (!m_panActive)
					{
						m_panActive = true;
						AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoPanStart, base.gameObject);
					}
				}
				else if (m_panActive)
				{
					m_panActive = false;
					AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoPanEnd, base.gameObject);
				}
				if (!num)
				{
					m_panCooldown = Mathf.MoveTowards(m_panCooldown, 0f, Time.deltaTime);
				}
			}
			if (!Mathf.Approximately(m_zoom, m_zoomTarget))
			{
				m_zoom = Mathf.MoveTowards(m_zoom, m_zoomTarget, Time.deltaTime * ((m_zoom > 1f) ? 6f : 3f));
				m_uiScript.m_game.PhotoZoom(m_zoom);
			}
			gameStateScript.GameAction();
		}
		if (m_tabStickersSheetAction != 0)
		{
			m_tabStickersSheetLerp = Mathf.MoveTowards(m_tabStickersSheetLerp, 1f, Time.deltaTime * 3f);
			float num2 = ((m_tabStickersSheetAction > 0) ? m_tabStickersSheetLerp : (1f - m_tabStickersSheetLerp));
			float num3 = Mathf.Round(Mathf.Lerp(0f, -190f, m_tabStickersSheetAnim.Evaluate(num2)));
			m_tabStickersSheetShadow.color = Color.black * Mathf.Lerp(0.2f, 0f, num2 * 1.5f);
			m_tabStickersSheet.localPosition = Vector2.right * num3;
			if (Mathf.Approximately(m_tabStickersSheetLerp, 1f))
			{
				for (int i = 0; i < m_tabStickersToDelete.Length; i++)
				{
					UnityEngine.Object.Destroy(m_tabStickersToDelete[i].gameObject);
				}
				if (m_tabStickersSheetAction < 0)
				{
					for (int j = 0; j < m_stickerSheet.Length; j++)
					{
						m_stickerSheet[j].GetComponent<RectTransform>().SetParent(m_tabStickersMode.GetComponent<RectTransform>());
					}
				}
				m_tabStickersSheet.gameObject.SetActive(value: false);
				m_tabStickersSheetAction = 0;
				m_tabStickersSheetShadow.enabled = false;
			}
		}
		if (m_state != m_stateNext && (m_tabState == tabState.none || m_tabState == tabState.showing))
		{
			if (m_state == state.normal)
			{
				TabExpand();
				SetState(m_stateNext);
				if (m_state == state.stickerMode)
				{
					SetTab(0);
				}
				else if (m_stateNext == state.borderMode)
				{
					SetTab(1);
				}
				else if (m_state == state.filterMode)
				{
					SetTab(2);
				}
			}
			else if (m_state == state.stickerPlace)
			{
				TabExpand();
				SetState(m_stateNext);
			}
			else if (m_state == state.borderMode || m_state == state.filterMode || m_state == state.stickerMode)
			{
				TabRetract();
			}
			if ((m_state == state.borderMode || m_state == state.filterMode || m_state == state.stickerMode) && m_stateNext == state.normal)
			{
				TabRetract();
				SetState(m_stateNext);
			}
		}
		bool flag = false;
		if (!Mathf.Approximately(m_tabHide, m_tabHideTarget))
		{
			flag = true;
			m_tabHide = Mathf.MoveTowards(m_tabHide, m_tabHideTarget, Time.deltaTime * 6f);
		}
		if (m_tabState == tabState.expanding)
		{
			m_tabLerp = Mathf.MoveTowards(m_tabLerp, 1f, Time.deltaTime * 3f);
			m_tab.anchoredPosition = Vector2.right * Mathf.Ceil(m_tabAnimOut.Evaluate(m_tabLerp) * m_tabTarget);
			flag = true;
			if (Mathf.Approximately(m_tabLerp, 1f))
			{
				m_tabState = tabState.showing;
				uiGamepadNavigationGroup uiGamepadNavigationGroup2 = null;
				switch (m_state)
				{
				case state.borderMode:
					uiGamepadNavigationGroup2 = m_tabBorders.GetComponentInChildren<uiGamepadNavigationGroup>();
					break;
				case state.filterMode:
					uiGamepadNavigationGroup2 = m_tabFilters.GetComponentInChildren<uiGamepadNavigationGroup>();
					break;
				case state.stickerMode:
					uiGamepadNavigationGroup2 = m_tabStickers.GetComponentInChildren<uiGamepadNavigationGroup>();
					break;
				}
				if (uiGamepadNavigationGroup2 != null)
				{
					uiGamepadNavigationGroup2.enabled = true;
				}
			}
		}
		else if (m_tabState == tabState.retracting)
		{
			m_tabLerp = Mathf.MoveTowards(m_tabLerp, 0f, Time.deltaTime * 4f);
			m_tab.anchoredPosition = Vector2.right * Mathf.Floor(m_tabAnimIn.Evaluate(m_tabLerp) * m_tabTarget);
			flag = true;
			if (Mathf.Approximately(m_tabLerp, 0f))
			{
				m_tabState = tabState.none;
				if (m_stateNext == state.borderMode || m_stateNext == state.filterMode || (m_state != state.stickerMode && m_stateNext == state.stickerMode))
				{
					m_state = state.normal;
				}
				if (m_state == state.stickerPlace)
				{
					SetTab(0);
					m_tabHideTarget = 1f;
					RefreshStickers();
				}
			}
		}
		else if (m_tabState == tabState.showing && m_currentSticker == null && inputHandler.IsPressed(InputAction.Menu_Back))
		{
			ChangeState(state.normal);
		}
		if (flag)
		{
			float num4 = 0f;
			num4 = ((m_tabState == tabState.expanding) ? Mathf.Ceil(Mathf.Lerp(m_tabAnimOut.Evaluate(m_tabLerp) * -20f, -38f, m_tabHide)) : ((m_tabState != tabState.retracting) ? Mathf.Round(Mathf.Lerp((m_tabState == tabState.showing) ? (-20f) : 0f, -38f, m_tabHide)) : Mathf.Floor(Mathf.Lerp(m_tabAnimIn.Evaluate(m_tabLerp) * -20f, -38f, m_tabHide))));
			m_tabUnder.anchoredPosition = Vector2.right * num4;
		}
		bool flag2 = !m_currentFrame && inputHandler.IsPointerOverGameObject();
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
		{
			if (inputHandler.IsPointerReleased() && m_wasTouchOverUI)
			{
				flag2 = true;
				m_wasTouchOverUI = false;
			}
			else
			{
				m_wasTouchOverUI = flag2;
			}
		}
		else
		{
			m_wasTouchOverUI = false;
		}
		m_currentFrame = false;
		if (m_state == state.stickerPlace)
		{
			if (m_currentSticker != null)
			{
				bool flag3 = false;
				switch (inputHandler.CurrentControllerInputType)
				{
				case inputHandler.ControllerInputType.Keyboard:
				case inputHandler.ControllerInputType.Gamepad:
				{
					RectTransformUtility.ScreenPointToLocalPointInRectangle(m_stickers.GetComponent<RectTransform>(), inputHandler.CursorPosition, null, out var localPoint2);
					localPoint2 += m_currentOffset;
					localPoint2.x = Mathf.Round(localPoint2.x);
					localPoint2.y = Mathf.Round(localPoint2.y);
					m_currentSticker.localPosition = localPoint2;
					flag3 = inputHandler.IsPointerPressed() && !m_ignoreCursorPress;
					break;
				}
				case inputHandler.ControllerInputType.Touch:
				{
					if (m_touchStickerHoldTimer > 0f)
					{
						m_touchStickerHoldTimer -= Time.deltaTime;
					}
					if (!inputHandler.IsPointerDown())
					{
						break;
					}
					bool flag4 = !flag2 && !m_stickerPointerWasPressedOverUI && m_touchStickerHoldTimer <= 0f;
					if (inputHandler.IsPointerPressed())
					{
						GameObject gameObject = ((inputHandler.CachedPointerEvenData != null) ? inputHandler.CachedPointerEvenData.pointerEnter : null);
						if (gameObject != null && (gameObject == m_currentSticker.gameObject || TransformUtil.IsInHierarchy(gameObject.transform, m_tab)))
						{
							flag2 = false;
						}
						if (flag2)
						{
							m_stickerPointerWasPressedOverUI = true;
						}
						else
						{
							m_touchStickerHoldStartPos = inputHandler.CursorPosition;
							m_touchStickerHoldTimer = m_touchStickerHoldDuration;
							flag4 = true;
						}
					}
					if (m_stickerPointerWasPressedOverUI)
					{
						if (inputHandler.IsPointerReleased())
						{
							m_stickerPointerWasPressedOverUI = false;
						}
					}
					else
					{
						if ((m_touchStickerHoldStartPos - inputHandler.CursorPosition).magnitude > m_touchStickerHoldRadius)
						{
							m_touchStickerHoldTimer = 0f;
							flag4 = true;
						}
						if (inputHandler.IsPointerReleased())
						{
							flag3 = !m_ignoreCursorPress && (m_touchStickerHoldTimer <= 0f || m_stickerWaitingForTouch);
							m_stickerWaitingForTouch = !flag3;
						}
					}
					if (flag4)
					{
						RectTransformUtility.ScreenPointToLocalPointInRectangle(m_stickers.GetComponent<RectTransform>(), inputHandler.CursorPosition, null, out var localPoint);
						localPoint += m_currentOffset;
						localPoint.x = Mathf.Round(localPoint.x);
						localPoint.y = Mathf.Round(localPoint.y);
						m_currentSticker.localPosition = localPoint;
					}
					break;
				}
				}
				if (flag3)
				{
					if (flag2)
					{
						if (!m_tabStickerModifiersHover && !m_ignoreStickerDestroyThisFrame)
						{
							DestroySticker();
							ChangeState(state.stickerMode);
						}
					}
					else
					{
						SetState((m_tabState == tabState.showing) ? state.stickerMode : state.normal);
						OnCurrentStickerPlaced();
					}
					gameStateScript.GetCursor().ShowCursor(IsCursorVisible);
				}
			}
		}
		else if (m_state != state.normal && inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Gamepad && inputHandler.IsPointerPressed() && !flag2)
		{
			ChangeState(state.normal);
		}
		if (m_exitConfirm.activeSelf)
		{
			if (m_exitConfirmActive && m_exitConfirmLerp < 1f)
			{
				m_exitConfirmLerp += Time.deltaTime * 4f;
				if (m_exitConfirmLerp >= 1f)
				{
					m_exitConfirm.GetComponent<uiTransitionScript>().Lerp(1f);
					m_exitConfirm.GetComponent<uiTransitionScript>().ControlsActive(_value: true);
				}
				else
				{
					m_exitConfirm.GetComponent<uiTransitionScript>().Lerp(m_exitConfirmLerp);
				}
			}
			else if (!m_exitConfirmActive && m_exitConfirmLerp > 0f)
			{
				m_exitConfirmLerp -= Time.deltaTime * 4f;
				if (m_exitConfirmLerp <= 0f)
				{
					m_exitConfirm.SetActive(value: false);
				}
				else
				{
					m_exitConfirm.GetComponent<uiTransitionScript>().Lerp(m_exitConfirmLerp);
				}
			}
		}
		else
		{
			if (inputHandler.IsPressed(InputAction.Sticker_DeleteCurrent))
			{
				state state2 = m_state;
				if (state2 == state.stickerPlace)
				{
					DestroySticker();
					ChangeState(state.stickerMode);
				}
			}
			if (m_state == state.filterMode)
			{
				if (inputHandler.IsPressed(InputAction.Filter_IntensityInc) || inputHandler.IsPressed(InputAction.Menu_Slider_Right, ignoreInputHandled: true))
				{
					m_sliderFilter.Increase();
				}
				else if (inputHandler.IsPressed(InputAction.Filter_IntensityDec) || inputHandler.IsPressed(InputAction.Menu_Slider_Left, ignoreInputHandled: true))
				{
					m_sliderFilter.Decrease();
				}
			}
		}
		if (!Mathf.Approximately(m_controlsCrossfade, m_controlsCrossfadeTarget))
		{
			m_controlsCrossfade = Mathf.MoveTowards(m_controlsCrossfade, m_controlsCrossfadeTarget, Time.deltaTime * 6f);
			m_controls.GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(80f * Mathf.Pow(m_controlsCrossfade, 2f)) * 2f;
			m_tabStickersPlace.GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(80f * Mathf.Pow(1f - m_controlsCrossfade, 2f)) * 2f;
		}
		if (!Mathf.Approximately(m_controlsBackFade, m_controlsBackFadeTarget))
		{
			m_controlsBackFade = Mathf.MoveTowards(m_controlsBackFade, m_controlsBackFadeTarget, Time.deltaTime * 6f);
			m_controlsBack.GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(80f * Mathf.Pow(m_controlsBackFade, 2f)) * 2f;
		}
		m_ignoreCursorPress = false;
		m_ignoreStickerDestroyThisFrame = false;
	}

	private void TabRetract()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoTabClose, m_tab.gameObject);
		m_tabState = tabState.retracting;
		uiGamepadNavigationGroup uiGamepadNavigationGroup2 = null;
		switch (m_state)
		{
		case state.borderMode:
			uiGamepadNavigationGroup2 = m_tabBorders.GetComponentInChildren<uiGamepadNavigationGroup>();
			break;
		case state.filterMode:
			uiGamepadNavigationGroup2 = m_tabFilters.GetComponentInChildren<uiGamepadNavigationGroup>();
			break;
		case state.stickerMode:
			uiGamepadNavigationGroup2 = m_tabStickers.GetComponentInChildren<uiGamepadNavigationGroup>();
			break;
		}
		if (uiGamepadNavigationGroup2 != null)
		{
			uiGamepadNavigationGroup2.enabled = false;
		}
	}

	private void ShowControlBack(bool _show)
	{
		m_controlsBackFadeTarget = (_show ? 0f : 1f);
		m_controlsBack.GetComponent<CanvasGroup>().interactable = _show;
	}

	private void TabExpand()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoTabOpen, m_tab.gameObject);
		m_tabState = tabState.expanding;
	}

	private void OnCurrentStickerPlaced()
	{
		if (m_currentSticker == null)
		{
			Debug.LogError("Null current sticker!");
			return;
		}
		AkSoundEngine.PostEvent(m_uiScript.m_audioStickerPlace, m_currentSticker.gameObject);
		m_currentSticker.SetParent(m_stickers);
		Graphic component = m_currentSticker.GetComponent<Graphic>();
		component.material = null;
		m_queuedPlacedStickers.Add(component);
		m_currentStickers.Add(m_currentSticker);
		m_currentSticker = null;
	}

	public void SetSelect(int _id, int _index)
	{
		m_uiScript.Change();
		switch (_id)
		{
		case 0:
		{
			if (m_activeBorder != null)
			{
				UnityEngine.Object.Destroy(m_activeBorder.gameObject);
				m_activeBorder = null;
			}
			Transform prefab = m_data.m_borders[_index].prefab;
			if (prefab != null)
			{
				m_activeBorder = UnityEngine.Object.Instantiate(prefab, m_border);
			}
			m_currentBorder = _index;
			SetSelect(m_currentBorder);
			break;
		}
		case 1:
			m_filter.profile = m_data.m_filters[_index].profile;
			m_filterHideGradient = m_data.m_filters[_index].hideGradient;
			m_filterMat.SetFloat("_Amount", m_filterHideGradient ? 0f : 1f);
			m_filterMeshStrength = m_data.m_filters[_index].meshStrength;
			m_pixelMesh.enabled = m_filterMeshStrength > 0f;
			if (m_filterMeshStrength > 0f)
			{
				m_pixelMesh.color = new Color(m_filterMeshStrength, m_filterMeshStrength, m_filterMeshStrength);
			}
			m_filter.weight = 1f;
			m_sliderFilter.SetSlide((_index != 0) ? 1f : 0f);
			m_sliderFilter.Enable(_index != 0);
			m_currentFilter = _index;
			SetSelect(m_currentFilter);
			break;
		}
	}

	public void SetSlide(float _value, bool _increase)
	{
		m_filter.weight = Mathf.Lerp(0.01f, 1f, _value);
		if (m_filterHideGradient)
		{
			m_filterMat.SetFloat("_Amount", 1f - _value);
		}
		if (m_filterMeshStrength > 0f)
		{
			m_pixelMesh.color = new Color(m_filterMeshStrength * _value, m_filterMeshStrength * _value, m_filterMeshStrength * _value);
		}
		m_uiScript.Slide(_increase);
	}

	public void ToggleMenuVisibility()
	{
		m_menuVisible = !m_menuVisible;
		m_hud.alpha = (m_menuVisible ? 1f : 0f);
		m_hud.blocksRaycasts = m_menuVisible;
		m_stickers.GetComponent<CanvasGroup>().blocksRaycasts = m_menuVisible;
		gameStateScript.GetCursor().ShowCursor(IsCursorVisible);
		AkSoundEngine.PostEvent(m_menuVisible ? m_uiScript.m_audioPhotoHudShow : m_uiScript.m_audioPhotoHudHide, base.gameObject);
	}

	public void StickerScale(bool _increase)
	{
		int num = Mathf.RoundToInt(m_currentSticker.localScale.y);
		float x = Mathf.Sign(m_currentSticker.localScale.x);
		if (_increase && num < 4)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioStickerScaleUp, m_currentSticker.gameObject);
			num++;
			m_currentSticker.localScale = new Vector3(x, 1f, 1f) * num;
			m_currentOffset *= (float)num / (float)(num - 1);
		}
		else if (!_increase && num > 1)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioStickerScaleDown, m_currentSticker.gameObject);
			num--;
			m_currentSticker.localScale = new Vector3(x, 1f, 1f) * num;
			m_currentOffset *= (float)num / (float)(num + 1);
		}
		EvaulateStickerScale();
		m_ignoreStickerDestroyThisFrame = true;
	}

	private void EvaulateStickerScale()
	{
		int num = Mathf.RoundToInt(m_currentSticker.localScale.y);
		m_controlsZoom[2].interactable = num < 4;
		m_controlsZoom[3].interactable = num > 1;
	}

	public void StickerRotate()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioStickerRotate, m_currentSticker.gameObject);
		m_currentSticker.Rotate(Vector3.forward * -90f);
		m_ignoreStickerDestroyThisFrame = true;
	}

	public void StickerFlip()
	{
		AkSoundEngine.PostEvent(m_uiScript.m_audioStickerFlip, m_currentSticker.gameObject);
		Vector3 localScale = m_currentSticker.localScale;
		localScale.x *= -1f;
		m_currentOffset.x *= -1f;
		m_currentSticker.localScale = localScale;
		m_ignoreStickerDestroyThisFrame = true;
	}

	public void DestroySticker()
	{
		if (m_currentSticker != null)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioStickerReturn, base.gameObject);
			UnityEngine.Object.Destroy(m_currentSticker.gameObject);
			m_currentSticker = null;
		}
	}

	private void DestroyAllStickers()
	{
		for (int i = 0; i < m_currentStickers.Count; i++)
		{
			UnityEngine.Object.Destroy(m_currentStickers[i].gameObject);
		}
		m_currentStickers.Clear();
	}

	private void ResetEffects()
	{
		if (m_activeBorder != null)
		{
			UnityEngine.Object.Destroy(m_activeBorder.gameObject);
			m_activeBorder = null;
		}
		m_currentBorder = 0;
		m_filter.profile = null;
		m_currentFilter = 0;
		m_filterHideGradient = false;
		m_filterMat.SetFloat("_Amount", 1f);
		m_filterMeshStrength = 0f;
		if (m_pixelMesh != null)
		{
			m_pixelMesh.enabled = false;
		}
		m_filter.weight = 1f;
		m_sliderFilter.SetSlide(1f);
		m_sliderFilter.Enable(_value: false);
	}

	public void StickerTabHover(bool _enter)
	{
		if (m_state != state.stickerPlace)
		{
			return;
		}
		if (_enter)
		{
			if (m_tabState == tabState.none)
			{
				RefreshStickers();
				TabExpand();
			}
		}
		else if (m_tabState == tabState.showing)
		{
			TabRetract();
		}
	}

	public void StickerActionHover(int _action)
	{
		m_tabStickerModifiersHover = _action > -1;
		if (!m_tabStickerModifiersHover)
		{
			m_ignoreStickerDestroyThisFrame = true;
		}
		m_currentSticker.GetComponent<Graphic>().color = ((_action > -1) ? new Color(1f, 1f, 1f, 0.5f) : Color.white);
	}

	public void TakeScreenshot()
	{
		Debug.Log("starting screenshot coroutine");
		StartCoroutine(Screenshot());
	}

	private IEnumerator Screenshot()
	{
		if (m_menuVisible)
		{
			m_hud.alpha = 0f;
			gameStateScript.GetCursor().ShowCursor(_value: false);
		}
		yield return new WaitForEndOfFrame();
		string pathScreenshot = gameStateScript.GetPathScreenshot();
		try
		{
			if (!Directory.Exists(pathScreenshot))
			{
				Directory.CreateDirectory(pathScreenshot);
			}
			string text = DateTime.Now.ToString("yyyyMMdd_");
			int num = 1;
			while (File.Exists(pathScreenshot + text + num.ToString("D4") + ".png") && num < 9999)
			{
				num++;
			}
			if (num < 9999)
			{
				string text2 = pathScreenshot + text + num.ToString("D4") + ".png";
				Debug.Log("going to save screenshot as : " + text2);
				ScreenCapture.CaptureScreenshot(text2);
				ScreenshotText(text2);
			}
			m_flash.Rewind();
			m_flash.Play();
			m_uiScript.Screenshot();
		}
		catch (Exception ex)
		{
			Debug.LogWarning("screenshot failed : " + ex.ToString());
		}
		if (m_menuVisible)
		{
			m_hud.alpha = 1f;
			gameStateScript.GetCursor().ShowCursor(IsCursorVisible);
		}
	}

	private void ScreenshotText(string _filepath = "")
	{
		m_screenshotText.font = gameStateScript.GetFont(stringIdScript.fontStyle.small);
		if (string.IsNullOrEmpty(_filepath))
		{
			m_screenshotText.text = gameStateScript.GetString("photo_save");
		}
		else
		{
			string text = gameStateScript.GetString("photo_save_computer") + " " + _filepath;
			float width = m_screenshotText.GetComponent<RectTransform>().rect.width;
			if (m_screenshotText.GetPreferredValues(text).x >= width)
			{
				int num = 0;
				for (int i = 1; i < text.Length; i++)
				{
					if (m_screenshotText.GetPreferredValues(text.Substring(num, i - num)).x >= width)
					{
						text = text.Insert(i - 1, "\n");
						num = i - 1;
					}
				}
			}
			m_screenshotText.text = text;
		}
		m_screenshotTextHolder.gameObject.SetActive(value: true);
		m_screenshotTextHolder.anchoredPosition = Vector2.zero;
		m_screenshotTextTimer = 5f;
	}

	public void PanHorizontal(int _direction)
	{
		if (_direction != 0 && m_panHorizontal != _direction && !string.IsNullOrEmpty(m_uiScript.m_audioPhotoPanClick))
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoPanClick, base.gameObject);
		}
		m_panHorizontal = _direction;
	}

	public void PanVertical(int _direction)
	{
		if (_direction != 0 && m_panVertical != _direction && !string.IsNullOrEmpty(m_uiScript.m_audioPhotoPanClick))
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoPanClick, base.gameObject);
		}
		m_panVertical = _direction;
	}

	public void Zoom(int _zoom)
	{
		if (_zoom > 0)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioZoomIn, base.gameObject);
			if (m_zoomTarget < 1f)
			{
				m_zoomTarget = 1f;
			}
			else
			{
				m_zoomTarget = Mathf.Round(Mathf.Min(m_zoomTarget + 1f, 4f));
			}
		}
		else if (_zoom < 0)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioZoomOut, base.gameObject);
			float zoomTargetMin = m_uiScript.m_game.zoomTargetMin;
			if (m_zoomTarget <= zoomTargetMin)
			{
				m_zoomTarget = zoomTargetMin;
			}
			else if (Mathf.Approximately(m_zoomTarget, 1f))
			{
				m_zoomTarget = zoomTargetMin;
			}
			else
			{
				m_zoomTarget = Mathf.Round(Mathf.Max(m_zoomTarget - 1f, 1f));
			}
		}
		m_controlsZoom[0].interactable = m_zoomTarget < 4f;
		m_controlsZoom[1].interactable = m_zoomTarget >= 1f;
	}

	private void OnEnable()
	{
		m_zoom = m_uiScript.m_game.GetZoom();
		m_zoom = ((m_zoom < 1f) ? m_uiScript.m_game.zoomTargetMin : Mathf.Round(m_zoom));
		m_zoomTarget = m_zoom;
		m_uiScript.m_game.PhotoZoom(m_zoom);
		Zoom(0);
		int lastStickerUnlock = m_uiScript.m_game.GetLastStickerUnlock();
		EvaluateStickerPages();
		m_stickerSheetCurrent = Mathf.Max(0, lastStickerUnlock);
		PrepareStickerPage(Mathf.Max(0, lastStickerUnlock));
		RefreshStickerUINavigation(selectLast: false);
		m_uiScript.m_game.gamePan = false;
		gameStateScript.GetCursor().Behaviour = uiCursor.CursorBehaviour.Default;
		gameStateScript.GetCursor()?.ShowCursor(IsCursorVisible);
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
		m_canvasScaler = UnityEngine.Object.FindObjectOfType<CanvasScaler>();
		SetState(state.normal);
		if (lastStickerUnlock > -1)
		{
			ChangeState(state.stickerMode);
		}
		m_screenshotTextHolder.gameObject.SetActive(value: false);
		float pixelSize = m_uiScript.m_game.GetPixelSize();
		float num = (pixelSize + (float)gameStateScript.GetAccessSetting(gameStateScript.accessSetting.iconsize)) / pixelSize;
		m_tabTarget = 187f / num;
	}

	private void OnDisable()
	{
		m_pan = m_uiScript.m_game.PanCamera(Vector2.zero);
		m_uiScript.m_game.PhotoZoom(0f);
		DestroyAllStickers();
		ResetEffects();
		m_border.GetComponent<CanvasGroup>().alpha = 1f;
		m_stickers.GetComponent<CanvasGroup>().alpha = 1f;
		m_exitConfirmActive = false;
		m_exitConfirm.SetActive(value: false);
		m_exitConfirmLerp = 0f;
		m_hud.interactable = true;
		for (int i = 0; i < m_stickerSheet.Length; i++)
		{
			UnityEngine.Object.Destroy(m_stickerSheet[i].gameObject);
		}
		m_uiScript.m_game.gamePan = true;
		gameStateScript.GetCursor()?.ShowCursor(inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Touch);
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
		GameState.Set("photoMode", "disabled");
		if (m_panActive)
		{
			m_panCooldown = 0f;
			m_panActive = false;
			AkSoundEngine.PostEvent(m_uiScript.m_audioPhotoPanEnd, base.gameObject);
		}
	}

	private void OnControllerInputTypeChanged()
	{
		gameStateScript.GetCursor()?.ShowCursor(IsCursorVisible);
		RefreshStickerUINavigation(selectLast: false);
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch && m_currentSticker != null)
		{
			m_stickerWaitingForTouch = true;
		}
	}

	public void ExitMode()
	{
		if (m_currentStickers.Count > 0 || m_currentFilter != 0 || m_currentBorder != 0)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioQuitPhotoDialog, m_uiScript.gameObject);
			m_exitConfirm.SetActive(value: true);
			m_exitConfirmActive = true;
			m_exitConfirm.GetComponent<uiTransitionScript>().ControlsActive(_value: false);
			m_exitConfirm.GetComponent<uiTransitionScript>().Lerp(m_exitConfirmLerp);
			gameStateScript.GetCursor()?.ShowCursor(IsCursorVisible);
			m_hud.interactable = false;
		}
		else
		{
			m_uiScript.ResumePhotomode();
		}
	}

	public void ExitConfirm(bool _value)
	{
		if (_value)
		{
			AkSoundEngine.PostEvent(m_uiScript.m_audioQuitPhotoYes, m_uiScript.gameObject);
			m_uiScript.ResumePhotomode();
			return;
		}
		AkSoundEngine.PostEvent(m_uiScript.m_audioQuitPhotoNo, m_uiScript.gameObject);
		m_exitConfirmActive = false;
		m_exitConfirm.GetComponent<uiTransitionScript>().ControlsActive(_value: false);
		gameStateScript.GetCursor()?.ShowCursor(IsCursorVisible);
		m_hud.interactable = true;
	}

	public void ControlsActive(bool _value)
	{
		GetComponent<CanvasGroup>().blocksRaycasts = _value;
		if (!_value)
		{
			m_stateNext = state.normal;
		}
		m_controlsActive = _value;
	}

	public void Lerp(float _lerp)
	{
		float num = 1f - _lerp;
		num *= num;
		GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(60f * num) * 2f;
		if (m_currentBorder > 0)
		{
			m_border.GetComponent<CanvasGroup>().alpha = _lerp;
		}
		if (m_currentFilter > 0)
		{
			m_filter.weight = m_sliderFilter.value * _lerp;
			if (m_filterHideGradient)
			{
				m_filterMat.SetFloat("_Amount", Mathf.Lerp(m_sliderFilter.value, 1f, _lerp));
			}
			if (m_filterMeshStrength > 0f)
			{
				if (_lerp <= 0f)
				{
					m_pixelMesh.enabled = false;
				}
				else
				{
					m_pixelMesh.color = new Color(m_filterMeshStrength * _lerp, m_filterMeshStrength * _lerp, m_filterMeshStrength * _lerp);
				}
			}
		}
		m_stickers.GetComponent<CanvasGroup>().alpha = _lerp;
		if (m_exitConfirm.activeSelf)
		{
			m_exitConfirm.GetComponent<uiTransitionScript>().Lerp(_lerp);
		}
		m_uiScript.m_game.PhotoZoom(Mathf.Lerp(m_uiScript.m_game.GetZoom(), m_zoom, _lerp * _lerp));
		m_uiScript.m_game.PanCamera(Vector2.Lerp(Vector2.zero, m_pan, _lerp * _lerp));
	}
}
