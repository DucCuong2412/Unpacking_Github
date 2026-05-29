public class proximityScript : attachmentBaseScript
{
	public string m_variantName;

	private bool m_init;

	private bool m_proximity;

	public override bool proximity
	{
		get
		{
			Init();
			return m_proximity;
		}
	}

	private void Init()
	{
		if (m_init)
		{
			return;
		}
		m_init = true;
		if (string.IsNullOrEmpty(m_variantName))
		{
			m_proximity = true;
			return;
		}
		itemScript component = base.transform.parent.GetComponent<itemScript>();
		if (component.m_variants[component.GetVariant()].name.Equals(m_variantName))
		{
			m_proximity = true;
		}
	}
}
