using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

public class uiInputActionIcons : MonoBehaviour
{
	[Serializable]
	public class inputActionIconInfo
	{
		[NonSerialized]
		public InputAction inputAction;

		public string ia = "";

		public bool injectInputIcon = true;

		public RectTransform uiElement;

		public Vector2 offset;

		[Range(1f, 3f)]
		public int scale = 1;

		public Image replaceIcon;

		public List<uiInputActionIcon.ActiveStatePair> activeStateListeners;

		public UnityEvent OnInputActionPressed;

		public bool copyEventsFromButton = true;

		public bool ignoreInputHandledFlag;
	}

	public List<inputActionIconInfo> m_iconUIBindings = new List<inputActionIconInfo>();

	private List<inputActionIconInfo> m_loadedUIBindings = new List<inputActionIconInfo>();

	private Dictionary<InputAction, uiInputActionIcon> m_pendingInputActions = new Dictionary<InputAction, uiInputActionIcon>();

	[Range(0.1f, 3f)]
	public float m_fadeDuration = 0.5f;

	private float m_invFadeDuration = 1f;

	private float m_fadeSlider;

	private bool m_iconsAreShowing;

	private List<uiInputActionIcon> m_instancedIcons;

	private void Awake()
	{
		foreach (inputActionIconInfo iconUIBinding in m_iconUIBindings)
		{
			if (iconUIBinding != null && iconUIBinding.uiElement != null)
			{
				m_loadedUIBindings.Add(iconUIBinding);
				m_pendingInputActions[iconUIBinding.inputAction] = null;
			}
		}
	}

	private void OnEnable()
	{
		m_iconsAreShowing = inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad || inputHandler.Instance.ForceShowInputActionIcons();
		m_fadeSlider = (m_iconsAreShowing ? 1f : 0f);
		m_invFadeDuration = 1f / m_fadeDuration;
		inputHandler.OnControllerInputTypeChanged?.AddListener(OnControllerInputTypeChanged);
		Refresh();
	}

	private void OnDisable()
	{
		inputHandler.OnControllerInputTypeChanged?.RemoveListener(OnControllerInputTypeChanged);
	}

	private void Update()
	{
		if (m_instancedIcons == null)
		{
			return;
		}
		if (m_iconsAreShowing)
		{
			if (m_fadeSlider < 1f)
			{
				m_fadeSlider = Mathf.Min(m_fadeSlider + Time.deltaTime * m_invFadeDuration, 1f);
				if (m_fadeSlider == 1f)
				{
					OnIconsTransitionComplete();
				}
			}
		}
		else if (m_fadeSlider > 0f)
		{
			m_fadeSlider = Mathf.Max(m_fadeSlider - Time.deltaTime * m_invFadeDuration, 0f);
			if (m_fadeSlider == 0f)
			{
				OnIconsTransitionComplete();
			}
		}
		for (int i = 0; i < m_loadedUIBindings.Count; i++)
		{
			if (m_loadedUIBindings[i] == null || i >= m_instancedIcons.Count)
			{
				continue;
			}
			uiInputActionIcon uiInputActionIcon2 = m_instancedIcons[i];
			if (!(uiInputActionIcon2 == null))
			{
				uiInputActionIcon2.FadeSlider = m_fadeSlider;
				if (uiInputActionIcon2.CanAcceptInput())
				{
					m_pendingInputActions[uiInputActionIcon2.InputAction] = uiInputActionIcon2;
				}
			}
		}
		foreach (KeyValuePair<InputAction, uiInputActionIcon> pendingInputAction in m_pendingInputActions)
		{
			if (pendingInputAction.Value != null && pendingInputAction.Value.IsInputActionPressed())
			{
				pendingInputAction.Value.OnPressed();
			}
		}
	}

	private void Refresh()
	{
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Unknown || inputHandler.Instance == null || inputHandler.Instance.InputActionIconPrefab == null)
		{
			return;
		}
		if (m_instancedIcons == null)
		{
			m_instancedIcons = new List<uiInputActionIcon>();
			{
				foreach (inputActionIconInfo loadedUIBinding in m_loadedUIBindings)
				{
					if (loadedUIBinding == null || loadedUIBinding.uiElement == null)
					{
						continue;
					}
					Enum.TryParse<InputAction>(loadedUIBinding.ia, out loadedUIBinding.inputAction);
					Sprite[] icons = inputHandler.Instance.QueryInputActionIcons(loadedUIBinding.inputAction, 0);
					uiInputActionIcon uiInputActionIcon2 = UnityEngine.Object.Instantiate(inputHandler.Instance.InputActionIconPrefab);
					uiInputActionIcon2.Setup(loadedUIBinding.inputAction, icons, loadedUIBinding.offset, loadedUIBinding.uiElement, loadedUIBinding.replaceIcon, m_iconsAreShowing, loadedUIBinding.injectInputIcon, loadedUIBinding.activeStateListeners);
					uiInputActionIcon2.m_ignoreInputHandled = loadedUIBinding.ignoreInputHandledFlag;
					if (loadedUIBinding.scale < 1)
					{
						loadedUIBinding.scale = 1;
					}
					Vector3 localScale = uiInputActionIcon2.transform.localScale;
					localScale = new Vector3(loadedUIBinding.scale, loadedUIBinding.scale, localScale.z);
					if (uiInputActionIcon2.transform.lossyScale.x < 0f)
					{
						localScale.x *= -1f;
					}
					if (uiInputActionIcon2.transform.lossyScale.y < 0f)
					{
						localScale.y *= -1f;
					}
					uiInputActionIcon2.transform.localScale = localScale;
					uiInputActionIcon2.OnInputActionPressed = loadedUIBinding.OnInputActionPressed;
					if (loadedUIBinding.copyEventsFromButton)
					{
						Button component = loadedUIBinding.uiElement.GetComponent<Button>();
						if (component != null)
						{
							uiInputActionIcon2.OnInputActionPressedCopiedFromButton = component.onClick;
						}
					}
					m_instancedIcons.Add(uiInputActionIcon2);
					uiInputActionIcon2.OnTransitionComplete();
				}
				return;
			}
		}
		foreach (uiInputActionIcon instancedIcon in m_instancedIcons)
		{
			if (instancedIcon != null)
			{
				Sprite[] icons2 = inputHandler.Instance.QueryInputActionIcons(instancedIcon.InputAction, 0);
				instancedIcon.UpdateIcons(icons2, m_iconsAreShowing);
				instancedIcon?.OnTransitionStart(m_iconsAreShowing);
			}
		}
	}

	private void OnControllerInputTypeChanged()
	{
		m_iconsAreShowing = inputHandler.Instance.ForceShowInputActionIcons() || inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad;
		Refresh();
	}

	private void OnIconsTransitionComplete()
	{
		if (inputHandler.Instance == null || inputHandler.Instance.InputActionIconPrefab == null || m_instancedIcons == null)
		{
			return;
		}
		foreach (uiInputActionIcon instancedIcon in m_instancedIcons)
		{
			instancedIcon?.OnTransitionComplete();
		}
	}

	[ContextMenu("Toggle Icons")]
	private void ToggleDebugLogging()
	{
		m_iconsAreShowing = !m_iconsAreShowing;
		Refresh();
	}
}
