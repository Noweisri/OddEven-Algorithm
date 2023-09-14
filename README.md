# OddEven-Algorithm
# PLEASE NOTE THAT THIS FILE MAY NOT WORK PROPERLY WITHOUT USING THE NVIDIA CUDA TOOLKIT.

The odd-even sort algorithm is a simple sorting algorithm that works by repeatedly comparing adjacent elements and swapping them if they are in the wrong order.

The code is executed on the GPU by calling the oddevensort() function with the array to be sorted and its size as arguments. The function is Only for swapping, while the loop is in the host.

Each iteration calls the function two times, one for the odd thread (index), and one for the even thread (index).

The odd-even sort algorithm is a simple and efficient sorting algorithm for small arrays. However, it is not as efficient as other sorting algorithms, such as merge sort or quicksort, for large arrays.
