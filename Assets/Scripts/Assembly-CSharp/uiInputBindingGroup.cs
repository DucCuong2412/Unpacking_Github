using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class uiInputBindingGroup : MonoBehaviour
{
	public TextMeshProUGUI m_label;

	public stringIdScript m_labelStringId;

	private string m_groupName = "~unknown~";

	public Image m_gamepadIcon;

	public Image m_kbmIcon;

	public Sprite[] m_switchIcons;

	private bool m_pendingRefresh = true;

	private void Awake()
	{
		m_gamepadIcon.gameObject.SetActive(inputHandler.Instance.IsControllerInputTypeAvailable(inputHandler.ControllerInputType.Gamepad));
		m_kbmIcon.gameObject.SetActive(inputHandler.Instance.IsControllerInputTypeAvailable(inputHandler.ControllerInputType.Keyboard));
	}

	private void Update()
	{
		if (m_pendingRefresh)
		{
			Refresh();
		}
	}

	public void Setup(string groupName)
	{
		m_groupName = groupName;
	}

	private void Refresh()
	{
		m_pendingRefresh = false;
		m_labelStringId.SetString(m_groupName);
	}
}
