* Vectors.asm - reset vector for C programs

        .global _c_int00
        .sect   "vectors"

reset   b       _c_int00        ; reset vector
        nop
        nop


