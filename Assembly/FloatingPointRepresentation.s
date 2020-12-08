                .globl  __start
                .text 0x00400000

__start:        li.s $f0, -1.5      # 1.5  Float SP
                li.d $f2, 8.75      # 8.75 Float DP

                li $t0, 0xff800000  # -∞ (-Infinity -> S=1, E=11...1, M=00...0)
                mtc1 $t0, $f12      # move $t0 (0xff800000) to $f12 (CPU to FPU)
                li $t1, 0x7f8003a0  # NaN (Not a Number -> S=x, E=11...1,M!=0)
                mtc1 $t1, $f20      # (CPU to FPU)

                li.s $f4, 78.325    # 78.325  Float SP
                li.d $f6, 78.325    # 78.325  Float DP
