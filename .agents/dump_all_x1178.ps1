$data = Get-Content .agents/full_figma_file.json -Raw | ConvertFrom-Json

function ColorHex($c) {
    if ($null -eq $c) { return 'None' }
    $r = [int]($c.r * 255)
    $g = [int]($c.g * 255)
    $b = [int]($c.b * 255)
    return ('#' + $r.ToString('X2') + $g.ToString('X2') + $b.ToString('X2'))
}

function Dump-Node($n, $d) {
    $indent = '  ' * $d
    $type = $n.type
    $name = $n.name
    $id = $n.id
    
    $box = $n.absoluteBoundingBox
    $w = if ($box) { [math]::Round($box.width, 1) } else { 0 }
    $h = if ($box) { [math]::Round($box.height, 1) } else { 0 }
    $x = if ($box) { [math]::Round($box.x, 1) } else { 0 }
    $y = if ($box) { [math]::Round($box.y, 1) } else { 0 }
    
    Write-Output ($indent + '* [' + $type + '] ' + $name + ' (ID: ' + $id + ') [' + $w + 'x' + $h + 'px @ x:' + $x + ', y:' + $y + ']')
    
    if ($n.fills) {
        foreach ($f in $n.fills) {
            if ($f.type -eq 'SOLID' -and $f.color) {
                $hex = ColorHex $f.color
                Write-Output ($indent + '   |- Fill Color: ' + $hex + ' (Opacity: ' + $f.opacity + ')')
            }
        }
    }
    
    if ($n.strokes) {
        foreach ($s in $n.strokes) {
            if ($s.type -eq 'SOLID' -and $s.color) {
                $hex = ColorHex $s.color
                Write-Output ($indent + '   |- Border Color: ' + $hex + ' (Weight: ' + $n.strokeWeight + 'px)')
            }
        }
    }
    
    if ($type -eq 'TEXT') {
        $st = $n.style
        $fontColor = 'None'
        if ($n.fills -and $n.fills.Count -gt 0 -and $n.fills[0].color) {
            $fontColor = ColorHex $n.fills[0].color
        }
        $txt = $n.characters
        Write-Output ($indent + '   |- Text: ' + $txt)
        Write-Output ($indent + '   |- Style: ' + $st.fontFamily + ' ' + $st.fontWeight + ' ' + $st.fontSize + 'px, Color: ' + $fontColor)
    }
    
    if ($n.children) {
        foreach ($c in $n.children) {
            Dump-Node $c ($d + 1)
        }
    }
}

# Find all children of Frame 275:255 that lie around x:1178..1500
function Find-Screen2Elements($n) {
    if ($n.id -eq '275:255') {
        foreach ($c in $n.children) {
            if ($c.absoluteBoundingBox -and $c.absoluteBoundingBox.x -ge 1170 -and $c.absoluteBoundingBox.x -le 1540) {
                Dump-Node $c 0
            }
        }
    } else {
        if ($n.children) {
            foreach ($c in $n.children) {
                Find-Screen2Elements $c
            }
        }
    }
}

Write-Output "=== SCREEN 2 ALL ELEMENTS AND COLORS ==="
Find-Screen2Elements $data.document
