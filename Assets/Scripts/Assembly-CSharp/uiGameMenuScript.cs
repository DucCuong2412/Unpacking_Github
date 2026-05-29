using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiGameMenuScript : MonoBehaviour
{
	[Serializable]
	public struct frames
	{
		public GameObject[] parts;
	}

	public gameUIScript m_ui;

	public GameObject[] m_pages;

	public Image m_pageShadow;

	public frames[] m_frames;

	private float m_pageLerp;

	private float m_pageLerpTarget;

	private int m_lastFrame;

	public GameObject[] m_menus;

	public TextMeshProUGUI[] m_menusOverlapText;

	public Image[] m_menusMouse;

	public RectTransform m_notepad;

	private int m_depth;

	private int m_nextMenu;

	private int m_currentMenu;

	private bool m_changeMenu;

	private bool m_changePage;

	public RectTransform m_root;

	public AnimationCurve m_flipForward;

	public AnimationCurve m_flipBackward;

	private bool m_pencilReactive = true;

	public RectTransform m_pencil;

	public RectTransform m_pencilShadow;

	private Vector2 m_pencilPosition = Vector2.zero;

	private Vector2 m_pencilGoal = Vector2.zero;

	private float m_pencilHeight = 10f;

	private float m_pencilHeightGoal = 10f;

	private float m_pencilHold;

	private bool m_backout;

	public GameObject m_confirmBox;

	private void OnEnable()
	{
		m_pencilPosition = new Vector2(-145f, -200f);
		m_pencilGoal = new Vector2(-145f, 115f);
		m_pencilReactive = true;
		FixMouse();
	}

	private void SetPage(int _page)
	{
		for (int i = 0; i < m_pages.Length; i++)
		{
			m_pages[i].SetActive(i == _page);
		}
		m_depth = _page;
		m_changePage = false;
	}

	private void ChangePage(int _page, int _nextMenu)
	{
		if (inputHandler.IsDown(InputAction.Menu_Back))
		{
			m_backout = true;
		}
		if (_page > m_depth)
		{
			m_pageLerp = 0f;
			m_pageLerpTarget = 1f;
			if (!string.IsNullOrEmpty(m_ui.m_audioNotepadPageForward))
			{
				AkSoundEngine.PostEvent(m_ui.m_audioNotepadPageForward, base.gameObject);
			}
		}
		else if (_page < m_depth)
		{
			m_pageLerp = 1f;
			m_pageLerpTarget = 0f;
			if (!string.IsNullOrEmpty(m_ui.m_audioNotepadPageBack))
			{
				AkSoundEngine.PostEvent(m_ui.m_audioNotepadPageBack, base.gameObject);
			}
		}
		m_nextMenu = _nextMenu;
		m_changeMenu = true;
		m_changePage = _page != m_depth;
		if (_nextMenu == 0)
		{
			m_ui.IgnoreNextMenuChange();
		}
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		if (m_backout)
		{
			m_backout = false;
		}
		else
		{
			m_pencilHeight = 0f;
			m_pencilPosition = m_pencilGoal;
			PositionPencil();
			m_pencilHold = 0.1f;
		}
		gameStateScript.PrefSaveNow();
	}

	private Vector2 SnapPixels(Vector2 _input)
	{
		_input.x = Mathf.Round(_input.x);
		_input.y = Mathf.Round(_input.y);
		return _input;
	}

	private void PositionPencil()
	{
		m_pencil.anchoredPosition = SnapPixels(m_pencilPosition) + SnapPixels(new Vector2(0f - m_pencilHeight, m_pencilHeight));
		m_pencilShadow.anchoredPosition = SnapPixels(m_pencilPosition) + new Vector2(-6f, -10f);
	}

	private void Update()
	{
		if (m_pencilReactive)
		{
			m_pencilGoal.x = ((Mathf.Abs(m_pageLerp - m_pageLerpTarget) < 0.25f) ? (-145f) : (-175f));
			if (uiEventSystemExtension.enteredSelectable != null)
			{
				RectTransformUtility.ScreenPointToLocalPointInRectangle(m_root, uiEventSystemExtension.enteredSelectable.GetComponent<RectTransform>().position, null, out var localPoint);
				m_pencilGoal.y = localPoint.y;
			}
			if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Keyboard)
			{
				if (inputHandler.IsPointerDown() && uiEventSystemExtension.enteredSelectable != null && uiEventSystemExtension.enteredSelectable.interactable)
				{
					m_pencilHeight = 0f;
				}
			}
			else if (uiEventSystemExtension.enteredSelectable != null)
			{
				if (inputHandler.IsDown(InputAction.Menu_Accept))
				{
					m_pencilHeight = 0f;
				}
				else if ((uiEventSystemExtension.enteredSelectable.GetComponent<uiOnUIMove>() != null || uiEventSystemExtension.enteredSelectable.GetComponent<Slider>() != null) && (inputHandler.IsDown(InputAction.Menu_NavigateLeft) || inputHandler.IsDown(InputAction.Menu_NavigateRight) || Mathf.Abs(inputHandler.Instance.GetAxisRaw("Horizontal")) > 0.6f))
				{
					m_pencilHeight = 0f;
				}
			}
		}
		if (m_pencilHold > 0f)
		{
			m_pencilHold = Mathf.MoveTowards(m_pencilHold, 0f, Time.deltaTime);
		}
		else
		{
			m_pencilPosition = Vector2.Lerp(m_pencilPosition, m_pencilGoal, Time.deltaTime * 8f);
			PositionPencil();
			m_pencilHeight = Mathf.Lerp(m_pencilHeight, m_pencilHeightGoal, Time.deltaTime * 8f);
		}
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			return;
		}
		m_pageLerp = Mathf.MoveTowards(m_pageLerp, m_pageLerpTarget, Time.deltaTime * 1.8f);
		bool flag = m_pageLerpTarget > 0.5f;
		int num = Mathf.RoundToInt((flag ? m_flipForward.Evaluate(m_pageLerp) : m_flipBackward.Evaluate(1f - m_pageLerp)) * 10f);
		m_root.anchoredPosition = Vector2.up * num;
		int num2 = (flag ? Mathf.FloorToInt(m_pageLerp * 6f) : Mathf.CeilToInt(m_pageLerp * 6f));
		if (num2 > 0 && m_pageLerp < 0.6f)
		{
			Color color = m_pageShadow.color;
			color.a = Mathf.InverseLerp(0.6f, 0f, m_pageLerp) * 0.25f;
			m_pageShadow.color = color;
			m_pageShadow.enabled = true;
		}
		else
		{
			m_pageShadow.enabled = false;
		}
		if (num2 == m_lastFrame)
		{
			return;
		}
		for (int i = 0; i < m_frames.Length; i++)
		{
			GameObject[] parts = m_frames[i].parts;
			for (int j = 0; j < parts.Length; j++)
			{
				parts[j].SetActive(i == num2 - 1);
			}
		}
		if (flag)
		{
			if (m_changeMenu && num2 >= 1)
			{
				SetMenu(m_nextMenu);
			}
			else if (num2 == 6)
			{
				SetPage(m_depth + 1);
			}
		}
		else if (num2 == 0)
		{
			SetMenu(m_nextMenu);
		}
		else if (m_changePage && num2 <= 5)
		{
			SetPage(m_depth - 1);
		}
		m_lastFrame = num2;
	}

	private void SetMenu(int _menu)
	{
		for (int i = 0; i < m_menus.Length; i++)
		{
			m_menus[i].SetActive(i == _menu);
		}
		GetComponent<CanvasGroup>().blocksRaycasts = true;
		m_currentMenu = _menu;
		m_changeMenu = false;
		FixMouse();
	}

	public void FixMouse()
	{
		if (m_menusOverlapText[m_currentMenu] != null && m_menusMouse[m_currentMenu] != null)
		{
			m_menusMouse[m_currentMenu].enabled = m_notepad.sizeDelta.y > 460f || m_menusOverlapText[m_currentMenu].GetPreferredValues().x < 175f;
		}
	}

	public void ShowMain()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			AkSoundEngine.PostEvent(m_ui.m_audioPause, base.gameObject);
			ChangePage(0, 0);
		}
	}

	public void ShowSettings()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			if (m_depth < 1)
			{
				AkSoundEngine.PostEvent(m_ui.m_audioSettings, base.gameObject);
			}
			else
			{
				AkSoundEngine.PostEvent(m_ui.m_audioPause, base.gameObject);
			}
			ChangePage(1, 1);
		}
	}

	public void ShowSettingsAudio()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			AkSoundEngine.PostEvent(m_ui.m_audioSettings, base.gameObject);
			ChangePage(2, 2);
		}
	}

	public void ShowSettingsVideo()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			AkSoundEngine.PostEvent(m_ui.m_audioSettings, base.gameObject);
			ChangePage(2, 3);
		}
	}

	public void ShowSettingsAccess()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			AkSoundEngine.PostEvent(m_ui.m_audioSettings, base.gameObject);
			ChangePage(2, 4);
		}
	}

	public void ShowSettingsControls()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			AkSoundEngine.PostEvent(m_ui.m_audioSettings, base.gameObject);
			ChangePage(2, 5);
		}
	}

	public void ShowConfirm()
	{
		AkSoundEngine.PostEvent(m_ui.m_audioDialog, m_ui.gameObject);
		m_pencilReactive = false;
		GetComponent<CanvasGroup>().blocksRaycasts = false;
		GetComponent<CanvasGroup>().interactable = false;
		m_confirmBox.SetActive(value: true);
	}

	public void ConfirmYes()
	{
		AkSoundEngine.PostEvent(m_ui.m_audioYes, m_ui.gameObject);
		m_confirmBox.SetActive(value: false);
		GetComponent<CanvasGroup>().blocksRaycasts = true;
		GetComponent<CanvasGroup>().interactable = true;
		m_pencilReactive = true;
	}

	public void ConfirmNo()
	{
		AkSoundEngine.PostEvent(m_ui.m_audioNo, m_ui.gameObject);
		m_confirmBox.SetActive(value: false);
		uiStringSelect[] array = UnityEngine.Object.FindObjectsOfType<uiStringSelect>();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].m_type == uiStringSelect.stringSelectType.itemsAnywhere)
			{
				array[i].Reset();
			}
		}
		GetComponent<CanvasGroup>().blocksRaycasts = true;
		GetComponent<CanvasGroup>().interactable = true;
		m_pencilReactive = true;
	}

	public void ShowControllerApplet()
	{
		inputHandler.ShowControllerApplet();
	}

	public void BackOut()
	{
		if (Mathf.Approximately(m_pageLerp, m_pageLerpTarget))
		{
			if (m_confirmBox.activeSelf)
			{
				ConfirmNo();
			}
			else if (m_depth == 2)
			{
				m_backout = true;
				ShowSettings();
			}
			else if (m_depth == 1)
			{
				m_backout = true;
				ShowMain();
			}
			else
			{
				m_ui.Resume();
				m_pencilReactive = false;
				m_pencilGoal = new Vector2(-145f, 200f);
			}
		}
	}
}
