# vim: set ft=python:
from os import listdir, getcwd, environ
from os.path import isfile, join
from gi.repository import Gio
from time import sleep
from shutil import which
import random
import sys
import subprocess
import getopt

# from libc.stdlib cimport malloc, free
# from libc.string cimport strcmp
# from cpython.string cimport PyUnicode_AsUTF8
# from cpython.mem cimport PyMem_Malloc, PyMem_Free
#
# cdef extern from "optpsr.h":
#     struct pyx_settings:
#         int duration
#         bint recurse
#
# cdef extern from "optpsr.h":
#     pyx_settings pyx_optpsr(int argc, char ** argv)
#
# cdef extern from "Python.h":
#      const char* PyUnicode_AsUTF8(object unicode)
#
# cdef char **to_cstring_array(list_str):
#      cdef char **ret = <char **>malloc(len(list_str) * sizeof(char *))
#      cdef char *str
#      for idx in xrange(len(list_str)):
#           str = <char *>PyMem_Malloc(len(list_str[idx]) * sizeof(char *))
#           str = PyUnicode_AsUTF8(list_str[idx])
#      free(str)
#      return ret

version = '0.0.1'

def change_background(filename):

     if environ['DESKTOP_SESSION'] in ['gnome', 'unity', 'ubuntu']:
          # using gsettings is not ideal
          # it's incapable of downscaling larger wallpapers
          # therefore, we'll need to.
          gsettings = Gio.Settings.new('org.gnome.desktop.background')

          # zoom is the best setting
          gsettings.set_string('picture-options', 'zoom')

          # time to actually set the background
          print(gsettings.get_string('picture-uri'))
          gsettings.set_string('picture-uri', 'file://%s' % filename)
          gsettings.apply()
          print(gsettings.get_string('picture-uri'))
     else:
          if which('feh') is not None:
               subprocess.run(["feh", "--bg-fill", filename])
          else:
               # TODO:
               # Write a C/Cython backend that will (using imlib2) set the desktop background using a fill option similar to Feh's fill
               pass

def getfiles(path, recurse=False):
     # if recurse:
     #      f = []
     #      (_, _, filenames) = walk(path).next()
     #      print(filenames)
     #      return f
     return [f for f in listdir(path) if isfile(join(path, f))]

def main():
     # argv_out = to_cstring_array(sys.argv)
     #
     # pyx_optpsr(len(sys.argv), argv_out)
     recurse = False
     duration = 60 * 10 # 10 minutes

     # Usage: plethora [OPTION] PATH
     sopts = 'hvrRs:'
     lopts = ['help', 'version', 'recursive', 'sleep:']
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
          elif o in ('-r', '-R', '--recursive'):
               recurse = True
          elif o in ('-s', '--sleep'):
               duration = a

     print("len(args): %s" % len(args))
     print("args: %s" % args)
     print("args[0]: %s" % args[0])

     if len(args) < 1:
               print('%s: missing directory operand' % sys.argv[0])
               sys.exit(1)

     last20 = []
     while True:
          # get random file
          print(args[0])
          file = random.choice(getfiles(args[0], recurse))

          if len(last20) > 19:
               last20.pop()

          if file in last20:
               continue
          else:
               last20 = [file] + last20

          change_background('%s/%s' % (args[0], file))
          sleep(duration)


def usage():
     print(
"""Usage: %s [OPTION]... PATH

  -h, --help			print this message and exit
  -v, --version		print program version and exit
  -R, -r, --recursive	recurse into subdirectories of PATH
  -s, --sleep=SECONDS	sleep for SECONDS before changing wallpaper
""")

if __name__ == '__main__':
     main()
