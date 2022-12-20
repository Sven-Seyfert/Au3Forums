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

  <img src="https://www.sven-seyfert.de/news/Ardbeg.gif" alt="gif" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;">

</details>

<br>

<details class="details-reset border rounded-2">
<summary class="px-3 py-2 border-bottom">🎬 Video</summary>

  <video src="https://user-images.githubusercontent.com/29656921/208698872-52d2d7fc-1d58-4122-b95f-79f44f1ce5bc.mp4" controls="controls" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;"></video>

</details>

<br>

<details class="details-reset border rounded-2">
<summary class="px-3 py-2 border-bottom">🔊 Audio</summary>

  <audio src="https://user-images.githubusercontent.com/29656921/208698872-52d2d7fc-1d58-4122-b95f-79f44f1ce5bc.mp4" controls="controls" class="d-block rounded-bottom-2 width-fit" style="max-height: 480px;"></audio>

</details>

[^1]: Es ist "php" Syntax Highlighting, anstatt "autoit". AutoIt wird von GitHub Pages leider nicht unterstützt.
