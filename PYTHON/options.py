#!/opt/adi/bin/python
# vi: sts=4 sw=4 ts=8

import sys
import getopt
import string


def usage():
    """
    Show usage text.
    """
    progname = os.path.basename(sys.argv[0])
    sys.stderr.write('Usage: %s [-k] [-c comment] [-p password] [-o ou1,ou2] -t D|L|C|S [-g T|S] [-e option1=arg1,option2=arg2...]... computer\n' % progname)
    sys.stderr.write('  -k - kickauth\n')
    sys.stderr.write('  -c - Add the following text as a system description\n')
    sys.stderr.write('  -p - Add a machine password, used for kickstarting and ADI\n')
    sys.stderr.write('  -o - Comma seperated list of Operational Unit(s)\n')
    sys.stderr.write('  -t - Machine type. [D]esktop, [L]aptop, [C]luster or [S]erver\n')
    sys.stderr.write('  -g - Identified the computer belongs to which RHN')
    sys.stderr.write('  -e - Allows setting any AD attributen')

try:
    opts, args = getopt.getopt(sys.argv[1:], 'kc:p:o:t:e:g:')
except getopt.error:
    usage()
    sys.exit(1)

if len(args) != 1:
    usage()
    sys.exit(1)


for opt,val in opts:

    if opt == '-k':
        kickauth = 1
    elif opt == '-o':
        local_ous  = val.split(',')
    elif opt == '-e':
        vals = val.split(',')
        for x in vals:
            try:
                attribute, data = x.split('=')
                if not attrs.has_key(attribute):
                    attrs[attribute] = []
                attrs[attribute].append(data)
            except ValueError:
                sys.stderr.write('Please note the arguments to -e should be fully qualified i.e. -e \'arg1=val1,arg1=val2,arg2=val3\'\n')
                sys.stderr.write('Invalid option %s\n' % ( x ))
                sys.stderr.write('No updates have been made\n')
                sys.exit(1)
    elif opt == '-c':
        attrs['description'] = [val]
    elif opt == '-p':
        password = val
    elif opt == '-t' and val == 'S':
        type = 'Server'
    elif opt == '-t' and val == 'C':
        type = 'Cluster'
    elif opt == '-t' and val == 'D':
        type = 'Desktop'
    elif opt == '-t' and val == 'L':
        type = 'Laptop'
    elif opt == '-t':
        sys.stderr.write('The argument to -t ( %s ) is not valid and will be ignored\n' % ( val ))
        sys.stderr.write('Valid arguments are [S]erver, [D]esktop [C]luster, or [L]aptop\n')
    elif opt == '-g' and val == 'T':
        lnxgroup = 'T-Systems'
    elif opt == '-g' and val == 'S':
        lnxgroup = 'Shell-TLS'
    elif opt == '-g':
        sys.stderr.write('The argument to -g ( %s ) is not valid and will be ignored\n' % ( val ))
        sys.stderr.write('Valid arguments are')
    else:
        sys.stderr.write('Option %s is not recognised.\n' % opt)

