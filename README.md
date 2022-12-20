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

https://user-images.githubusercontent.com/29656921/208698200-be671ae5-5d1d-403c-b0ef-67d3bcab0503.mov

<br>



https://user-images.githubusercontent.com/29656921/208698872-52d2d7fc-1d58-4122-b95f-79f44f1ce5bc.mp4




[^1]: Fußnote ein.
