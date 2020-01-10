/****
Copyright 2020 Alexej Magura

This file is a part of Plethora

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
****/
#ifndef PL_MAIN_H_GUARD
# define PL_MAIN_H_GUARD 1
/* PARAMS is a macro used to wrap function prototypes, so that
  compilers that don't understand ANSI C prototypes still work,
  and ANSI C compilers can issue warnings about type mismatches. */
# undef PARAMS
# if defined (__STDC__) || defined (_AIX)		\
     || (defined (__mips) && defined (_SYSTYPE_SVR4))	\
     || defined(WIN32) || defined(__cplusplus)
#  define PARAMS(protos) protos
# else
#  define PARAMS(protos) ()
# endif

struct settings {
     int duration;
     short recurse;
};

#endif /* PL_MAIN_H_GUARD */
