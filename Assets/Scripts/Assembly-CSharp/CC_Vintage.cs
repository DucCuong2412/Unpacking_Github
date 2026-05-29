using UnityEngine;

[ExecuteInEditMode]
[AddComponentMenu("Colorful/Vintage")]
public class CC_Vintage : CC_LookupFilter
{
	public enum Filter
	{
		None = 0,
		F1977 = 1,
		Aden = 2,
		Amaro = 3,
		Brannan = 4,
		Crema = 5,
		Earlybird = 6,
		Hefe = 7,
		Hudson = 8,
		Inkwell = 9,
		Juno = 10,
		Kelvin = 11,
		Lark = 12,
		LoFi = 13,
		Ludwig = 14,
		Mayfair = 15,
		Nashville = 16,
		Perpetua = 17,
		Reyes = 18,
		Rise = 19,
		Sierra = 20,
		Slumber = 21,
		Sutro = 22,
		Toaster = 23,
		Valencia = 24,
		Walden = 25,
		Willow = 26,
		XProII = 27
	}

	public Filter filter;

	protected Filter m_CurrentFilter;

	protected override void OnRenderImage(RenderTexture source, RenderTexture destination)
	{
		if (filter != m_CurrentFilter)
		{
			m_CurrentFilter = filter;
			if (filter == Filter.None)
			{
				lookupTexture = null;
			}
			else
			{
				lookupTexture = Resources.Load<Texture2D>("Instagram/" + filter);
			}
		}
		base.OnRenderImage(source, destination);
	}
}
