using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

public class uiInputActionIcon : UIBehaviour
{
	[Serializable]
	public class ActiveStatePair
	{
		public string name;

		public string value;
	}

	private InputAction m_inputAction;

	public Image m_icon1;

	public Image m_plus;

	public Image m_icon2;

	private Vector2 m_offset;

	private RectTransform m_uiElement;

	private Selectable m_cachedSelectable;

	private bool m_wasInteractable;

	private Image m_replaceIcon;

	private float m_fadeSlider;

	private bool m_iconsAreShowing;

	private bool m_isActive = true;

	private bool m_injectInputIcons;

	private int m_iconCount;

	private Canvas m_canvas;

	private List<CanvasGroup> m_cachedCanvasGroupChain;

	public UnityEvent OnInputActionPressed;

	public UnityEvent OnInputActionPressedCopiedFromButton;

	public bool m_ignoreInputHandled;

	public List<ActiveStatePair> activeStates = new List<ActiveStatePair>();

	public InputAction InputAction => m_inputAction;

	public RectTransform UIElement => m_uiElement;

	public Vector2 Offset
	{
		get
		{
			return m_offset;
		}
		set
		{
			m_offset = value;
			RefreshPosition();
		}
	}

	public float FadeSlider
	{
		get
		{
			return m_fadeSlider;
		}
		set
		{
			m_fadeSlider = value;
		}
	}

	protected override void Start()
	{
		CacheCanvasGroupChain();
	}

	protected override void OnDestroy()
	{
		foreach (ActiveStatePair activeState in activeStates)
		{
			GameState.RemoveListener(activeState.name, OnStateChanged);
		}
	}

	protected override void OnCanvasGroupChanged()
	{
		CacheCanvasGroupChain();
	}

	private void CacheCanvasGroupChain()
	{
		m_cachedCanvasGroupChain = new List<CanvasGroup>();
		Transform parent = base.transform;
		while (parent != null)
		{
			CanvasGroup component = parent.GetComponent<CanvasGroup>();
			if (component != null)
			{
				m_cachedCanvasGroupChain.Add(component);
			}
			parent = parent.parent;
		}
	}

	private bool IsRaycastBlocked()
	{
		bool flag = true;
		if (m_cachedCanvasGroupChain != null)
		{
			foreach (CanvasGroup item in m_cachedCanvasGroupChain)
			{
				if (!(item == null))
				{
					flag = item.blocksRaycasts;
					if (item.ignoreParentGroups || !flag)
					{
						break;
					}
				}
			}
		}
		return flag;
	}

	private void Update()
	{
		if (m_cachedSelectable != null && m_wasInteractable != m_cachedSelectable.IsInteractable())
		{
			m_wasInteractable = m_cachedSelectable.IsInteractable();
			UpdateIconsState();
		}
		float a = m_fadeSlider * (m_isActive ? 1f : 0f);
		if (m_icon1 != null)
		{
			Color color = m_icon1.color;
			color.a = a;
			m_icon1.color = color;
		}
		if (m_plus != null)
		{
			Color color2 = m_plus.color;
			color2.a = a;
			m_plus.color = color2;
		}
		if (m_icon2 != null)
		{
			Color color3 = m_icon2.color;
			color3.a = a;
			m_icon2.color = color3;
		}
	}

	public void Setup(InputAction inputAction, Sprite[] icons, Vector2 offset, RectTransform uiElement, Image replaceIcon, bool iconsAreShowing, bool injectInputIcons, List<ActiveStatePair> statesList)
	{
		m_inputAction = inputAction;
		m_injectInputIcons = injectInputIcons;
		m_offset = offset;
		m_uiElement = uiElement;
		if (m_uiElement != null)
		{
			m_cachedSelectable = m_uiElement.GetComponent<Selectable>();
			if (m_cachedSelectable != null)
			{
				m_wasInteractable = m_cachedSelectable.IsInteractable();
			}
		}
		base.transform.SetParent(m_uiElement);
		base.transform.localScale = Vector3.one;
		m_replaceIcon = replaceIcon;
		m_replaceIcon?.gameObject.SetActive(!iconsAreShowing);
		activeStates = statesList;
		foreach (ActiveStatePair activeState in activeStates)
		{
			GameState.AddListener(activeState.name, OnStateChanged);
		}
		RefreshState();
		RefreshPosition();
		UpdateIcons(icons, iconsAreShowing);
	}

