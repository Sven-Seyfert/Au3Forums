# Main title

> Sub title

<br>

<details>
<summary>Code example</summary>

``` autoit
Func _GetSumOfDigitsSquares($iNumber)
    Local $iDigitsCount = StringLen($iNumber)
    Local $iSum

    For $j = 1 To $iDigitsCount Step 1
        $iSum += _GetSquare($iNumber, $j)
    Next

    Return $iSum
EndFunc
```

Test[^1]
</details>

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

![gif1](https://www.sven-seyfert.de/news/Ardbeg.gif)

<br>

<img src="https://www.sven-seyfert.de/news/Ardbeg.gif" alt="gif2" style="max-height:640px;">

<br>

[video](https://user-images.githubusercontent.com/29656921/208698200-be671ae5-5d1d-403c-b0ef-67d3bcab0503.mov)

<br>

[audio](https://user-images.githubusercontent.com/29656921/208698872-52d2d7fc-1d58-4122-b95f-79f44f1ce5bc.mp4)

[^1]: Fußnote ein.

<details open="" class="details-reset border rounded-2">
  <summary class="px-3 py-2 border-bottom">
    <svg aria-hidden="true" viewBox="0 0 16 16" version="1.1" data-view-component="true" height="16" width="16" class="octicon octicon-device-camera-video">
    <path fill-rule="evenodd" d="..."></path>
</svg>
    <span aria-label="Video description dotnet-evergreen.mp4" class="m-1">dotnet-evergreen.mp4</span>
    <span class="dropdown-caret"></span>
  </summary>

  <video src="https://user-images.githubusercontent.com/169707/126715420-991ad821-9ac8-4b66-b79e-e0966e0f3a89.mp4" data-canonical-src="https://user-images.githubusercontent.com/169707/126715420-991ad821-9ac8-4b66-b79e-e0966e0f3a89.mp4" controls="controls" muted="muted" class="d-block rounded-bottom-2 width-fit" style="max-height:640px;">

  </video>
</details>

<br>
<br>
<br>

<details open class="details-reset border rounded-2">
<summary class="px-3 py-2 border-bottom">test</summary>

  <video src="https://user-images.githubusercontent.com/29656921/208698200-be671ae5-5d1d-403c-b0ef-67d3bcab0503.mov" controls="controls" muted="false" style="max-height: 640px;"></video>

</details>
