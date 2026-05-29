using System.Collections;
using UnityEngine;

public class albumManagerScript : MonoBehaviour
{
	[Header("debug")]
	public bool debugForceUnlock;

	[Header("WWise Events")]
	public string m_audioSelectAlbum;

	public string m_audioAlbumReturn;

	public string m_audioAlbumDrop;

	public string m_audioMainMenuReturn;

	[Space(10f)]
	public string m_audioAlbumSlideOut;

	public string m_audioAlbumSlideIn;

	[Space(10f)]
	public string m_audioAlbumOpen;

	public string m_audioAlbumClose;

	public string m_audioAlbumPageTurn;

	public string m_audioStickerUnlock;

	public string m_audioStageStart;

	public string m_audioStageLoad;

	public string m_audioShowStickers;

	public string m_audioStartClone;

	public string m_audioAlbumReturnAction;

	[Space(10f)]
	public string m_audioAlbumNameEntryStart;

	public string m_audioAlbumNameEntrySuccess;

	[Space(10f)]
	public string m_audioDialogShow;

	public string m_audioDialogYes;

	public string m_audioDialogNo;

	[Space(10f)]
	public string m_audioUnlockDialogShow = "dialog_box";

	public string m_audioUnlockDialogClose = "ui_yes";

	[Space(10f)]
	public string m_audioPlaybackDialogShow;

	public string m_audioPlaybackDialogStart;

	public string m_audioPlaybackDialogClose;

	[Space(10f)]
	public string m_audioSliderDown = "ui_slider_down";

	public string m_audioSliderUp = "ui_slider_up";

	[Space(10f)]
	public string m_audioPhotoAdd;

	public string m_audioPhotoCaption;

	public string m_audioAdvanceAppear;

	public string m_audioAdvanceCancel;

	public string m_audioStarAppear;

	public string m_audioStarCancel;

	public string m_audioStarStart;

	public string m_audioStarStop = "complete_sparkle_stop";

	public string m_audioDarkStarAppear;

	public string m_audioDarkStarCancel;

	public string m_audioDarkStarStart;

	public string m_audioDarkStarStop = "dark_star_sparkle_stop";

	[Space(20f)]
	public float m_photoAddDelay;

	public float m_photoAddDelaySticker;

	public Color[] m_colors;

	public Color[] m_bgColors;

	public albumStackScript m_albumStack;

	public albumScript m_albumUse;

	public stickerUnlockScript m_stickerUnlock;

	public CanvasGroup m_unlockInfo;

	public RectTransform m_unlockInfoPanel;

	public CanvasGroup m_unlockInfoDim;

	public AnimationCurve m_unlockInfoCurve;

	private float m_unlockInfoLerp;

	private bool m_unlockInfoShow;

	public int colorCount => m_colors.Length;

	public Color Color(int _index)
	{
		return m_colors[_index % m_colors.Length];
	}

	public Color BgColor(int _index)
	{
		return m_bgColors[Mathf.Min(_index, m_bgColors.Length - 1)];
	}

	public void UnlockAccept()
	{
		if (!string.IsNullOrEmpty(m_audioUnlockDialogClose))
		{
			AkSoundEngine.PostEvent(m_audioUnlockDialogClose, base.gameObject);
		}
		m_unlockInfoShow = false;
	}

	private void Start()
	{
		saveData.LoadFirstSave();
		AkSoundEngine.SetState("Music_State", "album");
		AkSoundEngine.SetState("Game_State", "gameplay");
		m_albumStack.setManager = this;
		gameStateScript.albumLoadState albumLoad = gameStateScript.GetAlbumLoad();
		if (albumLoad == gameStateScript.albumLoadState.none || !saveData.SaveActive)
		{
			m_albumStack.Show();
		}
		else if (albumLoad == gameStateScript.albumLoadState.complete)
		{
			bool flag = CheckStickerUnlock(0.75f);
			m_albumUse.PhotoPlace(gameStateScript.albumPage, flag);
			float delay = (flag ? m_photoAddDelaySticker : m_photoAddDelay);
			StartCoroutine(DelayAudio(delay));
		}
		else
		{
			m_albumUse.Show();
			m_albumUse.ConfigureAlbum(gameStateScript.albumPage);
			m_albumUse.EvalPrevNextButtons();
			m_albumUse.PanNone();
			CheckStickerUnlock();
			if (albumLoad == gameStateScript.albumLoadState.saveError)
			{
				m_albumUse.SaveError();
			}
		}
		if (gameStateScript.ShowGameClearNotify() || debugForceUnlock)
		{
			if (!string.IsNullOrEmpty(m_audioUnlockDialogShow))
			{
				AkSoundEngine.PostEvent(m_audioUnlockDialogShow, base.gameObject);
			}
			m_albumStack.SetInteractive(_value: false);
			GetComponent<CanvasGroup>().interactable = false;
			m_unlockInfoPanel.anchoredPosition = Vector2.up * -800f;
			m_unlockInfo.interactable = false;
			m_unlockInfo.gameObject.SetActive(value: true);
			m_unlockInfoShow = true;
		}
	}

