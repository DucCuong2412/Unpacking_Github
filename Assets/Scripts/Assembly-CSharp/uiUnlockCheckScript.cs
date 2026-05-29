using UnityEngine;
using UnityEngine.UI;

public class uiUnlockCheckScript : MonoBehaviour
{
	private void Awake()
	{
		if (!gameStateScript.GameClear())
		{
			base.gameObject.SetActive(value: false);
			Selectable componentInChildren = base.gameObject.GetComponentInChildren<Selectable>();
			if (componentInChildren != null)
			{
				componentInChildren.interactable = false;
			}
		}
	}
}
