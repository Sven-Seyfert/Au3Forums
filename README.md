# Main title

> Sub title

<br>

``` php
Func _GetSumOfDigitsSquares($iNumber)
    Local $iDigitsCount = StringLen($iNumber)
    Local $iSum

    For $j = 1 To $iDigitsCount Step 1
        $iSum += _GetSquare($iNumber, $j)
    Next

    Return $iSum
EndFunc
```
[^1]

<br>

<details class="details-reset border rounded-2">
<summary class="px-3 py-2 border-bottom">🖼 Gif</summary>

  <img src="https://www.sven-seyfert.de/news/Ardbeg.gif" alt="gif" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px; text-align: center;">

</details>

<br>

<details class="details-reset border rounded-2">
<summary class="px-3 py-2 border-bottom">🎬 Video</summary>

  <video src="https://user-images.githubusercontent.com/169707/126715420-991ad821-9ac8-4b66-b79e-e0966e0f3a89.mp4" controls="controls" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;"></video>

</details>

<br>

<details class="details-reset border rounded-2">
<summary class="px-3 py-2 border-bottom">🔊 Audio</summary>

  <audio src="https://user-images.githubusercontent.com/29656921/208698872-52d2d7fc-1d58-4122-b95f-79f44f1ce5bc.mp4" controls="controls" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;"></audio>

</details>

<br>

<img src="https://www.sven-seyfert.de/news/Ardbeg.gif" alt="gif" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;">
<img src="https://www.sven-seyfert.de/news/Ardbeg.gif" alt="gif" style="max-height: 480px;">
<video src="https://user-images.githubusercontent.com/169707/126715420-991ad821-9ac8-4b66-b79e-e0966e0f3a89.mp4" controls="controls" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;"></video>
<audio src="https://user-images.githubusercontent.com/29656921/208698872-52d2d7fc-1d58-4122-b95f-79f44f1ce5bc.mp4" controls="controls" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;"></audio>

[^1]: Es ist "php" Syntax Highlighting, anstatt "autoit". AutoIt wird von GitHub Pages leider nicht unterstützt.
