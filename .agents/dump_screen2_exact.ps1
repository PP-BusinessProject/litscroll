$data = Get-Content .agents/full_figma_file.json -Raw | ConvertFrom-Json

function ColorHex($c) {
    if ($null -eq $c) { return 'None' }
    $r = [int]($c.r * 255)
    $g = [int]($c.g * 255)
    $b = [int]($c.b * 255)
    return ('#' + $r.ToString('X2') + $g.ToString('X2') + $b.ToString('X2'))
}

function Dump-Subtree($n, $d) {
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
            Dump-Subtree $c ($d + 1)
        }
    }
}

# Find top screen frame (ID 275:2028 or width ~ 360, height >= 800)
function Find-Screen2Frame($n) {
    if ($n.type -eq 'FRAME' -and $n.absoluteBoundingBox -and $n.absoluteBoundingBox.width -ge 350 -and $n.absoluteBoundingBox.width -le 370 -and $n.absoluteBoundingBox.x -ge 1100 -and $n.absoluteBoundingBox.x -le 1300) {
        return $n
    }
    if ($n.children) {
        foreach ($c in $n.children) {
            $res = Find-Screen2Frame $c
            if ($res) { return $res }
        }
    }
    return $null
}

$screenFrame = Find-Screen2Frame $data.document
if ($screenFrame) {
    Write-Output "FOUND SCREEN 2 ROOT FRAME: $($screenFrame.name) ($($screenFrame.id))"
    Dump-Subtree $screenFrame 0
} else {
    Write-Output 'Screen 2 Root Frame not found'
}
