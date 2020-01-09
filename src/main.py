from os import listdir, getcwd
from os.path import isfile, join
from gi.repository import Gio
from time import sleep
import random
import sys
import subprocess
import getopt

version = '0.0.1'

def change_background(filename):
     # gsettings = Gio.Settings.new('org.gnome.desktop.background')
     # print(gsettings.get_string('picture-uri'))
     # gsettings.set_string('picture-uri', 'file://%s' % filename)
     # gsettings.apply()
     # print(gsettings.get_string('picture-uri'))
     subprocess.run(["feh", "--bg-fill", filename])

def getfiles(path):
     return [f for f in listdir(path) if isfile(join(path, f))]

def main():
     last20 = []
     while True:
          # get random file
          file = random.choice(getfiles(sys.argv[1]))

          if len(last20) > 19:
               last20.pop()

          if file in last20:
               continue
          else:
               last20 = [file] + last20

          change_background('%s/%s' % (sys.argv[1], file))
          sleep(10)


def usage():
     print(
"""Usage: %s [OPTION]... PATH

  -h, --help			print this message and exit
  -v, --version		print program version and exit
  -R, -r, --recursive 	recurse into subdirectories of PATH
""")

if __name__ == '__main__':
     # Usage: plethora [OPTION] PATH
     sopts = 'hvrRt:'
     lopts = ['help', 'version', 'recursive', 'duration:']
     try:
          opts, args = getopt.gnu_getopt(sys.argv[1:], sopts, lopts)
     except:
          print(err)
          usage()
          sys.exit(1)

     for o, a in opts:
          if o in ('-h', '--help'):
               usage()
               sys.exit()
          elif o in '-v':
               print(version)
               sys.exit()

     if len(sys.argv) < 2:
               print('%s: missing directory operand' % sys.argv[0])
               sys.exit(1)
     main()
