using UnityEngine;
using UnityEngine.UI;

public class stickerUnlockScript : MonoBehaviour
{
	private gameScript m_game;

	private albumScript m_album;

	private Animator m_animator;

	private bool m_sequenceActive;

	public RectTransform m_envelope;

	public RectTransform m_sticker;

	private Image m_stickerImage;

	public RectTransform m_ball;

	private bool m_ballAnimate;

	private float m_ballLerp;

	private Vector2[] m_ballBezier;

	public bool sequenceActive => m_sequenceActive;

	public void Init(gameScript _game)
	{
		m_game = _game;
		Init();
	}

	private void Init()
	{
		m_animator = GetComponent<Animator>();
		m_stickerImage = m_sticker.GetComponent<Image>();
		m_ballBezier = new Vector2[4];
		m_ballBezier[0] = m_ball.anchoredPosition;
		m_ballBezier[1] = m_ball.anchoredPosition + Vector2.right * 50f;
	}

	private void LateUpdate()
	{
		float num = 0f;
		Vector2 anchoredPosition = m_envelope.anchoredPosition;
		anchoredPosition.x = Mathf.Round(anchoredPosition.x);
		num = anchoredPosition.y - Mathf.Round(anchoredPosition.y);
		anchoredPosition.y = Mathf.Round(anchoredPosition.y);
		m_envelope.anchoredPosition = anchoredPosition;
		anchoredPosition = m_sticker.anchoredPosition;
		anchoredPosition.x = Mathf.Round(anchoredPosition.x);
		anchoredPosition.y = Mathf.Round(anchoredPosition.y + num);
		m_sticker.anchoredPosition = anchoredPosition;
		if (m_ballAnimate)
		{
			m_ballLerp += Time.deltaTime * 1.5f;
			float t = Mathf.Pow(m_ballLerp, 3f);
			Vector2 a = Vector2.Lerp(m_ballBezier[0], m_ballBezier[1], t);
			Vector2 vector = Vector2.Lerp(m_ballBezier[1], m_ballBezier[2], t);
			Vector2 b = Vector2.Lerp(m_ballBezier[2], m_ballBezier[3], t);
			Vector2 a2 = Vector2.Lerp(a, vector, t);
			Vector2 b2 = Vector2.Lerp(vector, b, t);
			anchoredPosition = Vector2.Lerp(a2, b2, t);
			anchoredPosition.x = Mathf.Round(anchoredPosition.x);
			anchoredPosition.y = Mathf.Round(anchoredPosition.y);
			m_ball.anchoredPosition = anchoredPosition;
		}
	}

	public void UnlockSticker(Sprite _sticker)
	{
		m_sequenceActive = true;
		m_stickerImage.sprite = _sticker;
		m_stickerImage.SetNativeSize();
		base.gameObject.SetActive(value: true);
		m_animator.Play("sticker_unlock");
		Vector2 vector = m_game.m_photomodeButton.GetComponent<RectTransform>().position - m_ball.position;
		m_ballBezier[3] = m_ballBezier[0] + vector / m_game.m_canvas.scaleFactor + new Vector2(19f, -17f);
		m_ballBezier[2] = m_ballBezier[3] + new Vector2(150f, -50f);
		m_game.interfaceActive = false;
	}

	public void UnlockStickerInAlbum(Sprite _sticker, albumScript _album)
	{
		m_album = _album;
		Init();
		m_sequenceActive = true;
		m_stickerImage.sprite = _sticker;
		m_stickerImage.SetNativeSize();
		base.gameObject.SetActive(value: true);
		m_animator.Play("sticker_unlock");
		m_album.m_buttonStickers.GetComponent<Image>().color = Color.clear;
		RectTransform component = m_album.m_buttonStickers.GetComponent<RectTransform>();
		component.SetParent(component.parent.parent, worldPositionStays: false);
		Camera component2 = GameObject.Find("Canvas Camera").GetComponent<Camera>();
		RectTransform component3 = m_album.GetComponent<RectTransform>();
		RectTransformUtility.ScreenPointToLocalPointInRectangle(component3, component2.WorldToScreenPoint(component.position), component2, out var localPoint);
		RectTransformUtility.ScreenPointToLocalPointInRectangle(component3, component2.WorldToScreenPoint(m_ball.position), component2, out var localPoint2);
		Vector2 vector = localPoint - localPoint2;
		m_ballBezier[3] = m_ballBezier[0] + vector + new Vector2(19f, -17f);
		m_ballBezier[2] = m_ballBezier[3] + new Vector2(150f, -50f);
	}

	public void BallMove()
	{
		m_ballAnimate = true;
		m_ballLerp = 0f;
	}

	public void UnlockComplete()
	{
		m_sequenceActive = false;
		m_ballAnimate = false;
		base.gameObject.SetActive(value: false);
		if (m_ballBezier != null && m_ballBezier.Length != 0)
		{
			m_ball.anchoredPosition = m_ballBezier[0];
		}
		if (m_game != null)
		{
			m_game.interfaceActive = true;
			m_game.PulsePhotomode();
			statsScript.StickerAwardEffect();
		}
		else if (m_album != null)
		{
			m_album.PulseStickerButton();
		}
	}
}
