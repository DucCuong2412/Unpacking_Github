using UnityEngine;

[RequireComponent(typeof(groundNodeDefineScript))]
public class simpleLayerMaskScript : MonoBehaviour
{
	public int m_maskLevel = -1;

	public void Init(zoneScript _zone)
	{
		groundNodeDefineScript component = GetComponent<groundNodeDefineScript>();
		if (component != null)
		{
			component.Register(_zone);
			_zone.SetGridMaskLevel(component.index, component.m_xWidth, component.m_yWidth, m_maskLevel);
		}
		else
		{
			Debug.LogWarning("script not attached to an groundNodeDefineScript instance!!!");
		}
	}
}
