import sys; import math; import numpy as np
from perceptron import perceptron; from confus import confus
from linmach import linmach

if len(sys.argv) != 4:
    print('Usage: %s <data> <alphas> <bs>' % sys.argv[0])
    sys.exit(1)

data = np.loadtxt(sys.argv[1]) # archivo dataset   
alphas = np.fromstring(sys.argv[2], sep = ' ') # factores aprendizaje 
bs = np.fromstring(sys.argv[3], sep = ' ') # margenes
#r etrieve data parameters
N,L = data.shape; D=L-1
labs=np.unique(data[:,D])
C=labs.size
# shuffle data
np.random.seed(23)
perm = np.random.permutation(N)
data = data[perm]
# set training set and testing set
NTr = int(round(.7*N));
train = data[:NTr,:];
M = N - NTr;
test = data[NTr:,:];

# print headers
print('#     a        b   E   k  Ete  Ete(%)     Ite [] \n');
print('#------- -------- --- --- --- ------- ----------\n');


for a in alphas:
    for b in bs:
        w,E,k=perceptron(train,b,a); rl=np.zeros((M,1));
        rl = np.zeros((M,1))
        for m in range(M):
            tem = np.concatenate(([1], test[m,:D]))
            # estimate class
            rl[m] = labs[linmach(w,tem)]
        # calculate error (nerr)
        ner,m = confus(test[:,L-1].reshape(M,1), rl) # ner is the number of errors (Ete) and m is the confus matrix 
        # calculate estimated error and confidence interval
        per = ner/M; # estimated error Ete %
        r = 1.96*math.sqrt(per*(1-per)/M)
        I=[per-r, per+r] # confidence interval 
        # print results
        print('%8.1f %8.1f %3d %3d %3d %5.1f   [%.1f,%2.1f] ' % ( a, b, E, k, ner, per*100, I[0]*100, I[1]*100))
print('\n')


     

# E misclassified samples in thetraining set with Perceptron
# k needed iterations or made ones
# Ete errors made in the testing set , ner
# Ete % is the estimated error , per p with hat
# Ite % IC






