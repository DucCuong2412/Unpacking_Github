using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class uiInputHandlerDebug : MonoBehaviour
{
	public Text m_controllerInputTypeText;

	public Text m_pointerPositionText;

	private Vector2 m_prevPointerPos;

	public Text m_pointerStateText;

	public Text m_pointerPressFrameText;

	public Text m_touchPhaseText;

	public Text m_pointerOverUIText;

	[Header("UI Debug Logging")]
	public Text m_uiDebugLogText;

	[Min(1f)]
	public int m_maxLogs = 100;

	private List<string> m_logMessages = new List<string>();

	private bool m_pendingMessages;

	public ScrollRect m_logWindow;

	public CanvasGroup m_logWindowCanvasGroup;

	private static uiInputHandlerDebug m_instance;

	private void Start()
	{
		m_uiDebugLogText.text = "";
		m_logWindow.gameObject.SetActive(value: false);
		m_instance = this;
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
		OnControllerInputTypeChanged();
	}

	private void OnDestroy()
	{
		inputHandler.OnControllerInputTypeChanged?.RemoveListener(OnControllerInputTypeChanged);
	}

	private void Update()
	{
		if (m_prevPointerPos != inputHandler.CursorPosition)
		{
			m_pointerPositionText.text = inputHandler.CursorPosition.ToString();
			m_prevPointerPos = inputHandler.CursorPosition;
		}
		m_pointerStateText.text = (inputHandler.IsPointerDown() ? "Down" : "Up");
		if (inputHandler.IsPointerPressed())
		{
			m_pointerPressFrameText.text = Time.frameCount.ToString();
		}
		if (m_pendingMessages)
		{
			RefreshLogText();
			m_pendingMessages = false;
		}
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
		{
			m_touchPhaseText.text = inputHandler.TouchAsMenuCursorPhase.ToString();
		}
		m_pointerOverUIText.text = (inputHandler.IsPointerOverGameObject() ? "On" : "Off");
	}

	private void OnControllerInputTypeChanged()
	{
		m_controllerInputTypeText.text = inputHandler.CurrentControllerInputType.ToString();
		if (inputHandler.CurrentControllerInputType != inputHandler.ControllerInputType.Touch)
		{
			m_touchPhaseText.text = "N/A";
		}
	}

	public static void Log(string msg)
	{
		if (!(m_instance == null))
		{
			m_instance.LogMsg(msg);
		}
	}

	public void LogMsg(string msg)
	{
		int count = m_logMessages.Count;
		if (count >= m_maxLogs)
		{
			m_logMessages.RemoveRange(0, count - m_maxLogs + 1);
		}
		m_logMessages.Add(msg);
		m_pendingMessages = true;
	}

	public void SetLogWindowVisibility(bool isVisible)
	{
		m_logWindow.gameObject.SetActive(isVisible);
	}

	public void SetLogWindowInteractable(bool isInteractable)
	{
		m_logWindowCanvasGroup.blocksRaycasts = isInteractable;
		m_logWindowCanvasGroup.interactable = isInteractable;
	}

	public void ClearLog()
	{
		m_logMessages.Clear();
		RefreshLogText();
	}

	private void RefreshLogText()
	{
		string text = "";
		foreach (string logMessage in m_logMessages)
		{
			text = text + logMessage + "\n";
		}
		m_uiDebugLogText.text = text;
	}
}
