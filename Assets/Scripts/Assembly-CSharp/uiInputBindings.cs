using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class uiInputBindings : MonoBehaviour
{
	[Serializable]
	public class InputActionGroup
	{
		public string groupName = "<Group>";

		public List<InputAction> inputActions = new List<InputAction>();
	}

	public List<InputActionGroup> m_inputActionGroups = new List<InputActionGroup>();

	public List<InputActionGroup> m_inputActionGroupsDemo = new List<InputActionGroup>();

	private Dictionary<string, List<InputAction>> m_inputActionMap = new Dictionary<string, List<InputAction>>();

	public uiInputBindingGroup m_uiInputActionGroupPrefab;

	public uiInputBinding_Simple m_uiSimpleBindingPrefab;

	private List<uiInputBindingGroup> m_groupInstances = new List<uiInputBindingGroup>();

	private List<uiInputBinding> m_bindingInstances = new List<uiInputBinding>();

	public RectTransform m_root;

	public Button m_backButton;

	public Button m_defaultsButton;

	public GameObject m_cancelRebindInstruction;

	public CanvasGroup m_canvasGroup;

	private uiGamepadNavigationGroup m_navGroup;

	public ScrollRect m_scrollRect;

	public Scrollbar m_scrollbar;

	private Selectable m_cachedEnteredSelectable;

	public bool m_instantiateOnceOnly;

	private bool m_instantiatedOnce;

	private bool m_bindingFinished;

	private bool m_isBinding;

	private bool m_pendingRebindStart;

	private int m_disabledInteractivityFrames;

	private bool m_pendingScrollViewReset;

	public bool isBinding => m_isBinding;

	private void Awake()
	{
		if (m_root == null)
		{
			m_root = GetComponent<RectTransform>();
		}
		m_navGroup = GetComponent<uiGamepadNavigationGroup>();
		foreach (InputActionGroup inputActionGroup in m_inputActionGroups)
		{
			List<InputAction> list = new List<InputAction>();
			foreach (InputAction inputAction in inputActionGroup.inputActions)
			{
				list.Add(inputAction);
			}
			m_inputActionMap[inputActionGroup.groupName] = list;
		}
		if (m_scrollRect == null)
		{
			Debug.LogError("Scroll Rect not attached!");
		}
		if (m_scrollRect.content == null)
		{
			Debug.LogError("Scroll Rect Content not attached!");
		}
		if (m_scrollRect.viewport == null)
		{
			Debug.LogError("Scroll Rect Viewport not attached!");
		}
	}

	private void OnEnable()
	{
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
		inputHandler.OnInputRebindCaptured.AddListener(OnInputRebindCaptured);
		inputHandler.OnInputRebindComplete.AddListener(OnInputRebindComplete);
		m_defaultsButton?.onClick.AddListener(OnDefaultsButtonPressed);
		if (m_cancelRebindInstruction != null)
		{
			m_cancelRebindInstruction.SetActive(value: false);
		}
		m_pendingScrollViewReset = true;
		Refresh(recreateInstances: true);
	}

	private void OnDisable()
	{
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
		inputHandler.OnInputRebindCaptured.RemoveListener(OnInputRebindCaptured);
		inputHandler.OnInputRebindComplete.RemoveListener(OnInputRebindComplete);
		m_defaultsButton?.onClick.RemoveListener(OnDefaultsButtonPressed);
	}

	private void Update()
	{
		if (m_disabledInteractivityFrames > 0)
		{
			m_disabledInteractivityFrames--;
			if (m_disabledInteractivityFrames == 0)
			{
				if (m_canvasGroup != null)
				{
					m_canvasGroup.interactable = true;
				}
				m_navGroup?.Refresh();
			}
		}
		if (m_pendingRebindStart)
		{
			OnRebindStarted();
			m_pendingRebindStart = false;
		}
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad && m_cachedEnteredSelectable != uiEventSystemExtension.enteredSelectable)
		{
			m_cachedEnteredSelectable = uiEventSystemExtension.enteredSelectable;
			if (m_cachedEnteredSelectable != null)
			{
				RefreshScrollView();
			}
		}
		if (m_bindingFinished)
		{
			m_bindingFinished = false;
			m_isBinding = false;
			m_backButton.interactable = true;
			if (m_cancelRebindInstruction != null)
			{
				m_cancelRebindInstruction.SetActive(value: false);
				m_defaultsButton.gameObject.SetActive(value: true);
			}
			else
			{
				m_defaultsButton.interactable = true;
			}
		}
		if (m_pendingScrollViewReset)
		{
			m_scrollbar.value = 1f;
			m_pendingScrollViewReset = false;
		}
	}

	private void RefreshScrollView()
	{
		uiDebug.Log(base.gameObject, "RefreshScrollView");
		if (m_scrollRect == null || m_scrollRect.content == null || m_scrollRect.viewport == null)
		{
			return;
		}
		float height = m_scrollRect.viewport.rect.height;
		float height2 = m_scrollRect.content.rect.height;
		if (height2 < height)
		{
			return;
		}
		if (m_cachedEnteredSelectable == m_backButton)
		{
			m_scrollbar.value = 1f;
			return;
		}
		float num = 0f;
		RectTransform rectTransform = null;
		int childCount = m_scrollRect.content.transform.childCount;
		for (int i = 0; i < childCount; i++)
		{
			Transform child = m_scrollRect.content.transform.GetChild(i);
			RectTransform component = child.GetComponent<RectTransform>();
			if (component == null)
			{
				continue;
			}
			Selectable componentInChildren = child.GetComponentInChildren<Selectable>();
			if (componentInChildren == null)
			{
				num += component.rect.height;
				continue;
			}
			if (componentInChildren == uiEventSystemExtension.enteredSelectable)
			{
				rectTransform = component;
				m_cachedEnteredSelectable = componentInChildren;
				break;
			}
			num += component.rect.height;
		}
		if (!(rectTransform == null))
		{
			float num2 = height2 - height;
			float num3 = rectTransform.rect.height / num2;
			float num4 = height / num2;
			float num5 = 1f - num / num2;
			float max = Mathf.Min(1f, num5 + num4 - num3);
			float min = Mathf.Max(0f, num5);
			m_scrollRect.verticalNormalizedPosition = Mathf.Clamp(m_scrollRect.verticalNormalizedPosition, min, max);
		}
	}

	public void Refresh(bool recreateInstances = false)
	{
		if (recreateInstances && ((m_instantiateOnceOnly && !m_instantiatedOnce) || !m_instantiateOnceOnly))
		{
			foreach (uiInputBindingGroup groupInstance in m_groupInstances)
			{
				if (groupInstance != null)
				{
					UnityEngine.Object.Destroy(groupInstance.gameObject);
				}
			}
			m_groupInstances.Clear();
			foreach (uiInputBinding bindingInstance in m_bindingInstances)
			{
				if (bindingInstance != null)
				{
					UnityEngine.Object.Destroy(bindingInstance.gameObject);
				}
			}
			m_bindingInstances.Clear();
			uiInputBinding uiInputBinding2 = null;
			foreach (InputActionGroup inputActionGroup in m_inputActionGroups)
			{
				uiInputBindingGroup uiInputBindingGroup2 = UnityEngine.Object.Instantiate(m_uiInputActionGroupPrefab, m_root);
				uiInputBindingGroup2.Setup(inputActionGroup.groupName);
				m_groupInstances.Add(uiInputBindingGroup2);
				foreach (InputAction inputAction in inputActionGroup.inputActions)
				{
					if (inputAction == InputAction.Menu_Navigate || inputAction == InputAction.Gameplay_CursorMove || inputAction == InputAction.Gameplay_ScreenPanMove)
					{
						Debug.LogWarning("No binding logic available for axis.");
						continue;
					}
					uiInputBinding_Simple uiInputBinding_Simple2 = UnityEngine.Object.Instantiate(m_uiSimpleBindingPrefab, m_root);
					uiInputBinding_Simple2.m_inputAction = inputAction;
					uiInputBinding_Simple2.m_rebindButton?.onClick.AddListener(OnRebindButtonPressed);
					m_bindingInstances.Add(uiInputBinding_Simple2);
					if (uiInputBinding2 != null)
					{
						Link(uiInputBinding2.Selectable, uiInputBinding_Simple2.Selectable);
					}
					uiInputBinding2 = uiInputBinding_Simple2;
				}
			}
			if (uiInputBinding2 != null && m_defaultsButton != null)
			{
				Link(uiInputBinding2.Selectable, m_defaultsButton);
			}
			if (m_bindingInstances.Count > 0 && m_backButton != null)
			{
				Link(m_backButton, m_bindingInstances[0].Selectable);
			}
			m_instantiatedOnce = true;
			return;
		}
		foreach (uiInputBinding bindingInstance2 in m_bindingInstances)
		{
			if (bindingInstance2 != null)
			{
				bindingInstance2.OnBindingsRefresh();
			}
		}
	}

	private void Link(Selectable above, Selectable below)
	{
		if (above != null)
		{
			above.navigation = new Navigation
			{
				mode = Navigation.Mode.Explicit,
				selectOnDown = below,
				selectOnLeft = null,
				selectOnRight = null,
				selectOnUp = above.navigation.selectOnUp
			};
		}
		if (below != null)
		{
			below.navigation = new Navigation
			{
				mode = Navigation.Mode.Explicit,
				selectOnUp = above,
				selectOnLeft = null,
				selectOnRight = null,
				selectOnDown = below.navigation.selectOnDown
			};
		}
	}

	private void OnControllerInputTypeChanged()
	{
		m_cachedEnteredSelectable = null;
	}

	public void OnRebindButtonPressed(InputAction inputAction, int inputSlot)
	{
		List<InputAction> list = new List<InputAction>();
		foreach (KeyValuePair<string, List<InputAction>> item in m_inputActionMap)
		{
			if (!item.Value.Contains(inputAction))
			{
				continue;
			}
			foreach (InputAction item2 in item.Value)
			{
				if (item2 != inputAction)
				{
					list.Add(item2);
				}
			}
			break;
		}
		inputHandler.Instance.BeginRebind(inputAction, inputSlot, list.ToArray());
	}

	private void OnRebindStarted()
	{
		foreach (uiInputBinding bindingInstance in m_bindingInstances)
		{
			bindingInstance.OnRebindStarted();
		}
		if (m_canvasGroup != null)
		{
			m_canvasGroup.interactable = false;
		}
		m_isBinding = true;
		m_backButton.interactable = false;
		if (m_cancelRebindInstruction != null)
		{
			m_cancelRebindInstruction.SetActive(value: true);
			m_defaultsButton.gameObject.SetActive(value: false);
		}
		else
		{
			m_defaultsButton.interactable = false;
		}
		m_disabledInteractivityFrames = 0;
	}

	private void OnRebindOver()
	{
		foreach (uiInputBinding bindingInstance in m_bindingInstances)
		{
			bindingInstance.OnRebindOver();
		}
		m_disabledInteractivityFrames = 2;
		m_bindingFinished = true;
	}

	private void OnRebindButtonPressed()
	{
		if (!m_isBinding)
		{
			m_pendingRebindStart = true;
		}
	}

	private void OnDefaultsButtonPressed()
	{
		inputHandler.Instance?.RevertToDefaultBindings(currentSchemeOnly: false);
		Refresh();
	}

	private void OnInputRebindCaptured()
	{
	}

	private void OnInputRebindComplete()
	{
		OnRebindOver();
	}
}
