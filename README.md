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

[^1]: Fußnote ein.
