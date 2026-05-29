using UnityEngine;
using UnityEngine.Events;

public class animEventPassthrough : MonoBehaviour
{
	public UnityEvent m_event;

	private void AnimTrigger()
	{
		m_event.Invoke();
	}
}
