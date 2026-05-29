using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

public class uiGamepadNavigationGroup : MonoBehaviour
{
	public int m_priority;

	public bool autoSelect = true;

	public bool rememberLastSelection;

	public bool wrap;

	public bool useCustomEventsOnHorizontalEnds;

	public UnityEvent OnLeftFromFirst;

	public UnityEvent OnRightFromLast;

	public bool delayInitialRefresh;

	private bool m_initialRefreshDone;

	private bool m_pendingRefresh;

	private uiGamepadNavigationElement m_first;

	private uiGamepadNavigationElement m_last;

	private bool m_queueleftFromFirst;

	private bool m_queueRightFromLast;

	private Selectable m_lastSelectable;

	private Selectable m_cachedEnteredSelectable;

	private uiGamepadNavigationGroup m_cachedEnteredSelectableNavGroup;

	private bool m_startFlag;

	private void Start()
	{
		m_startFlag = true;
		if (!delayInitialRefresh)
		{
			m_pendingRefresh = true;
		}
	}

	private void OnEnable()
	{
		if (m_startFlag && (!delayInitialRefresh || m_initialRefreshDone))
		{
			m_pendingRefresh = true;
		}
	}

	private void Update()
	{
		if (m_pendingRefresh && (!delayInitialRefresh || (delayInitialRefresh && m_initialRefreshDone)))
		{
			RefreshInternal();
		}
		if (m_queueleftFromFirst)
		{
			OnLeftFromFirst?.Invoke();
			m_queueleftFromFirst = false;
		}
		if (m_queueRightFromLast)
		{
			OnRightFromLast?.Invoke();
			m_queueRightFromLast = false;
		}
		if (rememberLastSelection)
		{
			if (m_cachedEnteredSelectable != uiEventSystemExtension.enteredSelectable)
			{
				m_cachedEnteredSelectable = uiEventSystemExtension.enteredSelectable;
				m_cachedEnteredSelectableNavGroup = ((m_cachedEnteredSelectable != null) ? m_cachedEnteredSelectable.GetComponentInParent<uiGamepadNavigationGroup>() : null);
			}
			if (m_cachedEnteredSelectable != null && m_cachedEnteredSelectableNavGroup == this && m_cachedEnteredSelectable.IsInteractable())
			{
				m_lastSelectable = m_cachedEnteredSelectable;
			}
		}
		if (useCustomEventsOnHorizontalEnds && !(m_first == null) && !(m_last == null))
		{
			if (uiEventSystemExtension.enteredSelectable == m_first.Selectable && inputHandler.IsPressed(InputAction.Menu_NavigateLeft, ignoreInputHandled: true))
			{
				m_queueleftFromFirst = true;
			}
			else if (uiEventSystemExtension.enteredSelectable == m_last.Selectable && inputHandler.IsPressed(InputAction.Menu_NavigateRight, ignoreInputHandled: true))
			{
				m_queueRightFromLast = true;
			}
		}
	}

	private void LateUpdate()
	{
		if (delayInitialRefresh && !m_initialRefreshDone)
		{
			RefreshInternal();
		}
	}

	public void Refresh()
	{
		m_pendingRefresh = true;
	}

	public void ClearRememberedSelectable()
	{
		m_lastSelectable = null;
		ClearSelectionState();
	}

	public void ClearSelectionState()
	{
		Selectable[] componentsInChildren = GetComponentsInChildren<Selectable>();
		foreach (Selectable selectable in componentsInChildren)
		{
			if (selectable.interactable)
			{
				selectable.interactable = false;
				selectable.interactable = true;
			}
		}
	}

	private void RefreshInternal()
	{
		uiDebug.Log(base.gameObject, "Refresh");
		m_first = null;
		m_last = null;
		m_initialRefreshDone = true;
		m_pendingRefresh = false;
		uiGamepadNavigationElement[] componentsInChildren;
		if (autoSelect)
		{
			switch (inputHandler.CurrentControllerInputType)
			{
			case inputHandler.ControllerInputType.Keyboard:
				EventSystem.current.SetSelectedGameObject(null);
				break;
			case inputHandler.ControllerInputType.Gamepad:
			{
				uiGamepadNavigationElement uiGamepadNavigationElement2 = null;
				componentsInChildren = GetComponentsInChildren<uiGamepadNavigationElement>();
				foreach (uiGamepadNavigationElement uiGamepadNavigationElement3 in componentsInChildren)
				{
					if (!uiGamepadNavigationElement3.denyAutoSelect && !(uiGamepadNavigationElement3.Selectable == null) && uiGamepadNavigationElement3.Selectable.interactable && uiGamepadNavigationElement3.Selectable.navigation.mode != Navigation.Mode.None)
					{
						if (rememberLastSelection && m_lastSelectable == uiGamepadNavigationElement3.Selectable)
						{
							uiGamepadNavigationElement2 = uiGamepadNavigationElement3;
							break;
						}
						if (uiGamepadNavigationElement2 == null || (uiEventSystemExtension.enteredSelectable != null && uiGamepadNavigationElement3.Selectable == uiEventSystemExtension.enteredSelectable))
						{
							uiGamepadNavigationElement2 = uiGamepadNavigationElement3;
						}
					}
				}
				if (uiGamepadNavigationElement2 != null)
				{
					uiGamepadNavigationElement2.Select();
				}
				break;
			}
			}
		}
		if (!wrap)
		{
			return;
		}
		List<uiGamepadNavigationElement> list = new List<uiGamepadNavigationElement>();
		componentsInChildren = GetComponentsInChildren<uiGamepadNavigationElement>();
		foreach (uiGamepadNavigationElement uiGamepadNavigationElement4 in componentsInChildren)
		{
			if (!(uiGamepadNavigationElement4.Selectable == null) && uiGamepadNavigationElement4.Selectable.IsInteractable() && uiGamepadNavigationElement4.Selectable.navigation.mode != Navigation.Mode.None)
			{
				list.Add(uiGamepadNavigationElement4);
			}
		}
		if (list.Count == 1)
		{
			m_first = (m_last = list[0]);
		}
		else
		{
			if (list.Count <= 1)
			{
				return;
			}
			List<Selectable> list2 = new List<Selectable>();
			for (int j = 0; j < list.Count; j++)
			{
				Selectable selectable = list[j].Selectable;
				if (selectable.FindSelectableOnUp() == null)
				{
					Selectable selectable2 = selectable.FindSelectableOnDown();
					int num = 30;
					int num2 = num;
					while (selectable2 != null)
					{
						if (num2 <= 0)
						{
							Debug.LogWarningFormat("Max Depth '{0}' reached setting up navigation wrapping! Bailing out!", num);
							break;
						}
						Selectable selectable3 = selectable2.FindSelectableOnDown();
						if (selectable3 == null || selectable3 == selectable || list2.Contains(selectable3))
						{
							UI.CreateVerticalNavigationLink(selectable2, selectable);
							list2.Add(selectable);
							break;
						}
						selectable2 = selectable3;
						num2--;
					}
				}
				if (!useCustomEventsOnHorizontalEnds || j < list.Count - 1)
				{
					Selectable right = ((j < list.Count - 1) ? list[j + 1].Selectable : list[0].Selectable);
					UI.CreateHorizontalNavigationLink(selectable, right);
				}
			}
			m_first = list[0];
			m_last = list[list.Count - 1];
		}
	}
}
