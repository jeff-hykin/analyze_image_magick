#include <ios>                   // part of creating clear_cin
#include <istream>               // part of creating clear_cin
#include <iostream>              // cout , getline 
#include <string>                // strings 
#include <sstream>               // stringstreams 
#include <vector>                // vectors
#include <cmath>                 // abs , pow 
#include <regex>                 // regular expressions 
#include <stdlib.h>              // exit(0) 
#include <stdio.h>               //
#include <iomanip>               // setw , setprecision , showpoint , fixed 
#include <limits>                // inf, max:: 
#include <fstream>               // fstream , .open() , .close()
#include <algorithm>             // min ()
#include <random>                // rand()
#include <cctype>                // isalpha()
#include <sys/time.h>            // gettimeofday()
#include <time.h>                // time()
#include <ctime>                 // time stuff
#include <chrono>                // sleep_for() , sleep_until
#include <thread>                // system_clock, seconds
#include <map>                   // maps / dictionarys 
#include <bitset>                // binary output/input
#include <sys/mman.h>            // used in ReadFile
#include <sys/stat.h>            // used in ReadFile
#include <fcntl.h>               // used in ReadFile, used in Threads
#include <pthread.h>             // threads 
#include <type_traits>           // used in converting lambda to function pointer 
#include <utility>               // used in converting lambda to function pointer 
#include <float.h> 
#include <math.h>
#include <stdlib.h> // piping
#include <unistd.h> // piping
#include <stdio.h>
#include <map>
#include <vector>
#include <iostream>
#include <fcntl.h>           /* For O_* constants */
#include <sys/stat.h>        /* For mode constants */
#include <semaphore.h>

using namespace std;

#include <cxxabi.h>
template <class ANYTYPE>
string Type(ANYTYPE input)
    {
        stringstream output;
        int status;
        char * demangled = abi::__cxa_demangle(typeid(input).name(),0,0,&status);
        output << demangled ;
        free(demangled);
        return output.str();
    }



int main(int argc, char *argv[])
    {
        // 
        // VULN 2
        // 
        // g++ -std=c++14 "scratch.cpp" -o scratch && "$PWD/"scratch  
        // char *SanitizeString(const char *source) {
        //     char
        //         *sanitize_source;
        // 
        //     const char
        //         *q;
        // 
        //     char
        //         *p;
        // 
        //     static char
        //         allowlist[] =
        //         "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "
        //         "$-_.+!*'(),{}|\\^~[]`\"><#%;/?:@&=";
        // 
        //     sanitize_source=(char*) source;
        //     p=sanitize_source;
        //     q=sanitize_source+strlen(sanitize_source);
        //     for (p+=strspn(p,allowlist); p != q; p+=strspn(p,allowlist))
        //         *p='_';
        //     return(sanitize_source);
        // }
        // char pdf_command[4096] = "pdf_read ";
        // // a malicious file name
        // char pdf_name[] = "hello_world.txt;cd /Users/jeffhykin/repos/standard_install/manual_resources/scratchwork; cat jackpot.txt";
        // strcat(pdf_command, pdf_name);
        // // ""sanitize""
        // auto sanitize_command = SanitizeString(pdf_command);
        // // run
        // auto status = system(sanitize_command);
        
        // 
        // VULN #1
        // 
        // ➜ g++ -std=c++11 -fsanitize=address,undefined,safe-stack "_.cpp" -o _ && "/Users/jeffhykin/repos/standard_install/manual_resources/scratchwork/"_
        // {
        //     auto MagickPathExtent = 4096;
        //     char *p, DONT_TOUCH_THIS[MagickPathExtent], path[MagickPathExtent];
        //     strcpy(DONT_TOUCH_THIS, "HOWDY!");
        //     path[0] = 0;
        //     p = getenv("SRCDIR");
        //     if (p != (char*) NULL)
        //     {
        //         (void) strcpy(path,p);
        //         auto length = strlen(path);
        //         auto lastIndex = strlen(path)-1;
        //         if (path[lastIndex] != '/') {
        //             (void) strcat(path, "/");
        //         } 
        //     }
        //     // Should say HOWDY!
        //     cout << "DONT_TOUCH_THIS = " << (DONT_TOUCH_THIS) << "\n";
        // }
        return 0;
    }