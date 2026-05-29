using System;
using UnityEngine;

public class computerDesktopScript : computerScript
{
	[Serializable]
	public struct computerParts
	{
		public int m_stage;

		public string[] m_itemsRequired;

		public string[] m_itemsStartup;

		public string[] m_itemsOptional;
	}

	public computerParts[] m_parts;

	private itemScript[] m_itemsRequired;

	private itemScript[] m_itemsStartup;

	private itemScript[] m_itemsOptional;

	private int m_index = -1;

	public override void ChangeState(itemScript.itemState _state)
	{
		if (m_displayScript != null)
		{
			m_displayScript.ChangeState(_state);
		}
	}

	protected override void Init()
	{
		if (m_init)
		{
			return;
		}
		gameScript gameScript2 = UnityEngine.Object.FindObjectOfType<gameScript>();
		if (gameScript2 == null)
		{
			m_itemsRequired = new itemScript[0];
			m_itemsStartup = new itemScript[0];
			m_itemsOptional = new itemScript[0];
			m_init = true;
			return;
		}
		int currentStage = gameScript2.currentStage;
		for (int i = 0; i < m_parts.Length; i++)
		{
			if (m_parts[i].m_stage == currentStage)
			{
				m_index = i;
				break;
			}
		}
		if (m_index > -1)
		{
			m_itemsRequired = new itemScript[m_parts[m_index].m_itemsRequired.Length];
			m_itemsStartup = new itemScript[m_parts[m_index].m_itemsStartup.Length];
			m_itemsOptional = new itemScript[m_parts[m_index].m_itemsOptional.Length];
		}
		else
		{
			m_itemsRequired = new itemScript[0];
			m_itemsStartup = new itemScript[0];
			m_itemsOptional = new itemScript[0];
		}
		m_init = true;
		m_originalParent = base.transform.parent;
		m_audioWheel = gameScript2.audioWheel;
	}

	public override void PickedUp()
	{
		if (m_index == -1)
		{
			return;
		}
		SetAll(-1);
		for (int i = 0; i < m_itemsRequired.Length; i++)
		{
			if (m_itemsRequired[i] != null)
			{
				m_itemsRequired[i] = null;
			}
		}
		for (int j = 0; j < m_itemsStartup.Length; j++)
		{
			if (m_itemsStartup[j] != null)
			{
				m_itemsStartup[j] = null;
			}
		}
		for (int k = 0; k < m_itemsOptional.Length; k++)
		{
			if (m_itemsOptional[k] != null)
			{
				m_itemsOptional[k] = null;
			}
		}
	}

	public override void AddItem(itemScript _item)
	{
		Init();
		if (m_index == -1)
		{
			return;
		}
		string value = _item.name.Replace("(Clone)", "");
		for (int i = 0; i < m_parts[m_index].m_itemsRequired.Length; i++)
		{
			if (m_parts[m_index].m_itemsRequired[i].Equals(value))
			{
				m_itemsRequired[i] = _item;
				return;
			}
		}
		for (int j = 0; j < m_parts[m_index].m_itemsStartup.Length; j++)
		{
			if (m_parts[m_index].m_itemsStartup[j].Equals(value))
			{
				m_itemsStartup[j] = _item;
				return;
			}
		}
		for (int k = 0; k < m_parts[m_index].m_itemsOptional.Length; k++)
		{
			if (m_parts[m_index].m_itemsOptional[k].Equals(value))
			{
				m_itemsOptional[k] = _item;
				if (m_active)
				{
					_item.ComputerDisplay(0, GetLongestTime());
				}
				break;
			}
		}
	}

	private float GetLongestTime()
	{
		float num = 1f;
		for (int i = 0; i < m_itemsRequired.Length; i++)
		{
			num = Mathf.Min(num, m_itemsRequired[i].GetComputerDisplayTime());
		}
		return num;
	}

	public override void RemoveItem(itemScript _item)
	{
		if (m_index == -1)
		{
			return;
		}
		for (int i = 0; i < m_itemsRequired.Length; i++)
		{
			if (m_itemsRequired[i] == _item)
			{
				SetAll(-1);
				m_itemsRequired[i] = null;
				return;
			}
		}
		for (int j = 0; j < m_itemsStartup.Length; j++)
		{
			if (m_itemsStartup[j] == _item)
			{
				m_itemsStartup[j].ComputerDisplay(-1);
				m_itemsStartup[j] = null;
				return;
			}
		}
		for (int k = 0; k < m_itemsOptional.Length; k++)
		{
			if (m_itemsOptional[k] == _item)
			{
				m_itemsOptional[k].ComputerDisplay(-1);
				m_itemsOptional[k] = null;
				break;
			}
		}
	}

	protected override bool CanStart()
	{
		if (m_itemsRequired == null || m_itemsRequired.Length == 0)
		{
			return false;
		}
		for (int i = 0; i < m_itemsRequired.Length; i++)
		{
			if (m_itemsRequired[i] == null)
			{
				return false;
			}
		}
		for (int j = 0; j < m_itemsStartup.Length; j++)
		{
			if (m_itemsStartup[j] == null)
			{
				return false;
			}
		}
		return true;
	}

	protected override void SetAll(int _value)
	{
		if (!m_active && _value == -1)
		{
			return;
		}
		m_active = _value > -1;
		if (m_active)
		{
			base.transform.localPosition = Vector3.forward * (0f - base.transform.parent.position.z);
			base.transform.parent = m_audioWheel;
		}
		else
		{
			base.transform.parent = m_originalParent;
			base.transform.localPosition = Vector3.forward * (0f - base.transform.parent.position.z);
		}
		string text;
		switch (_value)
		{
		default:
			text = m_audioStop;
			break;
		case 1:
			text = m_audioContinue;
			break;
		case 0:
			text = m_audioStart;
			break;
		}
		string text2 = text;
		if (!string.IsNullOrEmpty(text2))
		{
			m_audioID = AkSoundEngine.PostEvent(text2, base.gameObject);
		}
		if (m_displayScript != null)
		{
			m_displayScript.ComputerDisplay(_value);
		}
		for (int i = 0; i < m_itemsRequired.Length; i++)
		{
			if (m_itemsRequired[i] != null)
			{
				m_itemsRequired[i].ComputerDisplay(_value);
			}
		}
		for (int j = 0; j < m_itemsStartup.Length; j++)
		{
			if (m_itemsStartup[j] != null)
			{
				m_itemsStartup[j].ComputerDisplay(_value);
			}
		}
		for (int k = 0; k < m_itemsOptional.Length; k++)
		{
			if (m_itemsOptional[k] != null)
			{
				m_itemsOptional[k].ComputerDisplay(_value);
			}
		}
	}
}
