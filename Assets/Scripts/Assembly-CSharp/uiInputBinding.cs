using UnityEngine;
using UnityEngine.UI;

public abstract class uiInputBinding : MonoBehaviour
{
	public InputAction m_inputAction;

	public virtual Selectable Selectable { get; }

	public abstract void OnRebindStarted();

	public abstract void OnRebindOver();

	public abstract void OnBindingsRefresh();
}
