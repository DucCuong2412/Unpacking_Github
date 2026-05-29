using System;
using UnityEngine;

public class titleBackgroundPan : MonoBehaviour
{
	[Serializable]
	public class parallaxLayer
	{
		public Transform layer;

		public float offset;

		public float multiplier = 1f;

		private int m_lastPixel;

		public int lastPixel
		{
			get
			{
				return m_lastPixel;
			}
			set
			{
				m_lastPixel = value;
			}
		}
	}

	public parallaxLayer[] m_layers;

	public Vector2 m_range = new Vector2(5.8f, -5.8f);

	public AnimationCurve m_curve = new AnimationCurve();

	public Transform m_camera;

	private float m_lerp;

	public float m_speed = 0.01f;

	private float m_pixelScale = 2f;

	private float m_orthoSize = 2.7f;

	public float pixelScale
	{
		set
		{
			m_pixelScale = value;
		}
	}

	public float orthoSize
	{
		set
		{
			m_orthoSize = value;
		}
	}

	public void Finish()
	{
		m_lerp = 1f;
	}

	private void Update()
	{
		m_lerp = Mathf.MoveTowards(m_lerp, 1f, Time.deltaTime * m_speed);
		SetLerp(m_curve.Evaluate(m_lerp), _pixel: true);
	}

	public void SetLerp()
	{
		SetLerp(m_curve.Evaluate(m_lerp), _pixel: false);
	}

	public void SetLerp(float _value, bool _pixel)
	{
		if (m_layers == null || m_layers.Length == 0)
		{
			return;
		}
		float num = ((_value > 0f && _value < 1f) ? m_pixelScale : 1f);
		float num2 = Mathf.InverseLerp(2.7f, 7.2f, m_orthoSize);
		float num3 = Mathf.Lerp(m_range.x + num2 * 5f, m_range.y, _value);
		bool flag = true;
		for (int num4 = m_layers.Length - 1; num4 >= 0; num4--)
		{
			if (flag && m_layers[num4].layer != null)
			{
				int num5 = Mathf.CeilToInt((num3 * m_layers[num4].multiplier + m_layers[num4].offset + ((num4 == 0) ? (num2 * 3.25f) : 0f)) * 100f * num);
				if (_pixel)
				{
					if (num5 != m_layers[num4].lastPixel)
					{
						m_layers[num4].lastPixel = num5;
					}
					else
					{
						flag = false;
					}
				}
				else
				{
					m_layers[num4].lastPixel = num5;
				}
				if (flag)
				{
					m_layers[num4].layer.localPosition = new Vector3(0f, (float)num5 / (100f * num), m_layers.Length - num4);
				}
			}
		}
	}
}
