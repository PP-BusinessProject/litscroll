import json
import sys

def parse_node(node, depth=0):
    node_id = node.get('id', '')
    name = node.get('name', '')
    node_type = node.get('type', '')
    
    prefix = "  " * depth
    if node_type in ['FRAME', 'COMPONENT', 'COMPONENT_SET', 'CANVAS', 'TEXT', 'GROUP']:
        info = f"{prefix}[{node_type}] {name} (id: {node_id})"
        if node_type == 'TEXT':
            info += f" -> '{node.get('characters', '')}'"
        print(info)
        
    for child in node.get('children', []):
        parse_node(child, depth + 1)

if __name__ == '__main__':
    with open('.agents/figma_node.json', 'r', encoding='utf-8') as f:
        data = json.load(f)
    
    nodes = data.get('nodes', {})
    for nid, nval in nodes.items():
        doc = nval.get('document', {})
        print(f"--- Node {nid} ---")
        parse_node(doc)
