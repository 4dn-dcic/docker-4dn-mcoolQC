import click
import json
import cooler
import numpy as np


@click.command()
@click.argument('mcoolfile')
@click.argument('outdir')
@click.argument('filename')
def main(mcoolfile, outdir, filename):
    f = mcoolfile
    failed_balancing = []
    resolutions_in_file = []
    report = {}
    log = {}
    # Get the list of resolutions
    resolutions = cooler.fileops.list_coolers(f)

    for res in resolutions:
        cooler_path = str(f) + '::' + res
        c = cooler.Cooler(cooler_path)
        binsize = c.info['bin-size']
        resolutions_in_file.append(str(binsize))
        click.echo('working on: ' + str(binsize) + ' resolution')
        if 'weight' in c.bins():
            weights = c.bins()['weight']
            try:
                non_convergence = np.isnan(weights).all()
            except Exception as e:
                log[binsize] = str(e)
                continue
        else:
            non_convergence = True

        if non_convergence:
            failed_balancing.append(str(binsize))
        click.echo(str(binsize) + ' completed')

    if not failed_balancing:
        failed_balancing.append('None')

    report['Failed Balancing'] = failed_balancing
    report['Resolutions in File'] = resolutions_in_file
    outpath = outdir + '/' + filename + '.json'
    with open(outpath, 'w') as outfile:
        json.dump(report, outfile, indent=2)

    if log:
        click.echo(log)


if __name__ == "__main__":
    main()
