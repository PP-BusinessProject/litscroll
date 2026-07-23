$data = Get-Content .agents/full_figma_file.json -Raw | ConvertFrom-Json

function ColorHex($c) {
    if ($null -eq $c) { return 'None' }
    $r = [int]($c.r * 255)
    $g = [int]($c.g * 255)
    $b = [int]($c.b * 255)
    return ('#' + $r.ToString('X2') + $g.ToString('X2') + $b.ToString('X2'))
}

function Extract-Colors($node, $path) {
    $currentPath = "$path > $($node.name)"
    
    if ($node.fills) {
        foreach ($f in $node.fills) {
            if ($f.type -eq 'SOLID' -and $f.color) {
                $hex = ColorHex $f.color
                Write-Output "FILL: $hex | Element: $($node.name) ($($node.type)) | Path: $currentPath"
            }
        }
    }
    
    if ($node.strokes) {
        foreach ($s in $node.strokes) {
            if ($s.type -eq 'SOLID' -and $s.color) {
                $hex = ColorHex $s.color
                Write-Output "STROKE: $hex (weight: $($node.strokeWeight)px) | Element: $($node.name)"
            }
        }
    }
    
    if ($node.type -eq 'TEXT') {
        $st = $node.style
        $fontColor = 'None'
        if ($node.fills -and $node.fills.Count -gt 0 -and $node.fills[0].color) {
            $fontColor = ColorHex $node.fills[0].color
        }
        $txt = $node.characters
        Write-Output "TEXT: '$txt' | Color: $fontColor | Size: $($st.fontSize)px $($st.fontWeight)"
    }
    
    if ($node.children) {
        foreach ($c in $node.children) {
            Extract-Colors $c $currentPath
        }
    }
}

# Search for node containing 'Discover how reading feels reimagined'
function Find-Screen2Root($n) {
    if ($n.type -eq 'TEXT' -and $n.characters -like '*Discover how reading feels reimagined*') {
        return $n
    }
    if ($n.children) {
        foreach ($c in $n.children) {
            $res = Find-Screen2Root $c
            if ($res) { return $res }
        }
    }
    return $null
}

# Search entire tree for all nodes under parent of text 275:2057
$textNode = Find-Screen2Root $data.document
if ($textNode) {
    Write-Output "Found Text Node ID: $($textNode.id)"
}

Write-Output "=== SCREEN 2 COMPLETE COLOR PALETTE ==="
Extract-Colors $data.document 'Root'
