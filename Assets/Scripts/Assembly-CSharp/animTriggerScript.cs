using UnityEngine;

public class animTriggerScript : MonoBehaviour
{
	public string m_trigger;

	private void Start()
	{
		if (!string.IsNullOrEmpty(m_trigger))
		{
			GetComponent<Animator>().SetTrigger(m_trigger);
		}
	}
}
