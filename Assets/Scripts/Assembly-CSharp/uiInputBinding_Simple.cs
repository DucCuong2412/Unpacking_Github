using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiInputBinding_Simple : uiInputBinding
{
	public TextMeshProUGUI m_inputActionTextUI;

	public stringIdScript m_inputActionStringId;

	public Image m_gamepadIcon;

	public Image m_gamepadIconAlt;

	public TextMeshProUGUI m_kbmString;

	public Button m_rebindButton;

	public List<GameObject> m_showOnRebind = new List<GameObject>();

	public List<GameObject> m_hideOnRebind = new List<GameObject>();

	private bool m_isCapturingRebind;

	private bool m_pendingRefresh;

	private uiInputBindings m_bindingsParent;

	public override Selectable Selectable => m_rebindButton;

	private void Start()
	{
		m_bindingsParent = GetComponentInParent<uiInputBindings>();
	}

	private void OnEnable()
	{
		m_rebindButton?.onClick.AddListener(OnRebindButtonPressed);
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
		m_pendingRefresh = true;
	}

	private void OnDisable()
	{
		m_rebindButton?.onClick.RemoveListener(OnRebindButtonPressed);
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
		inputHandler.OnInputRebindCaptured.RemoveListener(OnInputRebindCaptured);
		inputHandler.OnInputRebindComplete.RemoveListener(OnInputRebindComplete);
	}

	private void Update()
	{
		if (m_pendingRefresh)
		{
			Refresh();
		}
	}

	private void Refresh()
	{
		m_pendingRefresh = false;
		if (m_inputActionStringId != null)
		{
			m_inputActionStringId.SetString("inputaction_" + m_inputAction.ToString().ToLower());
		}
		Sprite[] array = inputHandler.Instance.QueryInputActionIconsForDeviceType(inputHandler.ControllerInputType.Gamepad, m_inputAction, 0);
		if (array != null && array.Length != 0)
		{
			Sprite sprite = array[0];
			m_gamepadIcon.enabled = sprite != null;
			m_gamepadIcon.sprite = sprite;
		}
		else
		{
			m_gamepadIcon.enabled = false;
		}
		if (m_kbmString != null)
		{
			string text = inputHandler.Instance.QueryInputActionStringForDeviceType(inputHandler.ControllerInputType.Keyboard, m_inputAction, 0);
			m_kbmString.enabled = text.Length > 0;
			m_kbmString.text = text;
		}
		foreach (GameObject item in m_showOnRebind)
		{
			if (item != null)
			{
				item.SetActive(m_isCapturingRebind);
			}
		}
		foreach (GameObject item2 in m_hideOnRebind)
		{
			if (item2 != null)
			{
				item2.SetActive(!m_isCapturingRebind);
			}
		}
	}

	private void OnControllerInputTypeChanged()
	{
		m_pendingRefresh = true;
	}

	public override void OnRebindStarted()
	{
		if (!m_isCapturingRebind)
		{
			return;
		}
		uiDebug.Log(base.gameObject, $"OnRebindStarted {m_inputAction.ToString()}");
		inputHandler.OnInputRebindCaptured.AddListener(OnInputRebindCaptured);
		inputHandler.OnInputRebindComplete.AddListener(OnInputRebindComplete);
		foreach (GameObject item in m_showOnRebind)
		{
			if (item != null)
			{
				item.SetActive(value: true);
			}
		}
		foreach (GameObject item2 in m_hideOnRebind)
		{
			if (item2 != null)
			{
				item2.SetActive(value: false);
			}
		}
	}

	public override void OnRebindOver()
	{
		m_pendingRefresh = true;
		if (!m_isCapturingRebind)
		{
			return;
		}
		uiDebug.Log(base.gameObject, $"OnRebindOver {m_inputAction.ToString()}");
		inputHandler.OnInputRebindCaptured.RemoveListener(OnInputRebindCaptured);
		inputHandler.OnInputRebindComplete.RemoveListener(OnInputRebindComplete);
		m_isCapturingRebind = false;
		foreach (GameObject item in m_showOnRebind)
		{
			if (item != null)
			{
				item.SetActive(value: false);
			}
		}
		foreach (GameObject item2 in m_hideOnRebind)
		{
			if (item2 != null)
			{
				item2.SetActive(value: true);
			}
		}
	}

	public override void OnBindingsRefresh()
	{
		m_pendingRefresh = true;
	}

	private void OnRebindButtonPressed()
	{
		if (!m_isCapturingRebind)
		{
			m_bindingsParent.OnRebindButtonPressed(m_inputAction, 0);
			m_isCapturingRebind = true;
		}
	}

	private void OnInputRebindCaptured()
	{
		if (m_isCapturingRebind)
		{
			m_pendingRefresh = true;
		}
	}

	private void OnInputRebindComplete()
	{
		if (m_isCapturingRebind)
		{
			m_pendingRefresh = true;
		}
	}
}
