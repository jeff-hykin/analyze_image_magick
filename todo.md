Write a Report

- 10 Vulnerabilities
    - 1. `getenv`
        - Mention env var size limits
        - Mention TV / Watch OS, and sudo, and lack of stack space randomization
    - 2. 
        - ./examples/blog/model/BlogSession.C:48:  [4] (crypto) crypt:
    - 3. 
        - ./examples/hangman/Session.C:44:  [4] (crypto) crypt:
    - 4. 
        -  ./src/Wt/Date/src/tz.cpp:3253
        

- include vulnerabilities from at least 3 of the following categories:
  1. Spatial Memory Attacks: Out-of-bound access, buffer/stack/heap overflow
  2. Temporal Memory Attacks: Use-after-free, double-free
  3. Control Flow Attacks: Control-flow hijacking, arbitrarycodeexecution,return-oriented programming
  4. ConcurrencyAttacks: Race conditions, data dependency attacks, time-to-check-to-time-to-use
  5. APIattack: Privilege escalation, semantic check bypass, permission violation

- why do you think this is a vulerability
- try to estimate the score
  - report confidence (confirmed/unknown)
  - remediation level (temp fix/no fix)
  - maturity (proof of concept, functional, in use)

