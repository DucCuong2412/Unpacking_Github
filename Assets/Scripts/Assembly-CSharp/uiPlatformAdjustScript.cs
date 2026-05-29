using UnityEngine;
using UnityEngine.UI;

public class uiPlatformAdjustScript : MonoBehaviour
{
	public enum platform
	{
		none = 0,
		pc = 2,
		nx = 4,
		xb = 8,
		ps4 = 0x10,
		ps5 = 0x20
	}

	public enum adjust
	{
		hide = 0,
		shift = 1
	}

	[EnumFlag]
	public platform m_platform;

	public bool m_inverse;

	public adjust m_action;

	public float m_shift;

	private void Start()
	{
		bool flag = false;
		flag = (platform.pc & m_platform) == platform.pc;
		if (m_inverse)
		{
			flag = !flag;
		}
		if (!flag)
		{
			return;
		}
		if (m_action == adjust.hide)
		{
			base.gameObject.SetActive(value: false);
			Selectable[] componentsInChildren = GetComponentsInChildren<Selectable>();
			foreach (Selectable selectable in componentsInChildren)
			{
				selectable.interactable = false;
				if (selectable.navigation.selectOnUp != null && selectable.navigation.selectOnUp.navigation.selectOnDown == selectable)
				{
					Navigation navigation = selectable.navigation.selectOnUp.navigation;
					navigation.selectOnDown = selectable.navigation.selectOnDown;
					selectable.navigation.selectOnUp.navigation = navigation;
				}
				if (selectable.navigation.selectOnDown != null && selectable.navigation.selectOnDown.navigation.selectOnUp == selectable)
				{
					Navigation navigation2 = selectable.navigation.selectOnDown.navigation;
					navigation2.selectOnUp = selectable.navigation.selectOnUp;
					selectable.navigation.selectOnDown.navigation = navigation2;
				}
			}
		}
		else if (m_action == adjust.shift)
		{
			Vector3 localPosition = base.transform.localPosition;
			localPosition.y += m_shift;
			base.transform.localPosition = localPosition;
		}
	}
}