	private void UpdateIconsState()
	{
		bool flag = m_iconsAreShowing && m_injectInputIcons && m_cachedSelectable != null && m_cachedSelectable.IsInteractable();
		m_icon1.gameObject.SetActive(m_icon1.sprite != null && m_iconCount > 0 && flag);
		m_plus.gameObject.SetActive(m_iconCount > 1 && flag);
		m_icon2.gameObject.SetActive(m_icon2.sprite != null && m_iconCount > 1 && flag);
	}

	public void UpdateIcons(Sprite[] icons, bool iconsAreShowing)
	{
		m_iconsAreShowing = iconsAreShowing;
		m_iconCount = ((icons != null) ? icons.Length : 0);
		if (icons != null)
		{
			m_icon1.sprite = ((icons.Length != 0) ? icons[0] : null);
			m_icon1.enabled = m_icon1.sprite != null;
			m_icon2.sprite = ((icons.Length > 1) ? icons[1] : null);
			m_icon2.enabled = m_icon2.sprite != null;
		}
		UpdateIconsState();
	}

	private void RefreshPosition()
	{
		if (m_canvas == null)
		{
			m_canvas = GetComponentInParent<Canvas>();
		}
		RectTransform component = GetComponent<RectTransform>();
		component.anchorMin = new Vector2(1f, 0f);
		component.anchorMax = new Vector2(1f, 0f);
		component.pivot = new Vector2(1f, 0f);
		Vector3 anchoredPosition3D = component.anchoredPosition3D;
		anchoredPosition3D.x = component.sizeDelta.x * 0.5f + m_offset.x * (0f - m_uiElement.rect.width);
		anchoredPosition3D.y = (0f - component.sizeDelta.y) * 0.5f + m_offset.y * m_uiElement.rect.height;
		anchoredPosition3D.z = m_canvas.planeDistance;
		component.anchoredPosition3D = anchoredPosition3D;
	}

	public void OnTransitionStart(bool iconsAreShowing)
	{
		m_iconsAreShowing = iconsAreShowing;
		m_fadeSlider = (m_iconsAreShowing ? 0f : 1f);
		bool flag = m_injectInputIcons && (m_cachedSelectable == null || m_cachedSelectable.IsInteractable());
		m_icon1.gameObject.SetActive(m_icon1.sprite != null && flag);
		m_plus.gameObject.SetActive(m_icon2.sprite != null && flag);
		m_icon2.gameObject.SetActive(m_icon2.sprite != null && flag);
		m_replaceIcon?.gameObject.SetActive(!m_iconsAreShowing);
	}

	public void OnTransitionComplete()
	{
		m_fadeSlider = (m_iconsAreShowing ? 1f : 0f);
		bool flag = m_iconsAreShowing && m_injectInputIcons && (m_cachedSelectable == null || m_cachedSelectable.IsInteractable());
		m_icon1.gameObject.SetActive(flag);
		m_plus.gameObject.SetActive(m_icon2.sprite != null && flag);
		m_icon2.gameObject.SetActive(m_icon2.sprite != null && flag);
		m_replaceIcon?.gameObject.SetActive(!m_iconsAreShowing);
	}

	public bool CanAcceptInput()
	{
		if ((m_uiElement != null && !m_uiElement.gameObject.activeInHierarchy) || (m_cachedSelectable != null && !m_cachedSelectable.IsInteractable()) || !IsRaycastBlocked() || !m_isActive)
		{
			return false;
		}
		return true;
	}

	public bool IsInputActionPressed()
	{
		if (CanAcceptInput())
		{
			return inputHandler.IsPressed(m_inputAction, m_ignoreInputHandled);
		}
		return false;
	}

	public void OnPressed()
	{
		OnInputActionPressedCopiedFromButton?.Invoke();
		OnInputActionPressed?.Invoke();
	}

	private void OnStateChanged(string name)
	{
		RefreshState();
	}

	private void RefreshState()
	{
		if (activeStates.Count == 0)
		{
			return;
		}
		m_isActive = false;
		foreach (ActiveStatePair activeState in activeStates)
		{
			if (GameState.Get(activeState.name) == activeState.value)
			{
				m_isActive = true;
				break;
			}
		}
	}
}
