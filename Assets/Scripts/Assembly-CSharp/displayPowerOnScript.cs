using UnityEngine;

public class displayPowerOnScript : attachmentBaseScript
{
	public Animator m_animator;

	public Transform[] m_lights;

	public Vector2[] m_posNormal;

	public Vector2[] m_posFlipped;

	private zoneScript m_zone;

	public override void ChangeValidity(bool _value)
	{
		if (_value)
		{
			m_animator.keepAnimatorStateOnDisable = true;
			m_zone = Camera.main.GetComponent<gameScript>().zone;
			m_zone.KeepAliveAdd(m_animator.transform);
			if (m_zone.isLoad)
			{
				m_animator.Play("router_on", 0, 1f);
			}
			else
			{
				m_animator.Play("router_on");
			}
		}
		else
		{
			m_animator.Play("router_off");
			if (m_zone != null)
			{
				m_zone.KeepAliveRemove(m_animator.transform);
				m_zone = null;
			}
		}
	}

	public override void ChangeState(itemScript.itemState _state)
	{
		switch (_state)
		{
		case itemScript.itemState.normal:
		{
			for (int j = 0; j < 4; j++)
			{
				m_lights[j].localPosition = m_posNormal[j];
			}
			break;
		}
		case itemScript.itemState.flipped:
		{
			for (int i = 0; i < 4; i++)
			{
				m_lights[i].localPosition = m_posFlipped[i];
			}
			break;
		}
		}
	}

	public override void DestroyItem()
	{
		if (m_zone != null)
		{
			m_zone.KeepAliveRemove(m_animator.transform);
			m_zone = null;
		}
		if (m_animator.transform.parent != base.transform)
		{
			Object.Destroy(m_animator.gameObject);
		}
	}
}
