import json
import sys
import tomllib

content = ''.join(sys.stdin.readlines())
toml = tomllib.loads(content)

result = {}
for snip in toml['snippet']:
    snip['body'] = snip['body'].rstrip().split('\n')
    result[snip['prefix']] = snip

print(json.dumps(result, indent=2, ensure_ascii=False))
