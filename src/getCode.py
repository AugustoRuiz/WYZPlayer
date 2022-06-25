# GetCode.py
# Gets the assembler code for a given machine, in a given configuration

import argparse

BASE_VERSION = 'WYZPROPLAY50'

parser = argparse.ArgumentParser(description='Gets WYZ''s player assembler code for a given machine.')

parser.add_argument('--machine', dest='machine', help='The machine you want to generate code for. Valid values are: msx, zx or cpc.', default='msx', choices=['msx','zx','cpc'])
parser.add_argument('--msx', action='store_const', dest='machine', const='msx', help='Generates code for MSX machines. Default value.')
parser.add_argument('--zx', action='store_const', dest='machine', const='zx', help='Generates code for ZX Spectrum machines')
parser.add_argument('--cpc', action='store_const', dest='machine', const='cpc', help='Generates code for Amstrad CPC machines')

parser.add_argument('--memtype', dest='memtype', default='rom', help='Specifies whether the player code is to be placed in ROM or RAM.',choices=['rom','ram'])
parser.add_argument('--rom', action='store_const', dest='memtype', const='rom')
parser.add_argument('--ram', action='store_const', dest='memtype', const='ram')

parser.add_argument('--assembler', dest='assembler', default='asmsx', help='Specifies the assembler to use for the code.',choices=['asmsx','pasmo', 'asz80'])
parser.add_argument('--asmsx', action='store_const', dest='assembler', const='asmsx')
parser.add_argument('--pasmo', action='store_const', dest='assembler', const='pasmo')
parser.add_argument('--asz80', action='store_const', dest='assembler', const='asz80')

argValues = parser.parse_args()

print("Generating code for {machine} in {memtype} configuration. Assemble with {assembler}.".format(machine=argValues.machine, memtype=argValues.memtype, assembler=argValues.assembler))

