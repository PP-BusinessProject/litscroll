$data = Get-Content .agents/full_figma_file.json -Raw | ConvertFrom-Json

function ColorHex($c) {
    if ($null -eq $c) { return 'None' }
    $r = [math]::Round(($c.r) * 255)
    $g = [math]::Round(($c.g) * 255)
    $b = [math]::Round(($c.b) * 255)
    return ('#{0:X2}{1:X2}{2:X2}' -f $r, $g, $b)
}

function Deep-Analyze($node, $depth) {
    $indent = '  ' * $depth
    $type = $node.type
    $name = $node.name
    $id = $node.id
    $box = $node.absoluteBoundingBox
    
    $w = if ($box) { [math]::Round($box.width, 1) } else { 0 }
    $h = if ($box) { [math]::Round($box.height, 1) } else { 0 }
    $x = if ($box) { [math]::Round($box.x, 1) } else { 0 }
    $y = if ($box) { [math]::Round($box.y, 1) } else { 0 }
    
    Write-Output "$indent* [$type] '$name' (id: $id) [$w x $h px @ x:$x, y:$y]"
    
    if ($node.fills) {
        foreach ($f in $node.fills) {
            if ($f.type -eq 'SOLID') {
                $hex = ColorHex $f.color
                Write-Output "$indent   |- Fill Color: $hex (Opacity: $($f.opacity))"
            }
        }
    }
    
    if ($node.strokes) {
        foreach ($s in $node.strokes) {
            if ($s.type -eq 'SOLID') {
                $hex = ColorHex $s.color
                Write-Output "$indent   |- Stroke Color: $hex, Weight: $($node.strokeWeight)px"
            }
        }
    }
    
    if ($node.cornerRadius) {
        Write-Output "$indent   |- Radius: $($node.cornerRadius)px"
    }
    
    if ($node.layoutMode) {
        Write-Output "$indent   |- AutoLayout: $($node.layoutMode), Gap: $($node.itemSpacing)px, Padding: [T:$($node.paddingTop) B:$($node.paddingBottom) L:$($node.paddingLeft) R:$($node.paddingRight)]"
    }
    
    if ($type -eq 'TEXT') {
        $st = $node.style
        $fontColor = 'Unknown'
        if ($node.fills -and $node.fills.Count -gt 0) {
            $fontColor = ColorHex $node.fills[0].color
        }
        $txt = $node.characters
        Write-Output "$indent   |- Text: '$txt'"
        Write-Output "$indent   |- Style: $($st.fontFamily) $($st.fontWeight) $($st.fontSize)px, Color: $fontColor, Align: $($st.textAlignHorizontal), LineHeight: $($st.lineHeightPx)px"
    }
    
    if ($node.children) {
        foreach ($c in $node.children) {
            Deep-Analyze $c ($depth + 1)
        }
    }
}

function Find-Target($n) {
    if ($n.id -eq '275:254' -or ($n.name -eq 'Frame' -and $n.absoluteBoundingBox -and $n.absoluteBoundingBox.width -ge 350 -and $n.absoluteBoundingBox.width -le 370 -and $n.absoluteBoundingBox.height -ge 840 -and $n.absoluteBoundingBox.height -le 855)) {
        return $n
    }
    if ($n.children) {
        foreach ($c in $n.children) {
            $res = Find-Target $c
            if ($res) { return $res }
        }
    }
    return $null
}

$target = Find-Target $data.document
if ($target) {
    Write-Output '=== SCREEN 1 DEEP ANALYSIS ==='
    Deep-Analyze $target 0
} else {
    Write-Output 'Target Screen 1 not found'
}
