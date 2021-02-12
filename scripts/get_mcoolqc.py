import click
import json


@click.command()
@click.argument('infile')
@click.argument('outdir')
@click.argument('filename')
def main(infile, outdir, filename):
    output = {'Failed Balancing': []}
    with open(infile) as f:
        data = f.readlines()
    info = {}
    keep_fields = ['converged']
    prev_binsize = None
    for item in data:
        ele = item.strip().split(':')
        print(ele)
        if ele[0] == 'bin-size':
            prev_binsize = ele[1].strip()
            if prev_binsize not in info:
                info[prev_binsize] = {}
        if ele[0] in keep_fields:
            info[prev_binsize][ele[0]] = ele[1].strip()
    print(info)

    for k, v in info.items():
        if v['converged'] == 'false':
            output['Failed Balancing'].append(k)

    print(output)
    outpath = outdir + '/' + filename + '.json'
    with open(outpath, 'w') as outfile:
        json.dump(output, outfile, indent=2)


if __name__ == "__main__":
    main()
