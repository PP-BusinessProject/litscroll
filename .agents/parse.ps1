$data = Get-Content .agents/figma_node.json -Raw | ConvertFrom-Json
$nodes = $data.nodes

function Walk-Node($node, $depth) {
    if ($depth -gt 6) { return }
    $indent = "  " * $depth
    $type = $node.type
    $name = $node.name
    $chars = if ($node.characters) { " -> '" + $node.characters + "'" } else { "" }
    Write-Output "$indent[$type] $name $chars"
    
    if ($node.children) {
        foreach ($child in $node.children) {
            Walk-Node $child ($depth + 1)
        }
    }
}

foreach ($key in $nodes.psobject.properties.Name) {
    Write-Output "=== NODE $key ==="
    Walk-Node $nodes.$key.document 0
}
