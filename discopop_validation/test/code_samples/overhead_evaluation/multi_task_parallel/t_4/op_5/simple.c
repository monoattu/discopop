int main()
{
    int x0=0, x1=0, x2=0;
    int y0=0, y1=0, y2=0;
    int z0=0, z1=0, z2=0;
    int a0=0, a1=0, a2=0;
    #pragma omp parallel
    {
        #pragma omp single
        {
            #pragma omp task depend(out:x0)
            {
                x0 = x0 + 1; x1 = x1 + 1; x2 = 1;
            }
            #pragma omp task depend(inout:x0)
            {
                y0 = y0 + 1; y1 = y1 + 1; y2 = 1;
            }
            #pragma omp task depend(inout:x0)
            {
                z0 = z0 + 1; z1 = z1 + 1; z2 = 1;
            }
            #pragma omp task depend(in:x0)
            {
                a0 = a0 + 1; a1 = a1 + 1; a2= 1;
            }
        }
    }
}
