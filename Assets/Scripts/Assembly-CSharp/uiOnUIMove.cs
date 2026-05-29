using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

public class uiOnUIMove : MonoBehaviour, IMoveHandler, IEventSystemHandler
{
	public UnityEvent m_onMoveLeft;

	public UnityEvent m_onMoveRight;

	public UnityEvent m_onMoveUp;

	public UnityEvent m_onMoveDown;

	public void OnMove(AxisEventData eventData)
	{
		switch (eventData.moveDir)
		{
		case MoveDirection.Left:
			m_onMoveLeft?.Invoke();
			break;
		case MoveDirection.Up:
			m_onMoveUp?.Invoke();
			break;
		case MoveDirection.Right:
			m_onMoveRight?.Invoke();
			break;
		case MoveDirection.Down:
			m_onMoveDown?.Invoke();
			break;
		case MoveDirection.None:
			break;
		}
	}
}
