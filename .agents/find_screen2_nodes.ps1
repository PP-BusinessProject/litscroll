$data = Get-Content .agents/full_figma_file.json -Raw | ConvertFrom-Json

function Search-Text($node) {
    if ($node.type -eq 'TEXT') {
        $txt = $node.characters
        $id = $node.id
        Write-Output "TEXT: '$txt' (ID: $id)"
    }
    if ($node.children) {
        foreach ($c in $node.children) {
            Search-Text $c
        }
    }
}

Search-Text $data.document
