using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class albumStackScript : MonoBehaviour
{
	private enum panType
	{
		none = 0,
		panIn = 1,
		panOut = 2
	}

	public enum panInType
	{
		bookDrop = 0,
		selectClone = 1,
		cancel = 2,
		cancelNoReturn = 3,
		delete = 4
	}

	private bool m_interactive = true;

	private albumManagerScript m_manager;

	public CanvasGroup m_ui;

	public albumItemScript m_albumPrefab;

	public GameObject[] m_uiSelect;

	public GameObject[] m_uiClone;

	public Transform m_shadow;

	public Transform m_shadowTip;

	public Transform m_checkerboard;

	private int m_existingSaves;

	private bool m_cloneAlbum;

	private albumItemScript[] m_albumStack;

	private albumItemScript m_selectedItem;

	private int m_lastSelectedAlbum;

	private panType m_pan;

	private float m_panValue;

	public AnimationCurve m_panCurve;

	public albumManagerScript setManager
	{
		set
		{
			m_manager = value;
		}
	}

	public void SetInteractive(bool _value)
	{
		m_interactive = _value;
		GetComponent<menuUINavSimulator>().enabled = _value;
	}

	public void Show()
	{
		Show(_value: true);
		ConfigureStack(_showAll: true);
	}

	private void Show(bool _value)
	{
		if (_value)
		{
			m_pan = panType.none;
			m_panValue = 0f;
			Camera.main.transform.localPosition = Vector3.forward * -10f;
			base.gameObject.SetActive(value: true);
			m_ui.gameObject.SetActive(value: true);
			m_ui.interactable = true;
			m_ui.blocksRaycasts = true;
		}
		else
		{
			base.gameObject.SetActive(value: false);
			m_ui.gameObject.SetActive(value: false);
		}
	}

	public void PanOut()
	{
		m_pan = panType.panOut;
		m_panValue = 0f;
		m_ui.interactable = false;
		m_ui.blocksRaycasts = false;
		m_ui.GetComponent<RectTransform>().sizeDelta = Vector2.one;
	}

	public void PanIn(panInType _panType)
	{
		m_pan = panType.panIn;
		m_panValue = 0f;
		Camera.main.transform.localPosition = new Vector3(0f, 15f, -10f);
		base.gameObject.SetActive(value: true);
		m_ui.gameObject.SetActive(value: true);
		m_ui.interactable = false;
		m_ui.blocksRaycasts = false;
		m_ui.GetComponent<RectTransform>().sizeDelta = Vector2.one * 60f * 2f;
		ConfigureStack(_panType != panInType.selectClone);
		if (_panType == panInType.bookDrop)
		{
			m_albumStack[0].Place();
			vibrationScript.Trigger(vibrationScript.moment.albumStackReturn);
		}
		if (inputHandler.CurrentControllerInputType == inputHandler.ControllerInputType.Gamepad)
		{
			if (_panType != panInType.cancel)
			{
				SelectAlbum(0);
			}
			else
			{
				SetAlbumSelection(m_albumStack[m_lastSelectedAlbum], isSelected: true);
			}
		}
		if (_panType == panInType.cancel)
		{
			m_albumStack[m_lastSelectedAlbum].Replace();
		}
	}

	private void ConfigureStack(bool _showAll)
	{
		if (m_albumStack != null && m_albumStack.Length != 0)
		{
			for (int i = 0; i < m_albumStack.Length; i++)
			{
				Object.Destroy(m_albumStack[i].gameObject);
			}
		}
		albumManagerScript albumManagerScript2 = Object.FindObjectOfType<albumManagerScript>();
		int colorCount = albumManagerScript2.colorCount;
		saveData.saveScrape[] array = saveData.LoadScrape();
		List<int> list = new List<int>();
		saveData.saveScrape[] array2 = array;
		for (int j = 0; j < array2.Length; j++)
		{
			saveData.saveScrape saveScrape = array2[j];
			if (!list.Contains(saveScrape.color))
			{
				list.Add(saveScrape.color);
			}
		}
		m_cloneAlbum = !_showAll;
		for (int k = 0; k < m_uiSelect.Length; k++)
		{
			m_uiSelect[k].SetActive(_showAll);
		}
		for (int l = 0; l < m_uiClone.Length; l++)
		{
			m_uiClone[l].SetActive(!_showAll);
		}
		if (_showAll)
		{
			m_existingSaves = array.Length;
			m_albumStack = new albumItemScript[Mathf.Clamp(array.Length + 1, 3, 5)];
		}
		else
		{
			m_existingSaves = 0;
			m_albumStack = new albumItemScript[Mathf.Min(3, colorCount - list.Count)];
			array = new saveData.saveScrape[0];
		}
		Vector3 vector = new Vector3(-2.2f, -1.055f, 0f);
		float num = 0.41f;
		vector.y += num * (float)(m_albumStack.Length - 1);
		float[] array3 = new float[5] { 0.08f, 0f, 0.06f, -0.08f, -0.02f };
		for (int m = 0; m < m_albumStack.Length; m++)
		{
			m_albumStack[m] = Object.Instantiate(m_albumPrefab, base.transform);
			m_albumStack[m].transform.localPosition = vector - Vector3.right * array3[m];
			m_albumStack[m].transform.SetSiblingIndex(0);
			vector.y -= num;
			vector.z += 0.25f;
			if (m > 0)
			{
				m_albumStack[m].ShowShadow((array3[m] - array3[m - 1]) * 0.5f);
			}
			if (m < array.Length)
			{
				int stageComplete = ((array[m].stageComplete > 8) ? 8 : array[m].stageReached);
				int completeState = ((array[m].stageComplete > 8) ? ((array[m].stageComplete == 9) ? 1 : 2) : 0);
				m_albumStack[m].Set(albumManagerScript2.Color(array[m].color), array[m].color, array[m].name, stageComplete, completeState);
				continue;
			}
			int num2 = 0;
			int num3 = 0;
			while (list.Contains(num2) && num3 < colorCount)
			{
				num2 = (num2 + 1) % colorCount;
				num3++;
			}
			m_albumStack[m].Set(albumManagerScript2.Color(num2), num2, "", -1, 0);
			list.Add(num2);
		}
		float num4 = Mathf.Round(Mathf.InverseLerp(3f, 5f, m_albumStack.Length) * 34f) * -0.01f;
		base.transform.localPosition = Vector3.up * num4;
		OnControllerInputTypeChanged();
	}

	private void OnEnable()
	{
		inputHandler.OnControllerInputTypeChanged.AddListener(OnControllerInputTypeChanged);
		gameStateScript.GetCursor().Behaviour = uiCursor.CursorBehaviour.ManualCursorState;
	}

	private void OnDisable()
	{
		inputHandler.OnControllerInputTypeChanged.RemoveListener(OnControllerInputTypeChanged);
	}

	private void Update()
	{
		uiCursor.cursorState cursorState = (EventSystem.current.IsPointerOverGameObject() ? uiCursor.cursorState.valid : uiCursor.cursorState.none);
		if (!m_interactive)
		{
			gameStateScript.GetCursor().SetCursorState(cursorState);
			return;
		}
		if (m_pan != panType.none)
		{
			m_panValue += Time.deltaTime;
			if (m_pan == panType.panOut)
			{
				float num = m_panCurve.Evaluate(m_panValue) * 15f;
				Camera.main.transform.localPosition = new Vector3(0f, Mathf.Round(num * 100f) / 100f, -10f);
				m_checkerboard.localPosition = new Vector3(0f, Mathf.Repeat(Mathf.Round(num * -0.1f * 100f) / 100f, 0.64f), 15f);
				float num2 = Mathf.InverseLerp(0f, 0.5f, m_panValue);
				num2 *= num2;
				m_ui.GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(60f * num2) * 2f;
				if (m_panValue >= 1f)
				{
					Show(_value: false);
				}
			}
			else
			{
				float num3 = m_panCurve.Evaluate(Mathf.InverseLerp(1f, 0f, m_panValue)) * 15f;
				Camera.main.transform.localPosition = new Vector3(0f, Mathf.Round(num3 * 100f) / 100f, -10f);
				m_checkerboard.localPosition = new Vector3(0f, Mathf.Repeat(Mathf.Round(num3 * -0.1f * 100f) / 100f, 0.64f), 15f);
				float num4 = Mathf.InverseLerp(1f, 0.5f, m_panValue);
				num4 *= num4;
				m_ui.GetComponent<RectTransform>().sizeDelta = Vector2.one * Mathf.Round(60f * num4) * 2f;
				if (m_panValue >= 1f)
				{
					Show(_value: true);
				}
			}
		}
		else
		{
			switch (inputHandler.CurrentControllerInputType)
			{
			case inputHandler.ControllerInputType.Keyboard:
			{
				Vector3 position = inputHandler.CursorPosition;
				Vector3 vector2 = Camera.main.ScreenToWorldPoint(position);
				int num6 = -1;
				for (int l = 0; l < m_albumStack.Length; l++)
				{
					if (m_albumStack[l].GetComponent<PolygonCollider2D>().OverlapPoint(vector2))
					{
						if (num6 == -1)
						{
							num6 = l;
						}
						cursorState = uiCursor.cursorState.valid;
					}
				}
				for (int m = 0; m < m_albumStack.Length; m++)
				{
					SetAlbumSelection(m_albumStack[m], m == num6);
					if (m == num6 && inputHandler.IsPressed(InputAction.Gameplay_LiftAndPlace, ignoreInputHandled: true))
					{
						OnPullItem(m_albumStack[m], m);
					}
				}
				break;
			}
			case inputHandler.ControllerInputType.Gamepad:
			{
				if (!inputHandler.IsPressed(InputAction.Menu_Accept) || !(m_selectedItem != null))
				{
					break;
				}
				for (int k = 0; k < m_albumStack.Length; k++)
				{
					if (m_selectedItem == m_albumStack[k])
					{
						OnPullItem(m_albumStack[k], k);
					}
				}
				break;
			}
			case inputHandler.ControllerInputType.Touch:
			{
				if (inputHandler.TouchCount <= 0)
				{
					break;
				}
				Touch touchAtIdx = inputHandler.GetTouchAtIdx(0);
				Vector3 vector = Camera.main.ScreenToWorldPoint(touchAtIdx.position);
				int num5 = -1;
				for (int i = 0; i < m_albumStack.Length; i++)
				{
					if (m_albumStack[i].GetComponent<PolygonCollider2D>().OverlapPoint(vector))
					{
						if (num5 == -1)
						{
							num5 = i;
						}
						cursorState = uiCursor.cursorState.valid;
					}
				}
				for (int j = 0; j < m_albumStack.Length; j++)
				{
					SetAlbumSelection(m_albumStack[j], j == num5);
					if (j == num5 && touchAtIdx.phase == TouchPhase.Ended)
					{
						OnPullItem(m_albumStack[j], j);
					}
				}
				break;
			}
			}
		}
		gameStateScript.GetCursor().SetCursorState(cursorState);
	}

	private void LateUpdate()
	{
		for (int i = 1; i < m_albumStack.Length; i++)
		{
			m_albumStack[i].SetShadow(m_albumStack[i - 1].GetPosition());
		}
		int position = m_albumStack[m_albumStack.Length - 1].GetPosition();
		m_shadow.localPosition = new Vector3(-0.02f, -0.01f, 0f) * position;
		m_shadowTip.localPosition = Vector3.up * (Mathf.Round((float)position * 2.5f) * -0.01f + 0.025f);
	}

	private void OnControllerInputTypeChanged()
	{
		switch (inputHandler.CurrentControllerInputType)
		{
		case inputHandler.ControllerInputType.Keyboard:
			m_selectedItem = null;
			break;
		case inputHandler.ControllerInputType.Gamepad:
		{
			if (m_selectedItem != null && !m_selectedItem.selected)
			{
				m_selectedItem = null;
			}
			for (int i = 0; i < m_albumStack.Length; i++)
			{
				if (m_selectedItem == null && i == 0)
				{
					m_selectedItem = m_albumStack[i];
				}
				SetAlbumSelection(m_albumStack[i], m_selectedItem == m_albumStack[i]);
			}
			break;
		}
		case inputHandler.ControllerInputType.Unknown:
			break;
		}
	}

	public void SelectAlbum(int selectionDirection)
	{
		if (m_albumStack.Length == 0)
		{
			Debug.LogWarning("Empty album stack!");
			return;
		}
		selectionDirection = Mathf.Clamp(selectionDirection, -1, 1);
		int num = 0;
		if (m_selectedItem != null)
		{
			for (int i = 0; i < m_albumStack.Length; i++)
			{
				if (m_selectedItem == m_albumStack[i])
				{
					num = i;
					break;
				}
			}
		}
		else
		{
			selectionDirection = 0;
		}
		num = Mathf.Clamp(num + selectionDirection, 0, m_albumStack.Length - 1);
		for (int j = 0; j < m_albumStack.Length; j++)
		{
			SetAlbumSelection(m_albumStack[j], num == j);
		}
	}

	private void SetAlbumSelection(albumItemScript albumItem, bool isSelected)
	{
		if (albumItem == null)
		{
			Debug.LogError("Null albumItemScript!");
			return;
		}
		if (albumItem.Select(isSelected))
		{
			AkSoundEngine.PostEvent(isSelected ? m_manager.m_audioAlbumSlideOut : m_manager.m_audioAlbumSlideIn, albumItem.gameObject);
		}
		if (isSelected)
		{
			m_selectedItem = albumItem;
		}
	}

	public void ReturnToTitle()
	{
		m_ui.interactable = false;
		AkSoundEngine.PostEvent(m_manager.m_audioMainMenuReturn, m_manager.gameObject);
		gameStateScript.SetQuickTitleReturn();
		gameStateScript.LoadSceneFade("title", 0.25f);
	}

	public void OnPullItem(albumItemScript item, int idx = -1)
	{
		if (item == null || idx >= m_albumStack.Length)
		{
			Debug.Log("Null or range error on pulling album item!");
			return;
		}
		if (idx == -1)
		{
			for (int i = 0; i < m_albumStack.Length; i++)
			{
				if (item == m_albumStack[i])
				{
					idx = i;
					break;
				}
			}
		}
		item.Pull();
		if (idx < m_existingSaves)
		{
			m_manager.StackToAlbum(idx);
			return;
		}
		m_manager.NewAlbum(item.colorIndex, m_cloneAlbum);
		m_lastSelectedAlbum = idx;
	}
}
