from Bio.Seq import Seq
import sys

seq = Seq(sys.argv[1])

print seq.reverse_complement()
