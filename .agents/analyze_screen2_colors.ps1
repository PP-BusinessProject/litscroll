$data = Get-Content .agents/full_figma_file.json -Raw | ConvertFrom-Json

function ColorHex($c, $opacity) {
    if ($null -eq $c) { return 'None' }
    $r = [math]::Round(($c.r) * 255)
    $g = [math]::Round(($c.g) * 255)
    $b = [math]::Round(($c.b) * 255)
    $a = if ($null -ne $opacity) { [math]::Round($opacity * 100) } else { 100 }
    return ('#{0:X2}{1:X2}{2:X2} (Opacity: {3}%)' -f $r, $g, $b, $a)
}

function Deep-Colors($node, $depth) {
    $indent = '  ' * $depth
    $type = $node.type
    $name = $node.name
    $id = $node.id
    
    $box = $node.absoluteBoundingBox
    $dim = if ($box) { ('[{0:F0}x{1:F0}px @ x:{2:F0},y:{3:F0}]' -f $box.width, $box.height, $box.x, $box.y) } else { '' }
    
    Write-Output "$indent* [$type] '$name' (id: $id) $dim"
    
    if ($node.fills) {
        foreach ($f in $node.fills) {
            if ($f.type -eq 'SOLID') {
                $hex = ColorHex $f.color $f.opacity
                Write-Output "$indent   |- Fill Color: $hex"
            } elseif ($f.type -like '*GRADIENT*') {
                Write-Output "$indent   |- Gradient Fill: $($f.type)"
                if ($f.gradientStops) {
                    foreach ($stop in $f.gradientStops) {
                        $stopHex = ColorHex $stop.color $stop.color.a
                        Write-Output "$indent   |   |- Stop at $($stop.position): $stopHex"
                    }
                }
            }
        }
    }
    
    if ($node.strokes) {
        foreach ($s in $node.strokes) {
            if ($s.type -eq 'SOLID') {
                $hex = ColorHex $s.color $s.opacity
                Write-Output "$indent   |- Stroke Color: $hex, Weight: $($node.strokeWeight)px"
            }
        }
    }
    
    if ($type -eq 'TEXT') {
        $st = $node.style
        $fontColor = 'Unknown'
        if ($node.fills -and $node.fills.Count -gt 0) {
            $fontColor = ColorHex $node.fills[0].color $node.fills[0].opacity
        }
        $txt = $node.characters
        Write-Output "$indent   |- Text: '$txt'"
        Write-Output "$indent   |- Style: $($st.fontFamily) $($st.fontWeight) $($st.fontSize)px, Color: $fontColor"
    }
    
    if ($node.children) {
        foreach ($c in $node.children) {
            Deep-Colors $c ($depth + 1)
        }
    }
}

function Find-NodeById($n, $targetId) {
    if ($n.id -eq $targetId) { return $n }
    if ($n.children) {
        foreach ($c in $n.children) {
            $res = Find-NodeById $c $targetId
            if ($res) { return $res }
        }
    }
    return $null
}

$screen2 = Find-NodeById $data.document "275:2028"
if ($screen2) {
    Write-Output "=== SCREEN 2 (ID 275:2028) COMPLETE COLOR PALETTE ==="
    Deep-Colors $screen2 0
} else {
    Write-Output "Node 275:2028 not found"
}
