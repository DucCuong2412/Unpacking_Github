using UnityEngine;

public class shakeScript : attachmentBaseScript
{
	private itemScript m_target;

	private Vector2 m_lastPosition = Vector2.zero;

	private Vector2 m_lastVeloicty = Vector2.zero;

	private float m_lastTime;

	public string m_audio = "";

	public float m_thresholdAngle = 45f;

	public float m_thresholdShift = 10f;

	public float m_maximumShift = 150f;

	public override bool shakable => true;

	private void Start()
	{
		m_target = base.transform.parent.GetComponent<itemScript>();
	}

	public override void NewPosition(Vector2 _position)
	{
		float num = Time.time - m_lastTime;
		if (!(num > 0.03333f))
		{
			return;
		}
		Vector2 vector = (_position - m_lastPosition) / num;
		float sqrMagnitude = vector.sqrMagnitude;
		float sqrMagnitude2 = m_lastVeloicty.sqrMagnitude;
		if (sqrMagnitude > 0.001f || sqrMagnitude2 > 0.001f)
		{
			bool num2 = sqrMagnitude2 < 0.001f || sqrMagnitude < 0.001f || Vector2.Angle(vector, m_lastVeloicty) > m_thresholdAngle;
			float num3 = Vector2.Distance(vector, m_lastVeloicty) / num;
			if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad || inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Touch)
			{
				num3 *= 3f;
			}
			if (num2 && num3 > m_thresholdShift)
			{
				float num4 = Mathf.InverseLerp(m_thresholdShift, m_maximumShift, num3);
				num4 *= num4;
				num4 *= 100f;
				float in_value = ((sqrMagnitude < 0.001f) ? 0f : Mathf.Sign(vector.x));
				if (!string.IsNullOrEmpty(m_audio))
				{
					AkSoundEngine.SetRTPCValue("velocity", num4);
					AkSoundEngine.SetRTPCValue("direction", in_value);
					Camera.main.GetComponent<gameScript>().playAudio(m_audio, "", m_target.audioGO);
				}
			}
		}
		m_lastPosition = _position;
		m_lastVeloicty = vector;
		m_lastTime = Time.time;
	}
}
