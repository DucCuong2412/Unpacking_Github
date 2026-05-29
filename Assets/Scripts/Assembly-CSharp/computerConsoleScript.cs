using System.Collections.Generic;
using UnityEngine;

public class computerConsoleScript : computerScript
{
	private televisionDisplayScript m_television;

	public int m_televisionId;

	public string m_itemController;

	public string[] m_itemControllerVariant;

	private List<itemScript> m_controllers = new List<itemScript>();

	public override bool usesTelevision => true;

	protected override void Init()
	{
		if (!m_init)
		{
			gameScript gameScript2 = Object.FindObjectOfType<gameScript>();
			m_init = true;
			m_originalParent = base.transform.parent;
			if (gameScript2 != null)
			{
				m_audioWheel = gameScript2.audioWheel;
			}
		}
	}

	public override void PickedUp()
	{
		SetAll(-1);
		if (m_television != null)
		{
			m_television = null;
		}
		m_controllers.Clear();
	}

	public void Off()
	{
		SetAll(-2);
	}

	public override void SetTelevision(televisionDisplayScript _television)
	{
		Init();
		m_television = _television;
	}

	public override void AddItem(itemScript _item)
	{
		Init();
		string value = _item.name.Replace("(Clone)", "");
		if (!m_itemController.Equals(value))
		{
			return;
		}
		if (m_itemControllerVariant.Length == 0)
		{
			m_controllers.Add(_item);
			return;
		}
		string value2 = _item.m_variants[_item.GetVariant()].name;
		for (int i = 0; i < m_itemControllerVariant.Length; i++)
		{
			if (m_itemControllerVariant[i].Equals(value2))
			{
				m_controllers.Add(_item);
				break;
			}
		}
	}

	public override void RemoveItem(itemScript _item)
	{
		if (m_controllers.Contains(_item))
		{
			m_controllers.Remove(_item);
		}
	}

	protected override bool CanStart()
	{
		if (m_television == null || m_controllers.Count == 0)
		{
			return false;
		}
		return true;
	}

	protected override void SetAll(int _value)
	{
		if (m_active || _value >= 0)
		{
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
				text = m_audioStopOverride;
				break;
			case -1:
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
			if (m_television != null)
			{
				m_television.Display((_value > -1) ? this : null, _value > 0);
			}
			for (int i = 0; i < m_controllers.Count; i++)
			{
				m_controllers[i].ComputerDisplay(_value);
			}
		}
	}
}
