using UnityEngine;
using UnityEngine.UI;

public class UI
{
	public static void CreateVerticalNavigationLink(Selectable above, Selectable below)
	{
		if (above != null)
		{
			above.navigation = new Navigation
			{
				mode = Navigation.Mode.Explicit,
				selectOnDown = below,
				selectOnLeft = above.FindSelectableOnLeft(),
				selectOnRight = above.FindSelectableOnRight(),
				selectOnUp = above.FindSelectableOnUp()
			};
		}
		if (below != null)
		{
			below.navigation = new Navigation
			{
				mode = Navigation.Mode.Explicit,
				selectOnUp = above,
				selectOnLeft = below.FindSelectableOnLeft(),
				selectOnRight = below.FindSelectableOnRight(),
				selectOnDown = below.FindSelectableOnDown()
			};
		}
	}

	public static void CreateVerticalNavigationLink(uiGamepadNavigationElement above, uiGamepadNavigationElement below)
	{
		CreateVerticalNavigationLink((above != null) ? above.Selectable : null, (below != null) ? below.Selectable : null);
	}

	public static void CreateHorizontalNavigationLink(Selectable left, Selectable right)
	{
		if (left != null)
		{
			left.navigation = new Navigation
			{
				mode = Navigation.Mode.Explicit,
				selectOnRight = right,
				selectOnLeft = left.FindSelectableOnLeft(),
				selectOnUp = left.FindSelectableOnUp(),
				selectOnDown = left.FindSelectableOnDown()
			};
		}
		if (right != null)
		{
			right.navigation = new Navigation
			{
				mode = Navigation.Mode.Explicit,
				selectOnLeft = left,
				selectOnUp = right.FindSelectableOnUp(),
				selectOnRight = right.FindSelectableOnRight(),
				selectOnDown = right.FindSelectableOnDown()
			};
		}
	}

	public static void CreateHorizontalNavigationLink(uiGamepadNavigationElement left, uiGamepadNavigationElement right)
	{
		CreateHorizontalNavigationLink((left != null) ? left.Selectable : null, (right != null) ? right.Selectable : null);
	}

	public static bool ContainsPoint(RectTransform rectTransform, Vector2 screenPosition, bool includeDescendants = true)
	{
		if (rectTransform == null)
		{
			return false;
		}
		if (RectTransformUtility.RectangleContainsScreenPoint(rectTransform, screenPosition))
		{
			return true;
		}
		if (includeDescendants)
		{
			for (int i = 0; i < rectTransform.childCount; i++)
			{
				if (ContainsPoint(rectTransform.GetChild(i).GetComponent<RectTransform>(), screenPosition, includeDescendants))
				{
					return true;
				}
			}
		}
		return false;
	}
}
