from os import listdir, getcwd
from os.path import isfile, join
from gi.repository import Gio
from time import sleep
import random, sys, argparse

def change_background(filename):
     gsettings = Gio.Settings.new('org.gnome.desktop.background')
     print(gsettings.get_string('picture-uri'))
     gsettings.set_string('picture-uri', 'file://%s' % filename)
     gsettings.apply()
     print(gsettings.get_string('picture-uri'))

def getfiles(path):
     return [f for f in listdir(path) if isfile(join(path, f))]

def main():
     while True:
          # get random file
          file = random.choice(getfiles(sys.argv[1]))
          change_background('%s/%s' % (sys.argv[1], file))
          sleep(60 * 5)

if __name__ == '__main__':
     if len(sys.argv) < 2:
               print('%s: missing directory operand' % sys.argv[0])
               sys.exit(1)
     main()
