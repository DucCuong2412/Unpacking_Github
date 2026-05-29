using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

[ExecuteInEditMode]
public class uiRebindCancelInstruction : MonoBehaviour
{
	public string m_stringGamepadAndKBM = "";

	public string m_stringGamepadOnly = "";

	public TMP_Text m_text;

	public Image m_buttonIcon;

	public float m_buttonIconBuffer = 3f;

	[NonSerialized]
	private char m_characterSubstitute = '·';

	private string m_stringSubstitute = "  ·   ";

	private void Awake()
	{
		Refresh();
	}

	private void OnEnable()
	{
		Refresh();
	}

	private void Refresh()
	{
		if (Application.isPlaying)
		{
			m_text.font = gameStateScript.GetFont(stringIdScript.fontStyle.small);
			string format = gameStateScript.GetString(m_stringGamepadAndKBM);
			string arg = inputHandler.Instance.QueryInputActionStringForDeviceType(inputHandler.ControllerInputType.Keyboard, InputAction.Menu_Back, 0);
			m_text.text = string.Format(format, m_stringSubstitute, arg);
			Sprite[] array = inputHandler.Instance.QueryInputActionIconsForDeviceType(inputHandler.ControllerInputType.Gamepad, InputAction.Menu_Back, 0);
			if (array != null && array.Length != 0)
			{
				Sprite sprite = array[0];
				m_buttonIcon.enabled = sprite != null;
				m_buttonIcon.sprite = sprite;
			}
			else
			{
				m_buttonIcon.enabled = false;
			}
		}
		Vector2 zero = Vector2.zero;
		zero.y = m_buttonIcon.transform.localPosition.y;
		string text = "";
		string text2 = m_text.text;
		for (int i = 0; i < text2.Length; i++)
		{
			char c = text2[i];
			if (c == m_characterSubstitute)
			{
				text += c;
				zero.x += m_text.GetPreferredValues(text).x;
			}
			else
			{
				text += c;
			}
		}
		m_buttonIcon.transform.localPosition = zero;
	}

	private void Update()
	{
		if (!(m_text == null))
		{
			_ = m_buttonIcon == null;
		}
	}
}
