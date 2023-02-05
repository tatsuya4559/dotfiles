import argparse
import json
import tomllib

parser = argparse.ArgumentParser()
parser.add_argument('src', help='src file')
parser.add_argument('-o', '--output', help='output path', default='out.json')
args = parser.parse_args()

with open(args.src, 'rb') as fp:
    toml = tomllib.load(fp)

result = {}
for snip in toml['snippet']:
    snip['body'] = snip['body'].rstrip().split('\n')
    result[snip['prefix']] = snip

with open(args.output, 'w') as fp:
    json.dump(result, fp, indent=2, ensure_ascii=False)
