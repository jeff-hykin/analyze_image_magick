// This may look like C code, but it's really -*- C++ -*-
/*
 * Copyright (C) 2011 Emweb bv, Herent, Belgium.
 *
 * See the LICENSE file for terms of use.
 */

#ifndef WT_AUTH_UTILS_H_
#define WT_AUTH_UTILS_H_

#include <string>
#include <Wt/WDllDefs.h>

namespace Wt {
  namespace Auth {
    namespace Utils {
      WT_API extern std::string createSalt(unsigned int length);

      // decodeAscii(encodeAscii(a)) == a only if
      // its length multiple of 3 bytes
      WT_API extern std::string encodeAscii(const std::string& a);
      WT_API extern std::string decodeAscii(const std::string& a);

      extern std::string encodeState(const std::string &secret, const std::string &url);
      extern std::string decodeState(const std::string &secret, const std::string &state);

      extern std::string configurationProperty(const std::string &prefix,
                                               const std::string &property);
    }
  }
}

#endif // WT_AUTH_UTILS_H_
