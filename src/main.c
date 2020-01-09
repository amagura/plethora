#include <stdio.h>
#include <stdlib.h>
#include <getopt.h>

#ifndef PROGNAME
# define PROGNAME "plethora"
#endif

#define pl_arg(opt, desc, tabs)                        \
     do {                                              \
          printf("  %s%s%s\n", (opt),(tabs),(desc));   \
     } while(0)

void usage()
{
     printf("Usage: %s [OPTION]... PATH\n\n", PROGNAME);
     pl_arg("-h, --help", "print this message and exit", "\t\t\t");
     pl_arg("-v, --version", "print program version and exit", "\t\t");
     pl_arg("-R, -r, --recursive", "recurse into subdirectories of PATH", "\t");
     pl_arg("-s, --sleep=SECONDS", "sleep for seconds before changing wallpaper", "\t");
}


int main(int argc, char **argv)
{
     int *optc = 0;
     int c = 0;

     char *sopts = "hvrRs:";
     struct option lopts[] = {
          {"help", no_argument, 0, 'h'},
          {"version", no_argument, 0, 'v'},
          {"recursive", no_argument, 0, 'r'},
          {"sleep", required_argument, 0, 's'},
          {0,0,0,0}
     };

     while ((c = getopt_long(argc, argv, sopts, lopts, optc)) != EOF) {
          if (optopt != 0)
               goto fail;

          switch(c) {
          case 'h':
               usage();
               goto fail;
          }
     }

     goto win;
fail:
     return EXIT_FAILURE;
win:
     return EXIT_SUCCESS;
}
