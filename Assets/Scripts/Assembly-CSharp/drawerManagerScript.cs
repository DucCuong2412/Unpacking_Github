using System.Collections.Generic;
using UnityEngine;

public class drawerManagerScript : MonoBehaviour
{
	private zoneScript m_zone;

	public zoneScript.direction m_direction;

	public drawerScript[] m_drawerStack;

	public groundNodeDefineScript m_drawerGroundNode;

	public groundNodeDefineScript m_drawerInFrontNode;

	public groundNodeDefineScript[] m_drawerInFrontAdditional;

	public int m_groundBoost;

	private int m_activeDrawers;

	public doorScript m_doorBlocker;

	public doorScript[] m_doorUnder;

	public vibrationScript.moment m_vibrationTrigger;

	public vibrationScript.moment m_vibrationCollision = vibrationScript.moment.collision;

	public zoneScript zone => m_zone;

	public bool isOpen => m_activeDrawers > 0;

	public int Register(zoneScript _zone, int _usableIndex)
	{
		m_zone = _zone;
		if ((bool)m_drawerGroundNode)
		{
			m_drawerGroundNode.Register(m_zone);
		}
		AkAuxSendArray akAuxSendArray = new AkAuxSendArray();
		akAuxSendArray.Add(m_zone.reverbID, 1f);
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			AkSoundEngine.SetGameObjectAuxSendValues(m_drawerStack[i].Register(this, m_direction, _usableIndex), akAuxSendArray, 1u);
			_usableIndex++;
		}
		if ((bool)m_drawerInFrontNode)
		{
			m_drawerInFrontNode.Register(m_zone);
			m_zone.SetGridMaskLevel(m_drawerInFrontNode.index, m_drawerInFrontNode.m_xWidth, m_drawerInFrontNode.m_yWidth, 1 + m_groundBoost);
		}
		if (m_drawerInFrontAdditional != null)
		{
			for (int j = 0; j < m_drawerInFrontAdditional.Length; j++)
			{
				m_drawerInFrontAdditional[j].Register(m_zone);
				m_zone.SetGridMaskLevel(m_drawerInFrontAdditional[j].index, m_drawerInFrontAdditional[j].m_xWidth, m_drawerInFrontAdditional[j].m_yWidth, 1 + m_groundBoost);
			}
		}
		return _usableIndex;
	}

	public void ClearItems()
	{
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			m_drawerStack[i].ClearItems();
		}
	}

	private void Update()
	{
		for (int num = m_drawerStack.Length - 1; num >= 0; num--)
		{
			m_drawerStack[num].ManualUpdate();
		}
	}

	public void TryClose(ref List<int> _useList)
	{
		if (m_activeDrawers > 0)
		{
			for (int num = m_drawerStack.Length - 1; num >= 0; num--)
			{
				m_drawerStack[num].TryClose(ref _useList);
			}
		}
	}

	public bool CheckClosed()
	{
		for (int num = m_drawerStack.Length - 1; num >= 0; num--)
		{
			if (!m_drawerStack[num].isClosed)
			{
				return false;
			}
		}
		return true;
	}

	public void Impact()
	{
		float num = 0f;
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			if (!m_drawerStack[i].isClosed)
			{
				m_drawerStack[i].Impact(num);
				num -= 0.3f;
			}
		}
	}

	public void EvaulateOpenDrawers()
	{
		bool flag = false;
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			if (m_drawerStack[i].isOpen)
			{
				m_drawerStack[i].ActivateNodes(!flag);
				flag = true;
			}
			else
			{
				flag = false;
			}
		}
	}

	public void EnableDrawers(bool _value)
	{
		for (int num = m_drawerStack.Length - 1; num >= 0; num--)
		{
			m_drawerStack[num].GetComponent<Collider2D>().enabled = _value;
		}
	}

	public zoneScript.CheckResult TrySpace(int _height, ref List<int> _useList)
	{
		if ((bool)m_doorBlocker && !m_doorBlocker.TryClose(ref _useList))
		{
			return new zoneScript.CheckResult(10, null);
		}
		zoneScript.CheckResult result = ((m_drawerGroundNode == null) ? new zoneScript.CheckResult(-1, null) : ((m_activeDrawers <= 0) ? m_zone.CheckGridHeight(m_drawerGroundNode.index, m_drawerGroundNode.m_xWidth, m_drawerGroundNode.m_yWidth, _height, _height + 1, m_direction) : m_zone.CheckGrid(m_drawerGroundNode.index, m_drawerGroundNode.m_xWidth, m_drawerGroundNode.m_yWidth, _height, m_direction)));
		if (!result.result)
		{
			int num = _height;
			for (int num2 = m_drawerStack.Length - 1; num2 >= 0; num2--)
			{
				num = Mathf.Min(num, m_drawerStack[num2].drawHeight);
			}
			if (m_drawerGroundNode != null)
			{
				m_zone.SetGridSize(m_drawerGroundNode.index, m_drawerGroundNode.m_xWidth, m_drawerGroundNode.m_yWidth, num);
			}
			RefreshDoorGridSize();
			m_activeDrawers++;
		}
		return result;
	}

	public void ClearSpace()
	{
		int num = 99;
		for (int num2 = m_drawerStack.Length - 1; num2 >= 0; num2--)
		{
			num = Mathf.Min(num, m_drawerStack[num2].drawHeight);
		}
		if (m_drawerGroundNode != null)
		{
			m_zone.SetGridSize(m_drawerGroundNode.index, m_drawerGroundNode.m_xWidth, m_drawerGroundNode.m_yWidth, num);
		}
		RefreshDoorGridSize();
		m_activeDrawers--;
	}

	private void RefreshDoorGridSize()
	{
		if (m_doorUnder == null)
		{
			return;
		}
		for (int i = 0; i < m_doorUnder.Length; i++)
		{
			if (m_doorUnder[i] != null)
			{
				m_doorUnder[i].RefreshGridSize();
			}
		}
	}

	public void RefreshGridSize()
	{
		if (m_drawerGroundNode != null)
		{
			int num = 99;
			for (int num2 = m_drawerStack.Length - 1; num2 >= 0; num2--)
			{
				num = Mathf.Min(num, m_drawerStack[num2].drawHeight);
			}
			if (num < 99)
			{
				m_zone.SetGridSize(m_drawerGroundNode.index, m_drawerGroundNode.m_xWidth, m_drawerGroundNode.m_yWidth, num);
			}
		}
	}

	public void AudioHit(itemScript _item)
	{
		gameScript component = Camera.main.GetComponent<gameScript>();
		component.AudioPlace(_item, _collision: true);
		component.BounceStart(_item);
		vibrationScript.Trigger(m_vibrationCollision);
	}

	public saveData.saveDataZone.saveDataDrawerManager GetSaveData()
	{
		bool[] array = new bool[m_drawerStack.Length];
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			array[i] = m_drawerStack[i].isOpen;
		}
		return new saveData.saveDataZone.saveDataDrawerManager(array);
	}

	public bool PlaybackUse(int _index, bool _animate)
	{
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			if (m_drawerStack[i].PlaybackUse(_index, _animate))
			{
				return true;
			}
		}
		return false;
	}

	public bool PlaybackMoving()
	{
		for (int i = 0; i < m_drawerStack.Length; i++)
		{
			if (m_drawerStack[i].PlaybackMoving())
			{
				return true;
			}
		}
		return false;
	}

	public void SetSaveData(bool[] _open)
	{
		m_activeDrawers = 0;
		for (int i = 0; i < Mathf.Min(m_drawerStack.Length, _open.Length); i++)
		{
			m_drawerStack[i].SetSaveData(_open[i]);
			if (_open[i])
			{
				m_activeDrawers++;
			}
		}
		int num = 99;
		for (int num2 = m_drawerStack.Length - 1; num2 >= 0; num2--)
		{
			num = Mathf.Min(num, m_drawerStack[num2].drawHeight);
		}
		if (m_drawerGroundNode != null)
		{
			m_zone.SetGridSize(m_drawerGroundNode.index, m_drawerGroundNode.m_xWidth, m_drawerGroundNode.m_yWidth, num);
		}
		RefreshDoorGridSize();
		EvaulateOpenDrawers();
	}
}