	private void Update()
	{
		bool flag = false;
		if (m_unlockInfoShow)
		{
			if (m_unlockInfoLerp < 1f)
			{
				m_unlockInfoLerp = Mathf.MoveTowards(m_unlockInfoLerp, 1f, Time.deltaTime * 2f);
				if (m_unlockInfoLerp == 1f)
				{
					m_unlockInfo.interactable = true;
				}
				flag = true;
			}
		}
		else if (m_unlockInfoLerp > 0f)
		{
			m_unlockInfoLerp = Mathf.MoveTowards(m_unlockInfoLerp, 0f, Time.deltaTime * 2f);
			m_unlockInfoDim.alpha = m_unlockInfoLerp;
			if (m_unlockInfoLerp == 0f)
			{
				m_albumStack.SetInteractive(_value: true);
				GetComponent<CanvasGroup>().interactable = true;
				m_unlockInfo.gameObject.SetActive(value: false);
			}
			flag = true;
		}
		if (flag)
		{
			m_unlockInfoPanel.anchoredPosition = Vector2.up * Mathf.Lerp(-800f, 0f, m_unlockInfoCurve.Evaluate(m_unlockInfoLerp));
		}
	}

	public bool CheckStickerUnlock(float _delay = 0f)
	{
		Sprite stickerUnlock = gameStateScript.GetStickerUnlock();
		if (stickerUnlock != null)
		{
			if (_delay == 0f)
			{
				AkSoundEngine.PostEvent(m_audioStickerUnlock, base.gameObject);
				m_stickerUnlock.UnlockStickerInAlbum(stickerUnlock, m_albumUse);
			}
			else
			{
				StartCoroutine(DelayStickerUnlock(stickerUnlock, _delay));
			}
			return true;
		}
		return false;
	}

	private IEnumerator DelayStickerUnlock(Sprite _sticker, float _delay)
	{
		yield return new WaitForSeconds(_delay);
		AkSoundEngine.PostEvent(m_audioStickerUnlock, base.gameObject);
		m_stickerUnlock.UnlockStickerInAlbum(_sticker, m_albumUse);
	}

	private IEnumerator DelayAudio(float _delay)
	{
		yield return new WaitForSeconds(_delay);
		if (!string.IsNullOrEmpty(m_audioPhotoAdd))
		{
			AkSoundEngine.PostEvent(m_audioPhotoAdd, base.gameObject);
		}
		vibrationScript.Trigger(vibrationScript.moment.photoPlace);
	}

	public void StackToAlbum(int _index)
	{
		AkSoundEngine.PostEvent(m_audioSelectAlbum, base.gameObject);
		vibrationScript.Trigger(vibrationScript.moment.albumStackLift);
		m_albumStack.PanOut();
		if (saveData.Load(saveData.GetFileIndex(_index)))
		{
			m_albumUse.gameObject.SetActive(value: true);
			m_albumUse.ConfigureAlbum();
			m_albumUse.PanIn();
		}
		else
		{
			m_albumUse.gameObject.SetActive(value: true);
			m_albumUse.NewAlbum(saveData.RemoveMissingSave(_index));
			m_albumUse.PanIn();
		}
	}

	public void CancelAlbumClone()
	{
		AkSoundEngine.PostEvent(m_audioSelectAlbum, base.gameObject);
		m_albumStack.PanOut();
		m_albumUse.gameObject.SetActive(value: true);
		m_albumUse.ConfigureAlbum(-1);
		m_albumUse.PanIn(_reverse: true);
	}

	public void NewAlbum(int _color, bool _clone = false)
	{
		AkSoundEngine.PostEvent(m_audioSelectAlbum, base.gameObject);
		m_albumStack.PanOut();
		m_albumUse.gameObject.SetActive(value: true);
		m_albumUse.NewAlbum(_color, _clone);
		m_albumUse.PanIn();
	}

	public void AlbumSelect(albumStackScript.panInType _panType)
	{
		AkSoundEngine.PostEvent(m_audioAlbumReturn, base.gameObject);
		if (_panType == albumStackScript.panInType.bookDrop)
		{
			AkSoundEngine.PostEvent(m_audioAlbumDrop, base.gameObject);
		}
		m_albumUse.PanOut(_panType == albumStackScript.panInType.delete);
		m_albumStack.PanIn(_panType);
	}

	public void AlbumClone()
	{
		if (!string.IsNullOrEmpty(m_audioStartClone))
		{
			AkSoundEngine.PostEvent(m_audioStartClone, base.gameObject);
		}
		AkSoundEngine.PostEvent(m_audioAlbumReturn, base.gameObject);
		m_albumUse.PanOut(_reverse: true);
		m_albumStack.PanIn(albumStackScript.panInType.selectClone);
	}

	public void Slide(bool _increase)
	{
		AkSoundEngine.PostEvent(_increase ? m_audioSliderUp : m_audioSliderDown, base.gameObject);
	}
}
