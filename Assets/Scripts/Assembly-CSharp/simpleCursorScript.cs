using UnityEngine;

public class simpleCursorScript : MonoBehaviour
{
	private uiCursor m_cursor;

	private void Start()
	{
		m_cursor = gameStateScript.GetCursor();
		m_cursor.Behaviour = uiCursor.CursorBehaviour.Default;
	}

	private void Update()
	{
	}
}
